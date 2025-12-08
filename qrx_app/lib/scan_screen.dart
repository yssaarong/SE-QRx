import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'medicine_database.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  final MobileScannerController cameraController = MobileScannerController();

  // State variables
  bool _scanned = false;
  String _medicineStatus = "";
  String _medicineName = "";
  String _manufacturer = "";

  // Process QR code and verify against database
  void _processQRCode(String qrData) {
    final parts = qrData.split('|');

    // Handle invalid format
    if (parts.length != 2) {
      setState(() {
        _scanned = true;
        _medicineStatus = "Invalid QR";
        _medicineName = "Unknown";
        _manufacturer = "Unknown";
      });
      return;
    }

    _medicineName = parts[0].trim();
    _manufacturer = parts[1].trim();

    // Find medicine in database
    final medicine = medicineDatabase.firstWhere(
      (med) =>
          med['name']!.toLowerCase() == _medicineName.toLowerCase() &&
          med['manufacturer']!.toLowerCase() == _manufacturer.toLowerCase(),
      orElse: () => {'status': 'Not Found'},
    );

    setState(() {
      _scanned = true;
      _medicineStatus = medicine['status']!;
    });
  }

  // Get status color
  Color _getStatusColor() {
    return {
          'Safe': Colors.green,
          'Counterfeit': Colors.red,
          'Expired': Colors.orange,
          'Not Found': Colors.red,
        }[_medicineStatus] ??
        Colors.black54;
  }

  // Reset for new scan
  void _resetScan() {
    setState(() {
      _scanned = false;
      _medicineStatus = "";
      _medicineName = "";
      _manufacturer = "";
    });
    cameraController.start();
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Light blue background color from your design
    const backgroundColor = Color(0xFFCFF4FA);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black, size: 28),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          // Title
          const Text(
            "Scan your QR Code",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),

          // Spacer to push scanner to center
          const Spacer(),

          // Center Area: Switch between Camera and Result
          Center(
            child: SizedBox(
              width: 280,
              height: 280,
              child: _scanned ? _buildResultView() : _buildScannerView(),
            ),
          ),

          const Spacer(),

          // Bottom Green Button
          Padding(
            padding: const EdgeInsets.only(bottom: 60),
            child: SizedBox(
              width: 220,
              height: 55,
              child: ElevatedButton(
                onPressed: _scanned
                    ? _resetScan
                    : () {
                        // Optional: Add logic if you want the button to trigger something manually
                        // Currently scanner works automatically
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4ADE80), // Bright green
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(_scanned ? Icons.refresh : Icons.filter_center_focus,
                        color: Colors.white),
                    const SizedBox(width: 10),
                    Text(
                      _scanned ? "Scan Again" : "Scan QR Code",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget for the Camera with Corner Borders
  Widget _buildScannerView() {
    return Stack(
      children: [
        // The Camera
        ClipRRect(
          borderRadius:
              BorderRadius.circular(20), // Slight radius for inner camera
          child: MobileScanner(
            controller: cameraController,
            onDetect: (capture) {
              if (!_scanned && capture.barcodes.isNotEmpty) {
                final code = capture.barcodes.first.rawValue;
                if (code != null) {
                  _processQRCode(code);
                }
              }
            },
          ),
        ),

        // Custom Corner Borders (L-Shapes)
        // Top Left
        Positioned(
          top: 0,
          left: 0,
          child: _buildCorner(isTop: true, isLeft: true),
        ),
        // Top Right
        Positioned(
          top: 0,
          right: 0,
          child: _buildCorner(isTop: true, isLeft: false),
        ),
        // Bottom Left
        Positioned(
          bottom: 0,
          left: 0,
          child: _buildCorner(isTop: false, isLeft: true),
        ),
        // Bottom Right
        Positioned(
          bottom: 0,
          right: 0,
          child: _buildCorner(isTop: false, isLeft: false),
        ),
      ],
    );
  }

  // Helper to build the black corner brackets
  Widget _buildCorner({required bool isTop, required bool isLeft}) {
    const double size = 40;
    const double thickness = 4;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        border: Border(
          top: isTop
              ? const BorderSide(color: Colors.black, width: thickness)
              : BorderSide.none,
          bottom: !isTop
              ? const BorderSide(color: Colors.black, width: thickness)
              : BorderSide.none,
          left: isLeft
              ? const BorderSide(color: Colors.black, width: thickness)
              : BorderSide.none,
          right: !isLeft
              ? const BorderSide(color: Colors.black, width: thickness)
              : BorderSide.none,
        ),
      ),
    );
  }

  // Widget to display result inside the box
  Widget _buildResultView() {
    bool isSafe = _medicineStatus == 'Safe';
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
              color: Colors.black12, blurRadius: 10, offset: const Offset(0, 5))
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isSafe ? Icons.check_circle : Icons.warning_rounded,
            size: 60,
            color: _getStatusColor(),
          ),
          const SizedBox(height: 10),
          Text(
            _medicineStatus.toUpperCase(),
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: _getStatusColor(),
            ),
          ),
          const SizedBox(height: 10),
          Divider(color: Colors.grey[300]),
          const SizedBox(height: 10),
          Text(
            "Name: $_medicineName",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
          Text(
            "Mfg: $_manufacturer",
            style: const TextStyle(fontSize: 14, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
