import 'package:flutter/material.dart';
import 'medicine_details_screen.dart';
import 'database_service.dart';
import 'translation_service.dart';
import 'package:flutter_tts/flutter_tts.dart';

class InputMedicineScreen extends StatefulWidget {
  const InputMedicineScreen({Key? key}) : super(key: key);

  @override
  State<InputMedicineScreen> createState() => _InputMedicineScreenState();
}

class _InputMedicineScreenState extends State<InputMedicineScreen> {
  final TextEditingController _medicineController = TextEditingController();
  final TextEditingController _manufacturerController = TextEditingController();
  final TextEditingController _batchController = TextEditingController();

  FlutterTts flutterTts = FlutterTts();

  String language = "en";

  @override
  void dispose() {
    _medicineController.dispose();
    _manufacturerController.dispose();
    _batchController.dispose();
    super.dispose();
  }

  Future<String> translateText(String text) async {
    try {
      return await TranslationService().translate(text, language);
    } catch (e) {
      print('Translation failed: $e');
      return text;
    }
  }

  void _checkAndNavigate() async {
    final name = _medicineController.text;
    final manufacturer = _manufacturerController.text;
    final batch = _batchController.text;

    if (name.isEmpty || manufacturer.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please enter both medicine name and manufacturer.')),
      );
      return;
    }

    print(
        "User Data - Name: $name, Manufacturer: $manufacturer, Batch: $batch");

    try {
      final result = await DatabaseService().verifyMedicine(name, manufacturer);
      print("Medicine Check Result: $result");

      if (result.isEmpty || result['status'] == 'Invalid Input') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid input, please try again.')),
        );
        return;
      }
      _announceMedicineDetails(name, manufacturer, batch);
      print("Navigating to MedicineDetailsScreen...");

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => MedicineDetailsScreen(
            status: result['status'] ?? 'Unknown',
            name: result['name'] ?? 'Unknown',
            manufacturer: result['manufacturer'] ?? 'Unknown',
            batch: result['batch'] ?? 'Unknown',
          ),
        ),
      );
    } catch (e) {
      print("Error fetching data: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error fetching data.')),
      );
    }
  }

  void _announceMedicineDetails(
      String name, String manufacturer, String batch) async {
    String textToRead =
        "Medicine Details: $name, Manufacturer: $manufacturer, Batch: $batch.";

    // Set TTS properties
    await flutterTts.setLanguage("en-US");
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.setVolume(1.0);
    await flutterTts.setPitch(1.0);

    // Announce the details aloud
    await flutterTts.speak(textToRead);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFB7E5EA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFB7E5EA),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          'Input Medicine',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Enter Medicine Details",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                "Name:",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: TextField(
                  controller: _medicineController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Ex: Paracetamol',
                  ),
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                "Manufacturer:",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: TextField(
                  controller: _manufacturerController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Ex: PharmaOne',
                  ),
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                "Batch/Lot Number:",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: TextField(
                  controller: _batchController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Ex: L2025B',
                  ),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _checkAndNavigate,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3399CC),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    "Check Medicine",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
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
