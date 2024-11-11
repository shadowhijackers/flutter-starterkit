import 'package:starter_kit/src/domain/entities/user.dart';
import 'package:starter_kit/src/domain/value_objects/email.dart';

abstract class UserRepository{
  Future<User> login(Email email, String password);
}