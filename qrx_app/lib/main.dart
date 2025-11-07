import 'package:flutter/material.dart';

void main() {
  runApp(const QRxApp());
}

class QRxApp extends StatelessWidget {
  const QRxApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QRx',
      debugShowCheckedModeBanner: false,
      home: const Scaffold(
        body: Center(
          child: Text(
            'QRx App',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
