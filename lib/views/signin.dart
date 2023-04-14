import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'signup.dart';
import '../widgets/amber_button.dart';
import '../widgets/email_input.dart';
import '../widgets/password_input.dart';
import '../services/auth.dart';
import '../widgets/appbar_title.dart';
import 'home.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();

  final email_controller = TextEditingController();
  final password_controller = TextEditingController();
  bool _passwordVisible = false;
  bool _isLoading = false;

  void passwordVisibilityHandler() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

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

  void signIn() async {
    if (_formKey.currentState!.validate()) {
      AuthService authService = AuthService();
      setState(() {
        _isLoading = true;
      });
      await authService
          .signInWithEmailAndPassword(
              context, email_controller.text, password_controller.text)
          .then((value) {
        setState(() {
          _isLoading = false;
        });
        if (value != null) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => Home(user: value)));
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
      //   iconTheme: const IconThemeData(color: Colors.black87),
      //   elevation: 0.0,
      //   systemOverlayStyle: SystemUiOverlayStyle.light,
      // ),
      body: _isLoading
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
                          buttonText: 'Sign In',
                          onPressed: signIn,
                          buttonWidth: MediaQuery.of(context).size.width - 48),
                      const SizedBox(height: 18),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't have an account? ",
                            style:
                                TextStyle(fontSize: 15.5, color: Colors.white),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const SignUp()));
                            },
                            child: const Text(
                              'Sign Up',
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
