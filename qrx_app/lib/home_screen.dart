import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final String userName;

  const HomeScreen({super.key, this.userName = "User"});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFD8F3E6), Color(0xFFB7E5EA)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 150),
              Center(
                child: Column(
                  children: [
                    Text(
                      "QRx",
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "Let's check if your medicine is SAFE and RIGHT for you.",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                        fontWeight: FontWeight.normal,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    _HomeButton(
                      label: "Scan QR",
                      icon: Icons.qr_code_scanner,
                      color: Color(0xFF3399CC),
                    ),
                    SizedBox(height: 28),
                    _HomeButton(
                      label: "Input Medicine",
                      icon: Icons.medication,
                      color: Color(0xFFD8F3E6),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 80), // Approx. "2 inches" below Input Medicine
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  "Prioritize your health with QRx. This app empowers you to verify your medicines, avoid potential risks, and ensure you’re making safe choices every time you take your medication.",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black45,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HomeButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;

  const _HomeButton({
    required this.label,
    required this.icon,
    required this.color,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(24),
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: () {
          // Add navigation or action logic here
        },
        child: Container(
          width: 220,
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 28, color: Colors.black87),
              const SizedBox(width: 18),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
