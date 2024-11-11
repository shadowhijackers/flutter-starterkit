import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter_kit/src/application/events/login_event.dart';
import 'package:starter_kit/src/application/states/login_state.dart';
import 'package:starter_kit/src/application/usecases/login_user_app_use_case.dart';
import 'package:starter_kit/src/domain/value_objects/email.dart';

import '../../core/exceptions/auth_exception.dart';
import '../../domain/entities/user.dart';

class LoginBLoC extends Bloc<LoginEvent, LoginState>{
  final LoginUserAppUseCase loginApplicationUseCase;

// Constructor for the LoginBloc
  LoginBLoC(this.loginApplicationUseCase) : super(LoginInitial()) {
    // Registering the event handler for LoginRequested
    on<LoginRequested>((event, emit) async {
      // Emit the loading state
      emit(LoginInProgress());

      try {
        // Simulate the login process (Replace with your repository call)
        User user = await loginApplicationUseCase.execute(Email(event.email), event.password);

        // Emit the success state with the user object
        emit(LoginSuccess(user));
      } catch (e) {
        // Emit the failure state with an error message
        emit(LoginFailure(e is AuthException ? e.message : 'Unknown error'));
      }
    });
  }

}