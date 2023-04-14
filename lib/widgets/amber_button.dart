import 'package:flutter/material.dart';

class AmberButton extends StatelessWidget {
  const AmberButton(
      {super.key,
      required this.buttonText,
      required this.onPressed,
      required this.buttonWidth});

  final String buttonText;
  final Function() onPressed;
  final double? buttonWidth;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 16),
        width: buttonWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.amber,
        ),
        child: Text(
          buttonText,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16),
        ),
      ),
    );
  }
}
