import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moto_maintenance/styles.dart';

class SignIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
                  _emailField(),
                  SizedBox(height: 50.0),
                  _passwordField(),
                  Container(
                    alignment: Alignment.centerRight,
                    child: _forgotPasswordButton(),
                  ),
                  _loginButton(),
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
                        child: _fbButton(),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: _googleButton(),
                      ),
                    ],
                  ),
                  SizedBox(height: 25.0),
                  _signUpButton(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _emailField() {
    return Container(
      alignment: Alignment.center,
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
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

  Widget _passwordField() {
    return Container(
      alignment: Alignment.center,
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white)),
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
            suffixIcon: IconButton(
                icon: Icon(
                  Icons.remove_red_eye,
                  color: Colors.white,
                ),
                onPressed: () => print('todo'))),
        obscureText: true,
      ),
    );
  }

  Widget _forgotPasswordButton() {
    return FlatButton(
      child: Text(
        'Forgot Password?',
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () => print('forgot password clicked'),
    );
  }

  Widget _loginButton() {
    return SizedBox(
      height: 100.0,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 25.0),
        width: double.infinity,
        child: RaisedButton(
          textColor: Colors.white,
          elevation: 5.0,
          onPressed: () => print('log in'),
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

  Widget _fbButton() {
    return GestureDetector(
      onTap: () => print('sign with fb'),
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

  Widget _signUpButton() {
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
          onPressed: () => print('sign up'),
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
}

// TODO: change fontstyle to opensans
