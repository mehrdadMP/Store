part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthScreenStarted extends AuthEvent{}

class AuthButtonIsClicked extends AuthEvent {
  final String username;
  final String password;

  const AuthButtonIsClicked(this.username, this.password);
}

class AuthModeChangeClicked extends AuthEvent {}
