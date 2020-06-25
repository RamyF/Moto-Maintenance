import 'package:flutter/material.dart';
import 'package:moto_maintenance/src/services/firebase_auth_service.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FirebaseAuthService _auth = FirebaseAuthService();
    return Container(
      color: Colors.red,
      child: RaisedButton(
        child: Text("Log Out"),
        onPressed: () => _auth.signOut()),
    );
  }
}