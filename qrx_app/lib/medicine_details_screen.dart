import 'package:flutter/material.dart';

class MedicineDetailsScreen extends StatefulWidget {
  final String status; 

  const MedicineDetailsScreen({super.key, required this.status});

  @override
  State<MedicineDetailsScreen> createState() => _MedicineDetailsScreenState();
}

class _MedicineDetailsScreenState extends State<MedicineDetailsScreen> {
  bool _expanded = false;

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
              // Back + title
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

              // White card (scrollable, no Expanded)
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
                    const Text(
                      'SAFE',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Status: Verified & Safe to Use',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 16),

                    Container(
                      width: 80,
                      height: 80,
                      decoration: const BoxDecoration(
                        color: Color(0xFFE8FFE8),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.check,
                        size: 50,
                        color: Colors.green,
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

                    // info box with collapsible text
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
                          const Text('Medicine Name: Paracetamol'),
                          const SizedBox(height: 4),
                          const Text('Manufacturer: Unilab'),
                          const SizedBox(height: 4),
                          const Text('Batch/Lot: 12345A'),
                          const SizedBox(height: 4),
                          const Text('Expiration Date: August 1, 2026'),
                          const SizedBox(height: 4),
                          const Text('FDA Status: Approved'),
                          const SizedBox(height: 8),
                          if (_expanded) ...[
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

                    // View More / View Less
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

              // Tips card
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

              // Back button
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
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Back',
                    style: TextStyle(
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
