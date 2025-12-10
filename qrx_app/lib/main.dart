import 'package:flutter/material.dart';
import 'home_screen.dart';

void main() {
  runApp(const QRxApp());
}

class QRxApp extends StatelessWidget {
  const QRxApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QRx',
      home: HomeScreen(),
    );
  }
}
