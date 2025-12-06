import 'package:equatable/equatable.dart';
import 'package:turbovetschat/features/auth/domain/entities/user.dart';

class UserState extends Equatable {
  const UserState({this.user = const User.empty(), this.isLoading = false});

  final User user;
  final bool isLoading;

  factory UserState.initial() {
    return const UserState();
  }

  UserState copyWith({User? user, bool? isLoading}) {
    return UserState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [user, isLoading];
}
