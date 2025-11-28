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
<<<<<<< HEAD
  String _statusMessage = "";
  String _medicineStatus = "";
=======

  // Example data
  final String safeMedicine = "Paracetamol";
  final String safeManufacturer = "Unilab";
>>>>>>> 85ca5258b45b973c3950eddb288a60395146fb6b

  void _validateMedicine() {
    setState(() {
      _submitted = true;
      String inputMedicine = _medicineController.text.trim();
      String inputManufacturer = _manufacturerController.text.trim();

      if (inputMedicine.isEmpty || inputManufacturer.isEmpty) {
        _isSafe = false;
        _medicineStatus = "Not Found";
        _statusMessage = "Please fill in all fields";
        return;
      }

      bool found = false;
      for (var med in medicineDatabase) {
        if (med['name']!.toLowerCase() == inputMedicine.toLowerCase() &&
            med['manufacturer']!.toLowerCase() == inputManufacturer.toLowerCase()) {
          found = true;
          _statusMessage = med['status']!;
          _medicineStatus = med['status']!;
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
        return Colors.grey;
    }
  }

  IconData _getStatusIcon() {
    switch (_medicineStatus) {
      case 'Safe':
        return Icons.check_circle;
      case 'Counterfeit':
        return Icons.warning;
      case 'Expired':
        return Icons.schedule;
      default:
        return Icons.help;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Input Medicine'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFD8F3E6), Color(0xFFB7E5EA)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(24.0),
            children: [
              Text(
                "Enter Medicine Details",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: _medicineController,
                decoration: InputDecoration(
                  labelText: 'Medicine Name',
                  hintText: 'e.g., Paracetamol',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: Icon(Icons.medication),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
<<<<<<< HEAD
              const SizedBox(height: 16),
              TextField(
                controller: _manufacturerController,
                decoration: InputDecoration(
                  labelText: 'Manufacturer',
                  hintText: 'e.g., PharmaOne',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: Icon(Icons.local_pharmacy),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 28),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _validateMedicine,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF3399CC),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Check Medicine',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              if (_submitted)
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: _getStatusColor(), width: 2),
                  ),
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Icon(
                        _getStatusIcon(),
                        size: 64,
                        color: _getStatusColor(),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        _medicineStatus,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: _getStatusColor(),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _statusMessage,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      if (_isSafe)
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.green.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.green),
                          ),
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Medicine Info",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "Name: ${_medicineController.text}",
                                style: TextStyle(fontSize: 12),
                              ),
                              Text(
                                "Manufacturer: ${_manufacturerController.text}",
                                style: TextStyle(fontSize: 12),
                              ),
                              Text(
                                "Status: Verified & Safe to Use",
                                style: TextStyle(fontSize: 12, color: Colors.green, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
            ],
          ),
=======
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
>>>>>>> 85ca5258b45b973c3950eddb288a60395146fb6b
        ),
      ),
    );
  }
}
