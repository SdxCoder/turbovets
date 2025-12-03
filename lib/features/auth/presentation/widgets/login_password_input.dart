import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/login_cubit.dart';
import '../bloc/login_state.dart';

class LoginPasswordInput extends StatelessWidget {
  const LoginPasswordInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<LoginCubit, LoginState, (String, bool, bool)>(
      selector: (state) => (
        state.password.value,
        state.password.isValid,
        state.password.value.isNotEmpty,
      ),
      builder: (context, passwordState) {
        final (passwordValue, isValid, isNotEmpty) = passwordState;
        return TextFormField(
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Password',
            errorText: isNotEmpty && !isValid
                ? 'Password must be at least 6 characters'
                : null,
          ),
          onChanged: (value) {
            context.read<LoginCubit>().passwordChanged(value);
          },
        );
      },
    );
  }
}
