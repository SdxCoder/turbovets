import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/register_cubit.dart';
import '../bloc/register_state.dart';

class RegisterNameInput extends StatelessWidget {
  const RegisterNameInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<RegisterCubit, RegisterState, (String, bool, bool)>(
      selector: (state) =>
          (state.name.value, state.name.isValid, state.name.value.isNotEmpty),
      builder: (context, nameState) {
        final (nameValue, isValid, isNotEmpty) = nameState;
        return TextFormField(
          decoration: InputDecoration(
            labelText: 'Name',
            errorText: isNotEmpty && !isValid
                ? 'Please enter a valid name'
                : null,
          ),
          onChanged: (value) {
            context.read<RegisterCubit>().nameChanged(value);
          },
        );
      },
    );
  }
}
