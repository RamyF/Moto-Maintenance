import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moto_maintenance/src/models/validation/signin_validation.dart';
import 'package:moto_maintenance/src/services/facebook_service.dart';
import 'package:moto_maintenance/src/services/firebase_auth_service.dart';
import 'package:moto_maintenance/styles.dart';
import 'package:provider/provider.dart';



class SignIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SigninValidation signinVal = Provider.of<SigninValidation>(context);
    final FirebaseAuthService _auth = FirebaseAuthService();
    final FacebookService fbservice = FacebookService();
    

    return Scaffold(
      body: Builder(
        builder: (context) => Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/background.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              height: double.infinity,
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(
                  horizontal: 40.0,
                  vertical: 120.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: Text(
                        'Sign In',
                        style: GoogleFonts.openSans(
                          fontSize: 40.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * .10),
                    _emailField(signinVal),
                    SizedBox(height: 50.0),
                    _passwordField(signinVal),
                    Container(
                      alignment: Alignment.centerRight,
                      child: _forgotPasswordButton(),
                    ),
                    _loginButton(context, _auth, signinVal),
                    SizedBox(height: 10.0),
                    Text(
                      '- OR -',
                      style: GoogleFonts.openSans(
                          color: Colors.white,
                          fontSize: 18.0,
                          letterSpacing: 2.0),
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: _fbButton(fbservice),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: _googleButton(),
                        ),
                      ],
                    ),
                    SizedBox(height: 25.0),
                    _signUpButton(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _emailField(SigninValidation signinVal) {
    return Container(
      alignment: Alignment.center,
      child: TextField(
        enableSuggestions: true,
        onChanged: (String val) {
          signinVal.changeEmail(val);
          signinVal.isValidated();
        },
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          errorText: signinVal.email.error,
          enabledBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
            color: Colors.blueAccent,
          )),
          hintText: 'Email',
          hintStyle: TextStyle(
            color: Colors.grey[400],
            fontWeight: FontWeight.w500,
          ),
          contentPadding: EdgeInsets.only(top: 14.0),
          prefixIcon: Icon(
            Icons.email,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _passwordField(SigninValidation signinVal) {
    return Container(
      alignment: Alignment.center,
      child: TextField(
        enableSuggestions: false,
        onChanged: (String val) {
          signinVal.changePassword(val);
          signinVal.isValidated();
        },
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          errorText: signinVal.password.error,
          enabledBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.blueAccent)),
          hintText: 'Password',
          hintStyle: TextStyle(
            color: Colors.grey[400],
            fontWeight: FontWeight.w500,
          ),
          contentPadding: EdgeInsets.only(top: 14.0),
          prefixIcon: Icon(
            Icons.lock_outline,
            color: Colors.white,
          ),
        ),
        obscureText: true,
      ),
    );
  }

  //***************TODO */
  Widget _forgotPasswordButton() {
    return FlatButton(
      child: Text(
        'Forgot Password?',
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () => print('forgot password clicked'),
    );
  }

  Widget _loginButton(BuildContext context, FirebaseAuthService auth,
      SigninValidation signinVal) {
    return SizedBox(
      height: 100.0,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 25.0),
        width: double.infinity,
        child: RaisedButton(
          onPressed: signinVal.isValidated()
              ? () async {
                  try {
                    String email = signinVal.email.value.trim();
                    String password = signinVal.password.value.trim();
                    await auth.signInWithEmailAndPassword(email, password);
                  } catch (e) {
                    String errorCode = e.code;
                    String errorMsg = parseError(errorCode);
                    Scaffold.of(context).showSnackBar(_messageSnackbar(errorMsg));
                  }
                }
              : null,
          disabledColor: AppStyles.disabledButtonColor,
          disabledTextColor: Colors.black,
          textColor: Colors.white,
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          color: AppStyles.primaryColor,
          child: Text(
            'LOGIN',
            style: GoogleFonts.openSans(
              fontSize: 18.0,
              letterSpacing: 1.5,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _fbButton(FacebookService fbService) {
    return GestureDetector(
      onTap: () => fbService.signIn(),
      child: Container(
        height: 60.0,
        width: 60.0,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(0, 2),
                blurRadius: 6.0,
              ),
            ],
            image: DecorationImage(
                image: AssetImage('assets/images/facebooklogo.png'))),
      ),
    );
  }
  

  Widget _googleButton() {
    return GestureDetector(
      onTap: () => print('sign with google'),
      child: Container(
        height: 60.0,
        width: 60.0,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(0, 2),
                blurRadius: 6.0,
              ),
            ],
            image: DecorationImage(
                image: AssetImage('assets/images/googlelogo.jpg'))),
      ),
    );
  }

  Widget _signUpButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Don\'t have an account?',
          style: GoogleFonts.openSans(
            color: Colors.grey[400],
            fontWeight: FontWeight.w700,
          ),
        ),
        FlatButton(
          onPressed: () => Navigator.pushNamed(context, '/SignUp'),
          textColor: Colors.white,
          child: Text(
            'Sign Up',
            style: GoogleFonts.openSans(
                fontWeight: FontWeight.w800, fontSize: 18.0),
          ),
        ),
      ],
    );
  }

  Widget _messageSnackbar(String errorTxt) {
    return SnackBar(
      content: Text(errorTxt),
      backgroundColor: AppStyles.primaryColor,
      duration: Duration(seconds: 2),
    );
  }

  // parses error code from Firebase auth signup
  String parseError(String errorCode) {
    switch (errorCode) {
      case "ERROR_INVALID_EMAIL":
        return "Your email address is invalid.";
        break;
      case "ERROR_WRONG_PASSWORD":
        return "Your password is incorrect.";
        break;
      case "ERROR_USER_NOT_FOUND":
        return "User does not exist.";
        break;
      case "ERROR_USER_DISABLED":
        return "User with this email has been disabled.";
        break;
      case "ERROR_TOO_MANY_REQUESTS":
        return "Too many requests. Try again later.";
        break;
      case "ERROR_OPERATION_NOT_ALLOWED":
        return "Signing in with Email and Password is not enabled.";
        break;
      default:
        return "An undefined Error happened.";
    }
  }
}

// TODO: change fontstyle to opensans
