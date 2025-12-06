import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:turbovetschat/core/errors/result.dart';

import '../../../auth/domain/usecases/get_current_user.dart';
import 'splash_state.dart';

@injectable
class SplashCubit extends Cubit<SplashState> {
  SplashCubit(this._getCurrentUser) : super(const SplashInitial());

  final GetCurrentUser _getCurrentUser;

  Future<void> checkSession() async {
    emit(const SplashChecking());

    final result = await _getCurrentUser();
    switch (result) {
      case Success(:final data):
        if (data.isAuthenticated) {
          emit(const SplashAuthenticated());
        } else {
          emit(const SplashUnauthenticated());
        }
      default:
        break;
    }
  }
}
