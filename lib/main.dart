import 'package:flutter/material.dart';
import 'package:moto_maintenance/src/models/user.dart';
import 'package:moto_maintenance/src/models/validation/signin_validation.dart';
import 'package:moto_maintenance/src/models/validation/signup_validation.dart';
import 'package:moto_maintenance/src/routes.dart';
import 'package:moto_maintenance/src/screens/home_screen.dart';
import 'package:moto_maintenance/src/screens/signin_screen.dart';
import 'package:moto_maintenance/src/services/firebase_auth_service.dart';
import 'package:provider/provider.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => SigninValidation()),
          ChangeNotifierProvider(create: (context) => SignupValidation()),
          StreamProvider<User>.value(value: FirebaseAuthService().onAuthStateChanged),
        ],
        child: MaterialApp(
        title: 'Moto Maintenance',
        home: CheckAuthState(),
        onGenerateRoute: Routes.materialRoutes,
      ),
    );
  }
}


class CheckAuthState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return (user == null) ? SignIn() : Home();
  }
}

// TODO: add license info for google fonts package and any other packages. more info @ https://pub.dev/packages/google_fonts#-readme-tab-

