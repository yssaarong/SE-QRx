import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'database_service.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  final MobileScannerController cameraController = MobileScannerController();
  final FlutterTts flutterTts = FlutterTts();

  bool _scanned = false;
  String _medicineStatus = "";
  String _medicineName = "";
  String _manufacturer = "";

  @override
  void initState() {
    super.initState();
    _initTts();
  }

  void _initTts() async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.setVolume(1.0);
    await flutterTts.setPitch(1.0);
  }

  void _processQRCode(String qrData) async {
    final parts = qrData.split('|');

    if (parts.length != 2) {
      setState(() {
        _scanned = true;
        _medicineStatus = "Invalid QR";
        _medicineName = "Unknown";
        _manufacturer = "Unknown";
      });
      _announceResult();
      return;
    }

    _medicineName = parts[0].trim();
    _manufacturer = parts[1].trim();

    try {
      final response =
          await DatabaseService().verifyMedicine(_medicineName, _manufacturer);
      setState(() {
        _scanned = true;
        _medicineStatus = response['status'] ?? 'Not Found';
      });
    } catch (e) {
      setState(() {
        _medicineStatus = 'Error';
      });
    }

    _announceResult();
  }

  void _announceResult() async {
    String speechText = "";

    if (_medicineStatus == 'Safe') {
      speechText =
          "Verified Safe. The medicine $_medicineName by $_manufacturer is authentic and safe to use.";
    } else if (_medicineStatus == 'Counterfeit') {
      speechText =
          "Warning! This medicine appears to be Counterfeit. Do not use.";
    } else if (_medicineStatus == 'Expired') {
      speechText = "Warning! This medicine is Expired. Do not use.";
    } else if (_medicineStatus == 'Not Found') {
      speechText =
          "Medicine not found in the database. Please verify manually.";
    } else {
      speechText = "Invalid QR code format.";
    }

    await flutterTts.speak(speechText);
  }

  Color _getStatusColor() {
    return {
          'Safe': Colors.green,
          'Counterfeit': Colors.red,
          'Expired': Colors.orange,
          'Not Found': Colors.red,
        }[_medicineStatus] ??
        Colors.black54;
  }

  void _resetScan() async {
    await flutterTts.stop();
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
    flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const backgroundColor = Color(0xFFCFF4FA);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black, size: 28),
          onPressed: () {
            flutterTts.stop();
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          const Text(
            "Scan your QR Code",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const Spacer(),
          Center(
            child: SizedBox(
              width: 280,
              height: 280,
              child: _scanned ? _buildResultView() : _buildScannerView(),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 60),
            child: SizedBox(
              width: 220,
              height: 55,
              child: ElevatedButton(
                onPressed: _scanned ? _resetScan : () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4ADE80),
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

  Widget _buildScannerView() {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
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
        Positioned(
            top: 0, left: 0, child: _buildCorner(isTop: true, isLeft: true)),
        Positioned(
            top: 0, right: 0, child: _buildCorner(isTop: true, isLeft: false)),
        Positioned(
            bottom: 0,
            left: 0,
            child: _buildCorner(isTop: false, isLeft: true)),
        Positioned(
            bottom: 0,
            right: 0,
            child: _buildCorner(isTop: false, isLeft: false)),
      ],
    );
  }

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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _medicineStatus.toUpperCase(),
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: _getStatusColor(),
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(Icons.volume_up),
                color: _getStatusColor(),
                tooltip: "Play Audio",
                onPressed: _announceResult,
              ),
            ],
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
