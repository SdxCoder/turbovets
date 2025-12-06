import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/login_cubit.dart';
import '../bloc/login_state.dart';

class LoginEmailInput extends StatelessWidget {
  const LoginEmailInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<LoginCubit, LoginState, (String, bool, bool)>(
      selector: (state) => (
        state.email.value,
        state.email.isValid,
        state.email.value.isNotEmpty,
      ),
      builder: (context, emailState) {
        final (emailValue, isValid, isNotEmpty) = emailState;
        return TextFormField(
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: 'Email',
            errorText: isNotEmpty && !isValid
                ? 'Please enter a valid email'
                : null,
          ),
          onChanged: (value) {
            context.read<LoginCubit>().emailChanged(value);
          },
        );
      },
    );
  }
}
