import 'package:flutter/material.dart';
import 'package:meatzy_app/Screen/Auth/user_sign_in.dart';
import 'package:meatzy_app/Screen/Auth/user_sign_up.dart';

class Toggle extends StatefulWidget {
  const Toggle({Key? key}) : super(key: key);

  @override
  State<Toggle> createState() => _AuthState();

  static String _route = '/toggle';

  static get route => _route;
}

class _AuthState extends State<Toggle> {
  bool showSignIn = true;

  void toggleview() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignUpScreen(toggleView: toggleview);
    } else {
      return LoginScreen(toggleView: toggleview);
    }
  }
}
