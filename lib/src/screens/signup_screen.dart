import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moto_maintenance/src/models/validation/signup_validation.dart';
import 'package:moto_maintenance/src/services/firebase_auth_service.dart';
import 'package:provider/provider.dart';

import '../../styles.dart';

class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // provides validation for signup page
    SignupValidation signupVal = Provider.of<SignupValidation>(context);
    final FirebaseAuthService _auth = FirebaseAuthService();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
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
                  vertical: 100.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: Text(
                        'Sign Up',
                        style: GoogleFonts.openSans(
                          fontSize: 40.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * .10),
                    _emailField(signupVal),
                    SizedBox(height: 50.0),
                    _passwordField(signupVal),
                    SizedBox(height: 50.0),
                    _confirmedPasswordField(signupVal),
                    SizedBox(height: 30.0),
                    _signupButton(context, _auth, signupVal)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _emailField(SignupValidation signupVal) {
    return Container(
      alignment: Alignment.center,
      child: TextField(
        onChanged: (String val) {
          signupVal.changeEmail(val);
        },
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          errorText: signupVal.email.error,
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

  Widget _passwordField(SignupValidation signupVal) {
    return Container(
      alignment: Alignment.center,
      child: TextField(
        enableSuggestions: false,
        onChanged: (String val) {
          signupVal.changePassword(val);
        },
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          errorText: signupVal.password.error,
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
        obscureText: false,
      ),
    );
  }

  Widget _confirmedPasswordField(SignupValidation signupVal) {
    return Container(
      alignment: Alignment.center,
      child: TextField(
        enableSuggestions: false,
        onChanged: (String val) {
          signupVal.changeConfirmedPassword(val);
        },
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          errorText: signupVal.confirmedpassword.error,
          enabledBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.blueAccent)),
          hintText: 'Confirm Password',
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
        obscureText: false,
      ),
    );
  }

  Widget _signupButton(BuildContext context, FirebaseAuthService auth,
      SignupValidation signupVal) {
    return SizedBox(
      height: 100.0,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 25.0),
        width: double.infinity,
        child: RaisedButton(
          onPressed: signupVal.isValidated()
              ? () async {
                  try {
                    String email = signupVal.email.value.trim();
                    String password = signupVal.password.value.trim();
                    await auth.createUserWithEmailAndPassword(email, password);
                    Scaffold.of(context)
                        .showSnackBar(_messageSnackbar('Account created.'));
                    // delay popping Signup screen until snackbar completes duration
                    Future.delayed(
                      const Duration(seconds: 2, milliseconds: 500),
                      () => Navigator.pop(context)
                    );
                  } catch (e) {
                    String errorMsg = parseError(e.code);
                    Scaffold.of(context)
                        .showSnackBar(_messageSnackbar(errorMsg));
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
            'SIGN UP',
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

// snackbar for Firebase auth result
  Widget _messageSnackbar(String text) {
    return SnackBar(
      content: Text(text),
      backgroundColor: AppStyles.primaryColor,
      duration: Duration(seconds: 2),
    );
  }

// parses error code from Firebase auth signup
  String parseError(String errorCode) {
    switch (errorCode) {
      case "ERROR_EMAIL_ALREADY_IN_USE":
        return "This email is already in use.";
        break;
      case "ERROR_WEAK_PASSWORD":
        return "The entered password is not strong enough";
        break;
      case "ERROR_INVALID_EMAIL":
        return "Invalid email";
        break;
      default:
        return "An unknown error occured. Please try again";
    }
  }
}

// send email to confirm user
