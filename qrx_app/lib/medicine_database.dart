final List<Map<String, String>> medicineDatabase = [
  {'name': 'Paracetamol', 'manufacturer': 'PharmaOne', 'status': 'Safe'},
  {'name': 'Amoxicillin', 'manufacturer': 'HealthCorp', 'status': 'Safe'},
  {'name': 'FakeCure', 'manufacturer': 'Unknown', 'status': 'Counterfeit'},
];

String verifyMedicine(String name) {
  for (var med in medicineDatabase) {
    if (med['name']!.toLowerCase() == name.toLowerCase()) {
      return med['status']!;
    }
  }
  return 'Not Found';
}
