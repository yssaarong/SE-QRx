import 'package:flutter/material.dart';
import 'medicine_database.dart';

class InputMedicineScreen extends StatefulWidget {
  const InputMedicineScreen({Key? key}) : super(key: key);

  @override
  State<InputMedicineScreen> createState() => _InputMedicineScreenState();
}

class _InputMedicineScreenState extends State<InputMedicineScreen> {
  final TextEditingController _medicineController = TextEditingController();
  final TextEditingController _manufacturerController = TextEditingController();

  bool _submitted = false;
  bool _isSafe = false;
  String _statusMessage = "";
  String _medicineStatus = ""; // Safe / Counterfeit / Expired / Not Found

  void _validateMedicine() {
    setState(() {
      _submitted = true;
      final inputMedicine = _medicineController.text.trim();
      final inputManufacturer = _manufacturerController.text.trim();

      if (inputMedicine.isEmpty || inputManufacturer.isEmpty) {
        _isSafe = false;
        _medicineStatus = "Not Found";
        _statusMessage = "Please fill in all fields";
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
    });
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
                      Text(
                        _submitted ? _medicineStatus : "",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: statusColor,
                        ),
                      ),
                      // NOT SAFE! red text when not safe
                      if (_submitted && !_isSafe)
                        const SizedBox(height: 4),
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
