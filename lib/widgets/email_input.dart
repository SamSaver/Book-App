import 'package:flutter/material.dart';

class EmailTextInput extends StatelessWidget {
  const EmailTextInput(
      {super.key, required this.emailId, required this.controller});

  final String emailId;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autocorrect: false,
      textCapitalization: TextCapitalization.none,
      enableSuggestions: false,
      style: const TextStyle(
        fontSize: 16,
        color: Colors.white,
      ),
      decoration: const InputDecoration(
        hintText: 'Email',
        hintStyle: TextStyle(
          color: Colors.white54,
          fontSize: 16,
        ),
      ),
      controller: controller,
      validator: ((value) => value!.isEmpty || !value.contains('@')
          ? 'Please enter a valid Email'
          : null),
      keyboardType: TextInputType.emailAddress,
    );
  }
}
