import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/register_cubit.dart';
import '../bloc/register_state.dart';

class RegisterPasswordInput extends StatelessWidget {
  const RegisterPasswordInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<RegisterCubit, RegisterState, (String, bool, bool)>(
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
            context.read<RegisterCubit>().passwordChanged(value);
          },
        );
      },
    );
  }
}
