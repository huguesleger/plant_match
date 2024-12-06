import 'package:flutter/material.dart';
import 'package:plant_match/feature/auth/presentation/sign_in/presentation/sign_in_page.dart';
import 'package:plant_match/feature/auth/presentation/sign_up/presentation/sign_up_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool showSignIn = true;

  void toggleAuth() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignInPage(toggleAuth: toggleAuth);
    } else {
      return const SignUpPage();
    }
  }
}
