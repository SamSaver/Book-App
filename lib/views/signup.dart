import 'package:flutter/material.dart';
import './signin.dart';
import '../widgets/amber_button.dart';
import '../widgets/email_input.dart';
import '../widgets/password_input.dart';
import '../services/auth.dart';

import 'home.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();

  bool isLoading = false, _passwordVisible = false;
  TextEditingController email_controller = TextEditingController();
  TextEditingController password_controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    email_controller.addListener(() {
      setState(() {});
    });

    password_controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    email_controller.dispose();
    password_controller.dispose();
    super.dispose();
  }

  void passwordVisibilityHandler() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  void signUp() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      AuthService authService = AuthService();
      await authService
          .signUpWithEmailAndPassword(
              context, email_controller.text, password_controller.text)
          .then((value) {
        setState(() {
          isLoading = false;
        });
        if (value != null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Home(user: value),
            ),
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Center(child: AppBarTitle()),
      //   backgroundColor: Colors.transparent,
      //   elevation: 0.0,
      //   systemOverlayStyle: SystemUiOverlayStyle.light,
      // ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Stack(fit: StackFit.expand, children: [
              const Image(
                image: AssetImage('assets/book.jpg'),
                fit: BoxFit.cover,
                colorBlendMode: BlendMode.darken,
                color: Colors.black54,
              ),
              Form(
                key: _formKey,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  child: Column(
                    children: [
                      const Spacer(),
                      EmailTextInput(
                        emailId: email_controller.text,
                        controller: email_controller,
                      ),
                      const SizedBox(height: 6),
                      PasswordInput(
                          password: password_controller.text,
                          passwordVisibility: _passwordVisible,
                          controller: password_controller,
                          onVisibilityChange: passwordVisibilityHandler),
                      const SizedBox(height: 24),
                      AmberButton(
                          buttonText: "Sign Up",
                          onPressed: signUp,
                          buttonWidth: MediaQuery.of(context).size.width - 48),
                      const SizedBox(height: 18),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Already have an account? ",
                            style:
                                TextStyle(fontSize: 15.5, color: Colors.white),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const SignIn()));
                            },
                            child: const Text(
                              'Sign In',
                              style: TextStyle(
                                  fontSize: 15.5,
                                  decoration: TextDecoration.underline,
                                  color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 50),
                    ],
                  ),
                ),
              ),
            ]),
    );
  }
}
