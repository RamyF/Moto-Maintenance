import 'package:flutter/material.dart';
import 'package:moto_maintenance/src/screens/home_screen.dart';
import 'package:moto_maintenance/src/screens/signin_screen.dart';
import 'package:moto_maintenance/src/screens/signup_screen.dart';


abstract class Routes {

  static MaterialPageRoute materialRoutes (RouteSettings settings) {

    switch(settings.name){
      case '/Home':
      return MaterialPageRoute(builder: (context) => Home());
      break;
      case '/SignUp':
      return MaterialPageRoute(builder: (context) => SignUp());
      break;
      case '/SignIn':
      return MaterialPageRoute(builder: (context) => SignIn());
      break;
      default:
      return MaterialPageRoute(builder: (context) => SignIn());
      break;
    }
  }
}