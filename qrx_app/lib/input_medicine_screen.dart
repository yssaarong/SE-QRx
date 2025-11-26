import 'package:flutter/material.dart';

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

  // Example data
  final String safeMedicine = "Paracetamol";
  final String safeManufacturer = "Unilab";

  void _validateMedicine() {
    setState(() {
      _submitted = true;
      if (_medicineController.text.trim() == safeMedicine &&
          _manufacturerController.text.trim() == safeManufacturer) {
        _isSafe = true;
      } else {
        _isSafe = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Input Medicine')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _medicineController,
              decoration: const InputDecoration(
                labelText: 'Medicine Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _manufacturerController,
              decoration: const InputDecoration(
                labelText: 'Manufacturer',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _validateMedicine,
              child: const Text('Check'),
            ),
            const SizedBox(height: 24),
            _submitted
                ? _isSafe
                    ? Column(
                        children: [
                          const Icon(Icons.check_circle,
                              color: Colors.green, size: 48),
                          const Text("Medicine is SAFE!",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      )
                    : Column(
                        children: [
                          const Icon(Icons.cancel, color: Colors.red, size: 48),
                          const Text("Medicine NOT found or NOT safe.",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      )
                : Container(),
          ],
        ),
      ),
    );
  }
}
