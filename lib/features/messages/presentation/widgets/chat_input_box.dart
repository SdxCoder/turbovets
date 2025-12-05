import 'package:flutter/material.dart';

import '../../../../core/themes/spacings.dart';

class ChatInputBox extends StatefulWidget {
  final Function(String message) onSend;
  final VoidCallback onAttachFile;
  final bool isSending;
  const ChatInputBox({
    super.key,
    required this.onSend,
    required this.onAttachFile,
    this.isSending = false,
  });

  @override
  State<ChatInputBox> createState() => _ChatInputBoxState();
}

class _ChatInputBoxState extends State<ChatInputBox> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: Spacing.sm),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          border: Border(
            top: BorderSide(color: Theme.of(context).colorScheme.outline),
          ),
        ),
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.attach_file),
              onPressed: widget.onAttachFile,
            ),
            Expanded(
              child: TextField(
                controller: _controller,
                maxLines: 5,
                minLines: 1,
                textInputAction: TextInputAction.newline,
                decoration: const InputDecoration(
                  hintText: 'Send a message',
                  border: InputBorder.none,
                ),
                onSubmitted: (value) {
                  if (!widget.isSending && value.trim().isNotEmpty) {
                    widget.onSend(_controller.text);
                    _controller.clear();
                  }
                },
              ),
            ),
            IconButton(
              icon: widget.isSending
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Icon(
                      Icons.send,
                      color: Theme.of(context).colorScheme.primary,
                    ),
              onPressed: widget.isSending
                  ? null
                  : () {
                      if (_controller.text.trim().isNotEmpty) {
                        widget.onSend(_controller.text);
                        _controller.clear();
                      }
                    },
            ),
          ],
        ),
      ),
    );
  }
}
