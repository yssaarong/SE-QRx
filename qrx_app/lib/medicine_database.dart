final List<Map<String, String>> medicineDatabase = [
  {
    'name': 'Paracetamol',
    'manufacturer': 'PharmaOne',
    'batch': 'L2025B',
    'status': 'Safe',
  },
  {
    'name': 'Amoxicillin',
    'manufacturer': 'HealthCorp',
    'batch': 'AMX-101',
    'status': 'Safe',
  },
  {
    'name': 'FakeCure',
    'manufacturer': 'Unknown',
    'batch': 'FK-999',
    'status': 'Counterfeit',
  },
];

String verifyMedicine(String name) {
  for (var med in medicineDatabase) {
    if (med['name']!.toLowerCase() == name.toLowerCase()) {
      return med['status']!;
    }
  }
  return 'Not Found';
}
