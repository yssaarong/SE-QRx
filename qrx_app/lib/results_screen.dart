import 'package:flutter/material.dart';
import 'medicine_database.dart';

class ResultsScreen extends StatelessWidget {
  final Medicine medicine;

  const ResultsScreen({super.key, required this.medicine});

  @override
  Widget build(BuildContext context) {
    bool isExpired =
        DateTime.parse(medicine.expiryDate).isBefore(DateTime.now());
    Color statusColor =
        medicine.isAuthentic && !isExpired ? Colors.green : Colors.red;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Verification Results',
            style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF0078D7),
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFD6F5E6), Color(0xFFB3E5FC)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Icon(
                          medicine.isAuthentic && !isExpired
                              ? Icons.check_circle
                              : Icons.warning,
                          size: 60,
                          color: statusColor,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          medicine.name,
                          style: const TextStyle(
                              fontSize: 28, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          medicine.description,
                          style: const TextStyle(
                              fontSize: 16, color: Colors.black87),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          decoration: BoxDecoration(
                            color: statusColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: statusColor),
                          ),
                          child: Text(
                            medicine.isAuthentic && !isExpired
                                ? 'Authentic and Valid'
                                : isExpired
                                    ? 'Expired - Do Not Use!'
                                    : 'Counterfeit - Alert!',
                            style: TextStyle(
                                fontSize: 18,
                                color: statusColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                if (medicine.illnessSuggestions.isNotEmpty)
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        children: [
                          const Text('Related Illnesses',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 10),
                          Wrap(
                            spacing: 10,
                            children: medicine.illnessSuggestions
                                .map((illness) => Chip(label: Text(illness)))
                                .toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                const SizedBox(height: 20),
                if (medicine.alternatives.isNotEmpty)
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        children: [
                          const Text('Alternatives',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 10),
                          Wrap(
                            spacing: 10,
                            children: medicine.alternatives
                                .map((alt) => Chip(label: Text(alt)))
                                .toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                const SizedBox(height: 20),
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: [
                        const Text('Voice Assistance (Cebuano/Tagalog)',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10),
                        Text(
                          medicine.voiceText,
                          style: const TextStyle(
                              fontSize: 16, color: Colors.black87),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton.icon(
                          onPressed: () {
                            // TODO: Implement voice playback with flutter_tts
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      'Voice playback not yet implemented. Add flutter_tts dependency.')),
                            );
                          },
                          icon: const Icon(Icons.volume_up),
                          label: const Text('Play Voice'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF66C2A5),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)),
                          ),
                        ),
                      ],
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
