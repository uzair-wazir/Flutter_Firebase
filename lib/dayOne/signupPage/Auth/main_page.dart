import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/dayOne/signupPage/Auth/auth_page.dart';
import 'package:flutter_firebase_app/dayOne/signupPage/pages/home_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        {
          if (snapshot.hasData) {
            return HomePage();
          } else {
            return AuthPage();
          }
        }
      },
    );
  }
}
