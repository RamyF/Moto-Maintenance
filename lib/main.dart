import 'package:flutter/material.dart';
import 'package:moto_maintenance/src/routes.dart';
import 'package:moto_maintenance/src/screens/signin_screen.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Moto Maintenance',
      home: SignIn(),
      onGenerateRoute: Routes.materialRoutes,
    );
  }
}


// TODO: add license info for google fonts package and any other packages. more info @ https://pub.dev/packages/google_fonts#-readme-tab-

