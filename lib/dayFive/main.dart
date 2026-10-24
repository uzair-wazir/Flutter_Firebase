import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/dayFive/pages/login_page.dart';
import 'package:flutter_firebase_app/dayFive/theme/dark_mode.dart';
import 'package:flutter_firebase_app/dayFive/theme/light_theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
      theme: lightMode,
      darkTheme: darkMode,
    );
  }
}
