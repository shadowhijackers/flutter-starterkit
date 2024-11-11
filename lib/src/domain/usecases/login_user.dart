import '../entities/user.dart';
import '../value_objects/email.dart';
import '../repositories/user_repository.dart';

class LoginUser {
  final UserRepository userRepository;

  LoginUser(this.userRepository);

  Future<User> call(Email email, String password) async {
    // Business logic for logging in
    return await userRepository.login(email, password);
  }
}