import 'package:firebase_crud/pages/login.dart';
import 'package:firebase_crud/pages/signup.dart';
import 'package:flutter/material.dart';

class LoginAndSignUp extends StatefulWidget {
  const LoginAndSignUp({super.key});

  @override
  State<LoginAndSignUp> createState() => _LoginAndSignUpState();
}

class _LoginAndSignUpState extends State<LoginAndSignUp> {
  bool isLogin = false;

  void togglePage() {
    setState(() {
      isLogin = !isLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLogin) {
      return signUp(
        onPressed: togglePage,
      );
    } else {
      return LoginScreen(
        onPressed: togglePage,
      );
    }
  }
}
