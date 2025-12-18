import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class MedicineDetailsScreen extends StatefulWidget {
  final String status;
  final String name;
  final String manufacturer;
  final String batch;

  const MedicineDetailsScreen({
    super.key,
    required this.status,
    required this.name,
    required this.manufacturer,
    required this.batch,
  });

  @override
  State<MedicineDetailsScreen> createState() => _MedicineDetailsScreenState();
}

class _MedicineDetailsScreenState extends State<MedicineDetailsScreen> {
  bool _expanded = false;
  bool _isPlaying = false;
  FlutterTts flutterTts = FlutterTts();
  bool get _isSafe => widget.status.toLowerCase() == 'safe';
  @override
  void initState() {
    super.initState();
    _announceMedicineDetails();
    _initTts();
  }

  void _initTts() async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.setVolume(1.0);
    await flutterTts.setPitch(1.0);
  }

  void _announceMedicineDetails() async {
    String textToRead =
        "Medicine Details: ${widget.name}, Manufacturer: ${widget.manufacturer}, Batch: ${widget.batch}, Status: ${widget.status}.";

    await flutterTts.speak(textToRead);
    setState(() {
      _isPlaying = true;
    });
  }

  void _pauseTts() async {
    await flutterTts.stop();
    setState(() {
      _isPlaying = false;
    });
  }

  void _playTts() async {
    await flutterTts.speak(
        "Resuming: Medicine Details: ${widget.name}, Manufacturer: ${widget.manufacturer}, Batch: ${widget.batch}, Status: ${widget.status}.");
    setState(() {
      _isPlaying = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFA9DFF5),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
                  const Text(
                    'Medicine Details',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _isSafe ? 'SAFE' : 'NOT SAFE',
                      style: TextStyle(
                        color: _isSafe ? Colors.green : Colors.red,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _isSafe
                          ? 'Status: Verified & Safe to Use'
                          : 'Status: Counterfeit',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: _isSafe
                            ? const Color(0xFFE8FFE8)
                            : const Color(0xFFFFE5E5),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        _isSafe ? Icons.check : Icons.close,
                        size: 50,
                        color: _isSafe ? Colors.green : Colors.red,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Medicine Info',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.blueAccent,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE5E5FF),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Medicine Name: ${widget.name}'),
                          const SizedBox(height: 4),
                          Text('Manufacturer: ${widget.manufacturer}'),
                          const SizedBox(height: 4),
                          Text('Batch/Lot: ${widget.batch}'),
                          const SizedBox(height: 4),
                          Text(_isSafe
                              ? 'Expiration Date: August 1, 2026'
                              : 'Expiration Date: Unknown'),
                          const SizedBox(height: 4),
                          Text(_isSafe
                              ? 'FDA Status: Approved'
                              : 'FDA Status: No record found'),
                          const SizedBox(height: 8),
                          if (_isSafe && _expanded) ...[
                            const Text(
                              'Description:',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            const Text(
                              'Paracetamol is a common over-the-counter medicine used to help reduce fever '
                              'and relieve mild to moderate pain such as headache, body pain, and toothache.',
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Warnings & Precautions:',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            const Text(
                              '• Do not use if you are allergic to paracetamol.\n'
                              '• Avoid using multiple products containing paracetamol to prevent overdose.\n'
                              '• Consult a healthcare professional if symptoms persist or worsen.\n'
                              '• Not recommended for individuals with severe liver disease.',
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Side Effects:',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            const Text(
                              '• Rare: skin rash, allergic reactions.\n'
                              '• Seek medical help if you experience difficulty breathing or swelling.',
                            ),
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    if (_isSafe)
                      SizedBox(
                        width: 120,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: const Color(0xFF3399FF),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 6),
                          ),
                          onPressed: () {
                            setState(() {
                              _expanded = !_expanded;
                            });
                          },
                          child: Text(_expanded ? 'View Less' : 'View More'),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: const Color(0xFFCCE6FF),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'TIPS TO AVOID COUNTERFEITS',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '• Buy only from licensed pharmacies.\n'
                      '• Check seal and packaging quality.\n'
                      '• Avoid medicines with unclear print or smudges.\n'
                      '• Compare expiry date with packaging.',
                      style: TextStyle(fontSize: 11),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0066CC),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: () {
                    if (_isPlaying) {
                      _pauseTts();
                    } else {
                      _playTts();
                    }
                  },
                  child: Text(
                    _isPlaying ? 'Pause TTS' : 'Play TTS',
                    style: const TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
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
