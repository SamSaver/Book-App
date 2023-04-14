import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import './firebase_options.dart';

import 'views/home.dart';
import 'views/signin.dart';

void main() async {
  // Initialize firebase app
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Books App',
      theme:
          ThemeData(primaryColor: Colors.white30, primarySwatch: Colors.amber),
      home: const SignIn(),
    );
  }
}
