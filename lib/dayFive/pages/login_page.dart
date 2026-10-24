import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/dayFive/components/my_button.dart';
import 'package:flutter_firebase_app/dayFive/components/my_textfield.dart';

class LoginPage extends StatelessWidget {
  //text controller
  TextEditingController emailController = TextEditingController();

  TextEditingController passWordController = TextEditingController();
  LoginPage({super.key});

  //login method
  void login() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //logo
              Icon(
                Icons.person,
                size: 80,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              const SizedBox(height: 20),

              //app name
              const Text('M I N I M A L', style: TextStyle(fontSize: 20)),
              const SizedBox(height: 50),
              //email textfield
              MyTextfield(
                hintText: "EMAIL",
                obscureText: false,
                controller: emailController,
              ),
              SizedBox(height: 10),
              //password textfield
              MyTextfield(
                hintText: "PASSWORD",
                obscureText: true,
                controller: passWordController,
              ),
              const SizedBox(height: 10),
              //forget password
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Forget Password',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              //sign in button
              MyButton(text: 'Log In', onTap: login),
              const SizedBox(height: 25),
              //don't have account? Register here],),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?  ",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      "Register Here",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
