import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'medicine_database.dart';

class InputMedicineScreen extends StatefulWidget {
  const InputMedicineScreen({Key? key}) : super(key: key);

  @override
  State<InputMedicineScreen> createState() => _InputMedicineScreenState();
}

class _InputMedicineScreenState extends State<InputMedicineScreen> {
  final TextEditingController _medicineController = TextEditingController();
  final TextEditingController _manufacturerController = TextEditingController();
  final FlutterTts flutterTts = FlutterTts();

  bool _submitted = false;
  bool _isSafe = false;
  String _statusMessage = "";
  String _medicineStatus = "";

  @override
  void initState() {
    super.initState();
    _initTts();
  }

  @override
  void dispose() {
    flutterTts.stop();
    _medicineController.dispose();
    _manufacturerController.dispose();
    super.dispose();
  }

  void _initTts() async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setSpeechRate(0.5);
  }

  void _validateMedicine() {
    flutterTts.stop();

    setState(() {
      _submitted = true;
      final inputMedicine = _medicineController.text.trim();
      final inputManufacturer = _manufacturerController.text.trim();

      if (inputMedicine.isEmpty || inputManufacturer.isEmpty) {
        _isSafe = false;
        _medicineStatus = "Not Found";
        _statusMessage = "Please fill in all fields";
        _speakResult("Please fill in both the medicine name and manufacturer.");
        return;
      }

      bool found = false;
      for (final med in medicineDatabase) {
        if (med['name']!.toLowerCase() == inputMedicine.toLowerCase() &&
            med['manufacturer']!.toLowerCase() ==
                inputManufacturer.toLowerCase()) {
          found = true;
          _medicineStatus = med['status']!;
          _statusMessage = med['status']!;
          _isSafe = med['status'] == 'Safe';
          break;
        }
      }

      if (!found) {
        _isSafe = false;
        _medicineStatus = "Not Found";
        _statusMessage = "Medicine NOT found in database";
      }

      _speakResultLogic(inputMedicine);
    });
  }

  void _speakResultLogic(String name) {
    String speech = "";
    if (_medicineStatus == "Safe") {
      speech = "The medicine $name is Verified Safe to use.";
    } else if (_medicineStatus == "Not Found") {
      speech =
          "Medicine not found in the database. Please check your spelling.";
    } else if (_medicineStatus == "Counterfeit") {
      speech = "Warning. The medicine $name appears to be Counterfeit.";
    } else {
      speech = "Warning. The medicine $name is $_medicineStatus.";
    }
    _speakResult(speech);
  }

  Future<void> _speakResult(String text) async {
    await flutterTts.speak(text);
  }

  Color _getStatusColor() {
    switch (_medicineStatus) {
      case 'Safe':
        return Colors.green;
      case 'Counterfeit':
        return Colors.red;
      case 'Expired':
        return Colors.orange;
      default:
        return Colors.black54;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color statusColor = _getStatusColor();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Input Medicine'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        color: const Color(0xFFB7E5EA),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // RESULT CARD TOP
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Status Text + Audio Button Row
                      if (_submitted)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _medicineStatus,
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: statusColor,
                              ),
                            ),
                            const SizedBox(width: 8),
                            // THE SMALL BUTTON
                            IconButton(
                              icon: const Icon(Icons.volume_up),
                              color: statusColor,
                              onPressed: () => _speakResultLogic(
                                  _medicineController.text.isNotEmpty
                                      ? _medicineController.text
                                      : "Unknown"),
                            ),
                          ],
                        ),

                      if (_submitted && !_isSafe) const SizedBox(height: 4),
                      if (_submitted && !_isSafe)
                        const Text(
                          "NOT SAFE!",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      const SizedBox(height: 12),
                      if (_submitted && _isSafe)
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE3EBFF),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Medicine Info",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "Name: ${_medicineController.text}",
                                style: const TextStyle(fontSize: 11),
                              ),
                              Text(
                                "Manufacturer: ${_manufacturerController.text}",
                                style: const TextStyle(fontSize: 11),
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                "Status: Verified & Safe to Use",
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                const Text(
                  "Enter Medicine Details",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 12),

                // TEXT FIELDS
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
                      hintText: 'Medicine Name',
                    ),
                  ),
                ),
                const SizedBox(height: 12),
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
                      hintText: 'Manufacturer',
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // BUTTON
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _validateMedicine,
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
      ),
    );
  }
}
