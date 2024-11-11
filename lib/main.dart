import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'routes.dart';
import 'dart:io';

void main() async {
  try {
    // Attempt to load the .env file
    await dotenv.load(fileName: ".env");
    print("Successfully loaded the .env file.");

    runApp(MyApp());
  } catch (e) {
    print("Error loading .env file: $e");
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      onGenerateRoute: routes
    );
  }
}