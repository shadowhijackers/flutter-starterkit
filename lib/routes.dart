import 'package:flutter/material.dart';

import 'src/views/auth/login_page_with_bloc.dart';
import 'src/views/home/home_page.dart';

Route<dynamic> routes(RouteSettings setting){
  switch(setting.name){
    case '/':
      return MaterialPageRoute(builder: (context) => Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: LoginPageWithBloc(),
        ),
      ));
    case '/home':
      return MaterialPageRoute(builder: (context)=>HomePage());
    default:
      return MaterialPageRoute(builder: (context) => LoginPageWithBloc());
  }
}