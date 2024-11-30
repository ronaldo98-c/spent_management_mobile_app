import 'package:equatable/equatable.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends AppEvent {}

class LoggedIn extends AppEvent {}

class LoggedOut extends AppEvent {}

class LoginRequested extends AppEvent {
  final String username;
  final String password;

  const LoginRequested({required this.username, required this.password});

  @override
  List<Object> get props => [username, password];
}

class SignInRequested extends AppEvent {
  final String name;
  final String email;
  final String password;

  const SignInRequested({required this.name, required this.email,  required this.password});

  @override
  List<Object> get props => [name, email, password];
}