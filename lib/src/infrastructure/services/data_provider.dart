import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../config/environment.dart';
import '../../core/models/user_model.dart';
import '../../domain/entities/user.dart';
import '../../domain/value_objects/email.dart';

class DataProvider {

  Future<User> login(Email email, String password) async {
    final response = await http.get(Uri.parse('${Environment.API_URL}/users'));
    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON.
      List data = json.decode(response.body);
      print('data ${data}');
      return UserModel.fromJson(data[0]);
    } else {
      // If the server did not return a 200 OK response, throw an exception.
      throw Exception('Failed to load data');
    }
  }
}