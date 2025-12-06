import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:turbovetschat/config/routes/app_router.dart';

import '../../../../core/errors/result.dart';
import '../../domain/usecases/login.dart';
import '../../domain/value_objects/email.dart';
import '../../domain/value_objects/password.dart';
import 'login_state.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._login) : super(LoginState.initial());

  final Login _login;

  void emailChanged(String? value) {
    final email = Email(value);
    emit(state.copyWith(email: email, failure: null));
  }

  void passwordChanged(String? value) {
    final password = Password(value);
    emit(state.copyWith(password: password, failure: null));
  }

  Future<void> loginSubmitted(StackRouter appRouter) async {
    if (!state.isFormValid) {
      return;
    }

    emit(state.copyWith(isLoading: true, failure: null));

    final result = await _login(
      email: state.email.value,
      password: state.password.value,
    );

    switch (result) {
      case Success():
        emit(state.copyWith(isLoading: false, failure: null));
        appRouter.replaceAll([const HomeRoute()]);
      case Error(:final failure):
        emit(state.copyWith(isLoading: false, failure: failure));
    }
  }
}
