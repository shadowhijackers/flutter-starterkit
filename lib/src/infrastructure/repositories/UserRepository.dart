import 'package:starter_kit/src/core/models/user_model.dart';

import '../../domain/entities/user.dart';
import '../../domain/value_objects/email.dart';
import '../../domain/repositories/user_repository.dart';
import '../services/data_provider.dart';

class UserRepositoryImpl implements UserRepository{
  DataProvider dataProvider = DataProvider();

  @override
  Future<User> login(Email email, String password) async{
    return await dataProvider.login(email, password);
  }

}