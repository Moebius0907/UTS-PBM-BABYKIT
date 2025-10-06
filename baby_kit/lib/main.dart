import 'package:baby_kit/login.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // hilangin tulisan debug
      theme: ThemeData(
        fontFamily: "Poppins", // font global
      ),
      home: const Login(), // halaman pertama
    );
  }
}

