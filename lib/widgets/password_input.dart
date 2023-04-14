import 'package:flutter/material.dart';

class PasswordInput extends StatelessWidget {
  const PasswordInput(
      {super.key,
      required this.password,
      required this.passwordVisibility,
      required this.controller,
      required this.onVisibilityChange});

  final String password;
  final bool passwordVisibility;
  final TextEditingController controller;
  final void Function() onVisibilityChange;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: !passwordVisibility,
      style: const TextStyle(
        fontSize: 16,
        color: Colors.white,
      ),
      decoration: InputDecoration(
        hintText: 'Password',
        hintStyle: const TextStyle(
          color: Colors.white54,
          fontSize: 16,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            // Based on passwordVisible state choose the icon
            passwordVisibility ? Icons.visibility : Icons.visibility_off,
            color: Theme.of(context).primaryColorDark,
          ),
          onPressed: onVisibilityChange,
        ),
      ),
      controller: controller,
      validator: ((value) => value!.isEmpty ? 'Enter Password' : null),
    );
  }
}
