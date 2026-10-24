import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/dayOne/loginPage/home_page.dart';
import 'package:flutter_firebase_app/dayOne/loginPage/login_autentication.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;

    return Scaffold(
      body: StreamBuilder<User?>(
        stream: auth.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return HomePage();
          } else {
            return LoginAutentication();
          }
        },
      ),
    );
  }
}
