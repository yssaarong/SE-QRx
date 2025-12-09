import 'package:flutter/material.dart';
import 'medicine_result_screen.dart';

class FindMedicineScreen extends StatelessWidget {
  final String language; // "en", "ceb", "fil"

  const FindMedicineScreen({super.key, this.language = "en"});

  @override
  Widget build(BuildContext context) {
    final t = _findTexts[language]!;

    return Scaffold(
      backgroundColor: const Color(0xFFA9DFF5),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back + title
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    t['title']!,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              Text(
                t['enterIllness']!,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20),

              Text(t['nameLabel']!),
              const SizedBox(height: 6),
              _RoundedTextField(hint: t['nameHint']!),

              const SizedBox(height: 16),
              Text(t['symptomsLabel']!),
              const SizedBox(height: 6),
              _RoundedTextField(hint: t['symptomsHint']!),

              const SizedBox(height: 28),

              Center(
                child: Column(
                  children: [
                    Text(
                      t['voiceTitle']!,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      t['voiceSubtitle']!,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),

              Center(
                child: InkWell(
                  onTap: () {
                    // TODO: voice assistant
                  },
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.mic,
                      size: 40,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // Search button -> MedicineResultScreen, same language
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3399FF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            MedicineResultScreen(language: language),
                      ),
                    );
                  },
                  child: Text(
                    t['button']!,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RoundedTextField extends StatelessWidget {
  final String hint;
  const _RoundedTextField({required this.hint});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFFE8FFE8),
        hintText: hint,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

// Texts for FindMedicineScreen
final Map<String, Map<String, String>> _findTexts = {
  "en": {
    "title": "Find Medicine",
    "enterIllness": "Enter Illness",
    "nameLabel": "Name of Illness:",
    "nameHint": "Ex: Fever",
    "symptomsLabel": "Symptoms:",
    "symptomsHint": "Ex: Headache",
    "voiceTitle": "Voice Assistant",
    "voiceSubtitle": "(Tap to Speak)",
    "button": "Search for Medicine",
  },
  "ceb": {
    "title": "Pangita ug Tambal",
    "enterIllness": "Ibutang ang Gibati",
    "nameLabel": "Ngalan sa Gibati:",
    "nameHint": "Pananglitan: Hilanat",
    "symptomsLabel": "Mga Sintomas:",
    "symptomsHint": "Pananglitan: Labad sa ulo",
    "voiceTitle": "Voice Assistant",
    "voiceSubtitle": "(Pindota aron mosulti)",
    "button": "Pangita og Angay nga Tambal",
  },
  "fil": {
    "title": "Maghanap ng Gamot",
    "enterIllness": "Ilagay ang Karamdaman",
    "nameLabel": "Pangalan ng Karamdaman:",
    "nameHint": "Halimbawa: Lagnat",
    "symptomsLabel": "Mga Sintomas:",
    "symptomsHint": "Halimbawa: Pagsakit ng ulo",
    "voiceTitle": "Voice Assistant",
    "voiceSubtitle": "(Pindutin para Magsalita)",
    "button": "Maghanap ng Gamot",
  },
};
