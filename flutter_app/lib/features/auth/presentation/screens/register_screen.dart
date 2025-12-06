import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turbovetschat/config/injection/injection.dart';
import 'package:turbovetschat/core/errors/failure_message_mapper.dart';
import 'package:turbovetschat/core/themes/spacings.dart';

import '../bloc/register_cubit.dart';
import '../bloc/register_state.dart';
import '../widgets/register_name_input.dart';
import '../widgets/register_email_input.dart';
import '../widgets/register_password_input.dart';

@RoutePage()
class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<RegisterCubit>(),
      child: const RegisterView(),
    );
  }
}

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register', style: Theme.of(context).textTheme.titleMedium),
      ),
      body: SafeArea(
        child: BlocListener<RegisterCubit, RegisterState>(
          listener: (context, state) {
            if (state.failure != null) {
              final result = FailureMessageMapper.mapFailureToMessage(
                state.failure!,
              );
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(result.message)));
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(Spacing.lg),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const RegisterNameInput(),
                const SizedBox(height: Spacing.md),
                const RegisterEmailInput(),
                const SizedBox(height: Spacing.md),
                const RegisterPasswordInput(),
                const SizedBox(height: Spacing.lg),
                BlocSelector<RegisterCubit, RegisterState, bool>(
                  selector: (state) => state.isFormValid && !state.isLoading,
                  builder: (context, isEnabled) {
                    return BlocSelector<RegisterCubit, RegisterState, bool>(
                      selector: (state) => state.isLoading,
                      builder: (context, isLoading) {
                        return SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: isEnabled
                                ? () {
                                    context
                                        .read<RegisterCubit>()
                                        .registerSubmitted(context.router);
                                  }
                                : null,
                            child: isLoading
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  )
                                : const Text('Register'),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
