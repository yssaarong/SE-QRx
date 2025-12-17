import 'package:flutter/material.dart';
import 'medicine_result_screen.dart';
import 'database_service.dart';
import 'translation_service.dart';

class FindMedicineScreen extends StatefulWidget {
  final String language;

  const FindMedicineScreen({super.key, this.language = "en"});

  @override
  State<FindMedicineScreen> createState() => _FindMedicineScreenState();
}

class _FindMedicineScreenState extends State<FindMedicineScreen> {
  final TextEditingController illnessController = TextEditingController();
  final TextEditingController symptomsController = TextEditingController();
  String translatedText = '';

  @override
  void dispose() {
    illnessController.dispose();
    symptomsController.dispose();
    super.dispose();
  }

  Future<void> translateText() async {
    try {
      final translation = await TranslationService()
          .translate('Enter Illness', widget.language);
      setState(() {
        translatedText = translation;
      });
    } catch (e) {
      print('Translation failed: $e');
    }
  }

  void _searchForMedicine() async {
    final illness =
        illnessController.text.isEmpty ? 'Fever' : illnessController.text;
    final symptoms =
        symptomsController.text.isEmpty ? 'Headache' : symptomsController.text;

    try {
      final response =
          await DatabaseService().verifyMedicine(illness, symptoms);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => MedicineResultScreen(
            illnessName: illness,
            symptoms: symptoms,
            recommended: response['name'] ?? 'Unknown',
            alternatives: [],
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = _findTexts[widget.language] ?? _findTexts['en']!;

    return Scaffold(
      backgroundColor: const Color(0xFFA9DFF5),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
              _RoundedTextField(
                hint: t['nameHint']!,
                controller: illnessController,
              ),
              const SizedBox(height: 16),
              Text(t['symptomsLabel']!),
              const SizedBox(height: 6),
              _RoundedTextField(
                hint: t['symptomsHint']!,
                controller: symptomsController,
              ),
              const SizedBox(height: 32),
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
                    final illness = illnessController.text.isEmpty
                        ? 'Fever'
                        : illnessController.text;
                    final symptoms = symptomsController.text.isEmpty
                        ? 'Headache'
                        : symptomsController.text;

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MedicineResultScreen(
                          illnessName: illness,
                          symptoms: symptoms,
                          recommended: 'Paracetamol 500 mg',
                          alternatives: const [
                            'Ibuprofen .......................... 200 mg',
                            'Naproxen ........................... 250 mg',
                            'Acetaminophen ...................... 500 mg',
                          ],
                        ),
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
  final TextEditingController? controller;

  const _RoundedTextField({
    required this.hint,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
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

const Map<String, Map<String, String>> _findTexts = {
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
