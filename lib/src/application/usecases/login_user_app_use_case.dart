import 'package:starter_kit/src/core/exceptions/auth_exception.dart';

import '../../domain/entities/user.dart';
import '../../domain/usecases/login_user.dart';
import '../../domain/value_objects/email.dart';
import '../../domain/repositories/user_repository.dart';

class LoginUserAppUseCase {
  final UserRepository userRepository;

  LoginUserAppUseCase(this.userRepository);

  Future<User> execute(Email email, String password) async {

    if (email.value == ''){
      throw AuthException('No Email id');
    }

    LoginUser loginUser = LoginUser(userRepository);
    final user = await loginUser.call(email, password);
    return user;
  }
}