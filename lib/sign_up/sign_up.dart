import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutterall/component/my_button.dart';
import 'package:flutterall/component/my_iconbutton.dart';
import 'package:flutterall/component/my_textbutton.dart';
import 'package:flutterall/component/my_textfield.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  createUserWithEmailAndPassword() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);

      _showMyDialog('Success', 'Register successful.');
    } on FirebaseAuthException catch (e) {
      print('Failed, with error code: ${e.code}');
      print(e.message);

      if (e.code == 'invalid-email') {
        _showMyDialog('Error', 'No user found for the email.');
      } else if (e.code == 'email-already-in-use') {
        _showMyDialog('Error', 'Email already in use.');
      }
    }
  }

void _showMyDialog(String title, String message) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Expanded(
          child: AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, 'OK'),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      },
    );
  }

  void signUpUser() async {
    if (emailController.text != "" && passwordController.text != "") {
      print("It's ok");
    } else {
      print('Please input your email and password.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 120, 119, 119),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
        child: Form(
          child: Column(
            children: [
              const Spacer(),
              Text(
                "Hello, ready to get started?",
                textAlign: TextAlign.center,
                style: GoogleFonts.openSans(
                  textStyle: Theme.of(context).textTheme.displayLarge,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                  color: const Color.fromARGB(255, 255, 255, 255),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Please sign up with your email and password",
                textAlign: TextAlign.center,
                style: GoogleFonts.openSans(
                  textStyle: Theme.of(context).textTheme.displaySmall,
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                  fontStyle: FontStyle.italic,
                  color: const Color.fromARGB(255, 255, 255, 255),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              MyTextField(
                controller: emailController,
                hintText: 'Enter your email',
                labelText: 'Email',
                obscureText: false,
              ),
              const SizedBox(
                height: 20,
              ),
              MyTextField(
                controller: passwordController,
                hintText: 'Enter your password',
                labelText: 'Password',
                obscureText: true,
              ),
              const SizedBox(
                height: 20,
              ),
              MyTextField(
                controller: passwordController,
                hintText: 'Confirm your password',
                labelText: 'Confirm Password',
                obscureText: true,
              ),
              const SizedBox(
                height: 25,
              ),

              const SizedBox(
                height: 25,
              ),
              MyButton(
                  onTap: createUserWithEmailAndPassword, hintText: 'Sign Up'),

              const SizedBox(
                height: 25,
              ),
              //Icon button
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 1,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        'Or continue with',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255)),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 1,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyIconButton(imagePath: 'assets/images/google.png'),
                  MyIconButton(imagePath: 'assets/images/Discord.png'),
                  MyIconButton(imagePath: 'assets/images/Steam.png'),
                ],
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyIconButton(imagePath: 'assets/images/EA.png'),
                  MyIconButton(imagePath: 'assets/images/Battlenet.png'),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already a member?',
                      style: GoogleFonts.openSans(
                        textStyle: Theme.of(context).textTheme.displaySmall,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.italic,
                        color: const Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                    const MyTextButton(
                      lableText: 'login now',
                      pageRoute: 'login',
                    ),
                  ],
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
