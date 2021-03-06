import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:moto_maintenance/src/models/user.dart';
import 'package:http/http.dart' as http;

class FacebookService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void signIn() async {
    FacebookLogin facebookLogin = FacebookLogin();

    final result = await facebookLogin.logIn(['email']);
    final token = result.accessToken.token;
    final graphResponse = await http.get(
      'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${token}');
      print(graphResponse.body);
      if (result.status == FacebookLoginStatus.loggedIn) {
        final credential = FacebookAuthProvider.getCredential(
          accessToken: token
        );
        _auth.signInWithCredential(credential);
      }
  }
}