import 'package:flutter/material.dart';
import 'package:myroutine/screens/authenticate/register.dart';
import 'package:myroutine/screens/authenticate/sign_in.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool isSignedIn = true;
  void toggleView() {
    setState(() => isSignedIn = !isSignedIn);
  }

  @override
  Widget build(BuildContext context) {
    if (isSignedIn) {
      return SignIn(toggleView: toggleView);
    } else {
      return Register(toggleView: toggleView);
    }
  }
}