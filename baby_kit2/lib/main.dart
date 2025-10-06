import 'package:baby_kit2/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/cart_providers.dart'; 

// Fungsi utama yang dijalankan pertama kali saat aplikasi dimulai
void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => CartProvider())],

      child: const MyApp(),
    ),
  );
}

// Widget utama aplikasi
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Menghilangkan tulisan debug
      theme: ThemeData(
        fontFamily: "Poppins", // font global
      ),
      home: const Login(), // halaman pertama
    );
  }
}
