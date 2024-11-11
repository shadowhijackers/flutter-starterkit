import '../../domain/entities/user.dart';

abstract class LoginState {
  final User? user;
  const LoginState({this.user});
}

class LoginInitial extends LoginState {}

class LoginInProgress extends LoginState {}

class LoginSuccess extends LoginState {
  final User user;

  LoginSuccess(this.user){
    print('updated');
  }
}

class LoginFailure extends LoginState {
  final String errorMessage;

  LoginFailure(this.errorMessage);
}