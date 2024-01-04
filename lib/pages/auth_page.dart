import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crud/pages/login_or_signup.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else {
            if (snapshot.hasData) {
              return Home();
            } else {
              return const LoginAndSignUp();
            }
          }
        },
      ),
    );
  }
}
