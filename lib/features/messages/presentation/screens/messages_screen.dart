import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turbovetschat/config/injection/injection.dart';
import 'package:turbovetschat/config/routes/app_router.dart';

import '../../../../core/errors/failure_message_mapper.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/themes/spacings.dart';
import '../../../../core/widgets/animated_list_widget.dart';
import '../../../../core/widgets/image_picker_failure_dialog_widget.dart';
import '../../domain/entities/message.dart';
import '../bloc/messages_cubit.dart';
import '../bloc/messages_state.dart';
import '../widgets/chat_input_box.dart';
import '../widgets/left_message.dart';
import '../widgets/messages_app_bar.dart';
import '../widgets/right_message.dart';

@RoutePage()
class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key, @PathParam() required this.chatId});

  final String chatId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<MessagesCubit>()..getChatById(chatId),
      child: MessagesView(chatId: chatId),
    );
  }
}

class MessagesView extends StatefulWidget {
  const MessagesView({super.key, required this.chatId});

  final String chatId;

  @override
  State<MessagesView> createState() => _MessagesViewState();
}

class _MessagesViewState extends State<MessagesView> {
  final ScrollController _scrollController = ScrollController();

  void _handleSendMessage(String text, String currentUserId) {
    context.read<MessagesCubit>().sendTextMessage(
      chatId: widget.chatId,
      senderId: currentUserId,
      content: text,
    );
  }

  void _handleAttachFile(String currentUserId) {
    final cubit = context.read<MessagesCubit>();
    cubit.pickAndSendImage(chatId: widget.chatId, senderId: currentUserId);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<MessagesCubit, MessagesState>(
          listenWhen: (previous, current) => current.failure != null,
          listener: (context, state) {
            final failure = state.failure!;
            final failureMessage = FailureMessageMapper.mapFailureToMessage(
              failure,
            );

            switch (failure) {
              case ImagePickPermissionDeniedFailure():
              case ImagePickPlatformFailure():
                context.router.openDialog(
                  child: ImagePickerFailureDialog(
                    title: failureMessage.title,
                    message: failureMessage.message,
                  ),
                );
              case ImagePickCancelledFailure():
                break;
              default:
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(failureMessage.message)));
            }
          },
        ),
        BlocListener<MessagesCubit, MessagesState>(
          listenWhen: (previous, current) =>
              previous.messages.length != current.messages.length &&
              !current.isSending,
          listener: (context, state) {
            context.read<MessagesCubit>().markMessagesAsRead(widget.chatId);
          },
        ),
      ],
      child: BlocBuilder<MessagesCubit, MessagesState>(
        builder: (context, state) {
          final chat = state.chat;
          final currentUserId = chat.user.id;
          final isLoading = state.isLoading && state.messages.isEmpty;

          return Scaffold(
            appBar: MessagesAppBar(
              agentName: chat.agent.name,
              agentImageUrl: chat.agent.imageUrl,
              statusText: 'Online',
            ),
            body: isLoading
                ? const Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                      Expanded(
                        child: AnimatedListWidget<Message>(
                          items: state.messages,
                          keyExtractor: (message) => message.id,
                          controller: _scrollController,
                          reverse: true,
                          padding: const EdgeInsets.symmetric(
                            vertical: Spacing.sm,
                          ),
                          itemBuilder: (context, message, index) {
                            return message.isSelf
                                ? RightMessage(
                                    text: message.content.isNotEmpty
                                        ? message.content
                                        : null,
                                    timestamp: message.timestamp,
                                    images: message.media.isNotEmpty
                                        ? message.media
                                        : null,
                                  )
                                : LeftMessage(
                                    text: message.content.isNotEmpty
                                        ? message.content
                                        : null,
                                    avatarUrl: chat.agent.imageUrl,
                                    timestamp: message.timestamp,
                                    images: message.media.isNotEmpty
                                        ? message.media
                                        : null,
                                  );
                          },
                        ),
                      ),
                      ChatInputBox(
                        onSend: (text) =>
                            _handleSendMessage(text, currentUserId),
                        onAttachFile: () => _handleAttachFile(currentUserId),
                        isSending: state.isSending,
                      ),
                    ],
                  ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
