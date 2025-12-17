import 'package:flutter/material.dart';
import 'scan_screen.dart';
import 'input_medicine_screen.dart';
import 'find_medicine_screen.dart';
import 'translation_service.dart';

class HomeScreen extends StatelessWidget {
  final String userName;
  final String language; // 'en', 'ceb', 'fil'

  const HomeScreen({
    super.key,
    this.userName = 'User',
    this.language = 'en',
  });

  Future<String> translateText(String text) async {
    try {
      return await TranslationService().translate(text, language);
    } catch (e) {
      print('Translation failed: $e');
      return text; // Return the original text if translation fails
    }
  }

  @override
  Widget build(BuildContext context) {
    final texts = _texts[language] ?? _texts['en']!;

    return Scaffold(
      backgroundColor: const Color(0xFFA9DFF5),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Title
              Text(
                texts['title']!,
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.5,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),

              // Subtitle
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  texts['subtitle']!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Scan QR button
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ScanScreen(),
                    ),
                  );
                },
                child: Container(
                  width: 220,
                  height: 55,
                  decoration: BoxDecoration(
                    color: const Color(0xFF3399FF),
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.qr_code_scanner,
                        color: Colors.white,
                        size: 24,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        texts['scan']!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 18),

              // Input Medicine button
              HomeButton(
                label: texts['input']!,
                icon: Icons.edit_note,
                color: Colors.white,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const InputMedicineScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 12),

              // Find Medicine button (fixed)
              HomeButton(
                label: texts['find']!,
                icon: Icons.search,
                color: Colors.white,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => FindMedicineScreen(language: language),
                    ),
                  );
                },
              ),
              const SizedBox(height: 26),

              // Description
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  texts['desc']!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Colors.black87,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Language buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const HomeScreen(language: 'en'),
                        ),
                      );
                    },
                    child: const Text('English'),
                  ),
                  const SizedBox(width: 24),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const HomeScreen(language: 'ceb'),
                        ),
                      );
                    },
                    child: const Text('Cebuano'),
                  ),
                  const SizedBox(width: 24),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const HomeScreen(language: 'fil'),
                        ),
                      );
                    },
                    child: const Text('Filipino'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const HomeButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(22),
      child: InkWell(
        borderRadius: BorderRadius.circular(22),
        onTap: onTap,
        child: Container(
          width: 220,
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 22,
                color: Colors.black87,
              ),
              const SizedBox(width: 12),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
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

// Texts map from your original file
const Map<String, Map<String, String>> _texts = {
  'en': {
    'title': 'QRx',
    'subtitle': 'Let\'s check if your medicine is SAFE and RIGHT for you.',
    'scan': 'Scan QR',
    'input': 'Input Medicine',
    'find': 'Find Medicine',
    'desc':
        'Prioritize your health with QRx. This app empowers you to verify your medicines, avoid potential risks, and ensure you\'re making safe choices every time you take your medication.',
  },
  'ceb': {
    'title': 'QRx',
    'subtitle':
        'Ato nga susihon kung ang imong tambal SAKTO ug ANGAY para kanimo.',
    'scan': 'I-scan ang QR',
    'input': 'Pag-Input ug Tambal',
    'find': 'Pangita ug Tambal',
    'desc':
        'Unaha ang imong kahimsog pinaagi sa QRx. Ang maong app naghatag og gahum kanimo aron mapamatud-an ang pagka-tinuod sa imong mga medisina, malikayan ang posibleng mga risgo, ug masiguro ang luwas nga pagpili sa matag higayon nga moinom ka og tambal.',
  },
  'fil': {
    'title': 'QRx',
    'subtitle':
        'Suriin natin kung ang iyong gamot ay LIGTAS at TAMA para sa iyo.',
    'scan': 'I-scan ang QR',
    'input': 'Mag-input ng Gamot',
    'find': 'Maghanap ng Gamot',
    'desc':
        'Unahin ang iyong kalusugan gamit ang QRx. Binibigyan ka ng kapangyarihan ng app na ito na i-verify ang iyong mga gamot, maiwasan ang mga potensyal na panganib, at tiyaking gumagawa ka ng ligtas na desisyon sa tuwing iinom ka ng iyong gamot.',
  },
};
