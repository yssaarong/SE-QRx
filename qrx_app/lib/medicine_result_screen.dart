import 'package:flutter/material.dart';

class MedicineResultScreen extends StatelessWidget {
  final String illnessName;
  final String symptoms;
  final String recommended;
  final List<String> alternatives;

  const MedicineResultScreen({
    super.key,
    required this.illnessName,
    required this.symptoms,
    required this.recommended,
    required this.alternatives,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFA9DFF5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFA9DFF5),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          'Medicine Result',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Name of Illness:',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 6),
            _resultBox(illnessName),
            const SizedBox(height: 16),
            const Text(
              'Symptoms:',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 6),
            _resultBox(symptoms),
            const SizedBox(height: 16),
            const Text(
              'Recommended Medicine:',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 6),
            _resultBox(recommended),
            const SizedBox(height: 16),
            const Text(
              'Alternatives:',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 6),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFE8FFE8),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: alternatives
                    .map(
                      (alt) => Text(
                        alt,
                        style: const TextStyle(fontSize: 14),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _resultBox(String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFE8FFE8),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 14),
      ),
    );
  }
}
