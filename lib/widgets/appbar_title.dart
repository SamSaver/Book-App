import 'package:flutter/material.dart';

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(
          fontSize: 22,
        ),
        children: <TextSpan>[
          const TextSpan(
            text: 'Quiz',
            style: TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.w600,
            ),
          ),
          TextSpan(
            text: 'Maker',
            style: TextStyle(
              color: Colors.blue[300],
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
