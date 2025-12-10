import 'package:flutter/material.dart';
import 'medicine_details_screen.dart';
import 'medicine_database.dart';

class InputMedicineScreen extends StatefulWidget {
  const InputMedicineScreen({Key? key}) : super(key: key);

  @override
  State<InputMedicineScreen> createState() => _InputMedicineScreenState();
}

class _InputMedicineScreenState extends State<InputMedicineScreen> {
  final TextEditingController _medicineController = TextEditingController();
  final TextEditingController _manufacturerController = TextEditingController();
  final TextEditingController _batchController = TextEditingController();

  @override
  void dispose() {
    _medicineController.dispose();
    _manufacturerController.dispose();
    _batchController.dispose();
    super.dispose();
  }

  void _checkAndNavigate() {
    final name = _medicineController.text.trim();
    final manufacturer = _manufacturerController.text.trim();
    final batch = _batchController.text.trim();

    // 1) Require all fields
    if (name.isEmpty || manufacturer.isEmpty || batch.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all medicine details.')),
      );
      return;
    }

    // 2) Check against medicineDatabase (name + manufacturer + batch)
    final match = medicineDatabase.firstWhere(
      (m) =>
          m['name']!.toLowerCase() == name.toLowerCase() &&
          m['manufacturer']!.toLowerCase() == manufacturer.toLowerCase() &&
          m['batch']!.toLowerCase() == batch.toLowerCase(),
      orElse: () => {},
    );

    if (match.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Medicine not found in database.')),
      );
      return;
    }

    // 3) If found, go to result screen with status
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MedicineDetailsScreen(
          status: match['status']!, // Safe / Counterfeit
        ),
      ),
    );
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

              // NAME
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

              // MANUFACTURER
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

              // BATCH / LOT
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

              // CHECK BUTTON
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
