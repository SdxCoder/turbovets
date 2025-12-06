import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:turbovetschat/core/errors/result.dart';
import 'package:turbovetschat/features/auth/domain/entities/user.dart';
import 'package:turbovetschat/features/auth/domain/usecases/get_current_user.dart';
import 'package:turbovetschat/features/auth/presentation/bloc/user_state.dart';

@injectable
class UserCubit extends Cubit<UserState> {
  UserCubit(this._getCurrentUser) : super(UserState.initial());

  final GetCurrentUser _getCurrentUser;

  Future<void> loadUser() async {
    emit(state.copyWith(isLoading: true));
    final result = await _getCurrentUser();
    emit(state.copyWith(isLoading: false));
    switch (result) {
      case Success(:final data):
        emit(state.copyWith(user: data.user));
      case Error():
        emit(state.copyWith(user: const User.empty()));
    }
  }
}
