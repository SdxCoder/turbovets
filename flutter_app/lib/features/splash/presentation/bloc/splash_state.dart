import 'package:equatable/equatable.dart';

sealed class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object?> get props => [];
}

class SplashInitial extends SplashState {
  const SplashInitial();
}

class SplashChecking extends SplashState {
  const SplashChecking();
}

class SplashAuthenticated extends SplashState {
  const SplashAuthenticated();
}

class SplashUnauthenticated extends SplashState {
  const SplashUnauthenticated();
}
