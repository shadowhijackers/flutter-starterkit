import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String get API_URL => dotenv.env['API_URL'] ?? 'https://jsonplaceholder.typicode.com';
}