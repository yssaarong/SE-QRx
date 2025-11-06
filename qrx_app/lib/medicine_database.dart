// medicine_database.dart
// Mock database for common medicines. In production, replace with a real API/database.

class Medicine {
  final String name;
  final String code; // Unique QR code data (e.g., "MED-001")
  final String description;
  final bool isAuthentic; // True if verified, false if counterfeit
  final String expiryDate; // Format: YYYY-MM-DD
  final List<String> illnessSuggestions; // Related illnesses
  final List<String> alternatives; // Alternative medicines
  final String voiceText; // Localized voice assistance (Cebuano/Tagalog)

  Medicine({
    required this.name,
    required this.code,
    required this.description,
    required this.isAuthentic,
    required this.expiryDate,
    required this.illnessSuggestions,
    required this.alternatives,
    required this.voiceText,
  });
}

// Sample database: Map of QR code -> Medicine for quick lookup
Map<String, Medicine> medicineDatabase = {
  // Pain Relievers
  "MED-001": Medicine(
    name: "Paracetamol",
    code: "MED-001",
    description: "Pain reliever and fever reducer.",
    isAuthentic: true,
    expiryDate: "2026-12-31",
    illnessSuggestions: ["Headache", "Fever", "Body Pain"],
    alternatives: ["Ibuprofen", "Aspirin"],
    voiceText:
        "Paracetamol: Gamit para sa sakit sa ulo ug init sa lawas. Sa Cebuano: Gamit kini para sa sakit sa ulo ug init. Sa Tagalog: Gamitin para sa sakit ng ulo at lagnat.",
  ),
  "MED-002": Medicine(
    name: "Ibuprofen",
    code: "MED-002",
    description: "Anti-inflammatory pain reliever.",
    isAuthentic: true,
    expiryDate: "2026-10-15",
    illnessSuggestions: ["Headache", "Arthritis", "Inflammation"],
    alternatives: ["Paracetamol", "Naproxen"],
    voiceText:
        "Ibuprofen: Para sa sakit ug pamamaga. Sa Cebuano: Gamit para sa sakit ug pamamaga. Sa Tagalog: Gamitin para sa sakit at pamamaga.",
  ),
  "MED-003": Medicine(
    name: "Aspirin",
    code: "MED-003",
    description: "Pain reliever and blood thinner.",
    isAuthentic: true,
    expiryDate: "2026-08-20",
    illnessSuggestions: ["Headache", "Heart Conditions"],
    alternatives: ["Paracetamol", "Ibuprofen"],
    voiceText:
        "Aspirin: Gamit para sa sakit ug dugo. Sa Cebuano: Gamit kini para sa sakit ug dugo. Sa Tagalog: Gamitin para sa sakit at dugo.",
  ),

  // Antibiotics
  "MED-004": Medicine(
    name: "Amoxicillin",
    code: "MED-004",
    description: "Antibiotic for bacterial infections.",
    isAuthentic: true,
    expiryDate: "2026-11-05",
    illnessSuggestions: ["Ear Infection", "Urinary Tract Infection"],
    alternatives: ["Penicillin", "Ciprofloxacin"],
    voiceText:
        "Amoxicillin: Antibiyotiko para sa impeksyon. Sa Cebuano: Antibiyotiko para sa impeksyon. Sa Tagalog: Antibiyotiko para sa impeksyon.",
  ),
  "MED-005": Medicine(
    name: "Ciprofloxacin",
    code: "MED-005",
    description: "Antibiotic for various infections.",
    isAuthentic: true,
    expiryDate: "2026-09-30",
    illnessSuggestions: ["Skin Infection", "Respiratory Infection"],
    alternatives: ["Amoxicillin", "Doxycycline"],
    voiceText:
        "Ciprofloxacin: Para sa lain-laing impeksyon. Sa Cebuano: Para sa lain-laing impeksyon. Sa Tagalog: Para sa iba't ibang impeksyon.",
  ),

  // Vitamins/Supplements
  "MED-006": Medicine(
    name: "Vitamin C",
    code: "MED-006",
    description: "Immune booster and antioxidant.",
    isAuthentic: true,
    expiryDate: "2027-01-10",
    illnessSuggestions: ["Cold", "Immune Deficiency"],
    alternatives: ["Vitamin D", "Zinc"],
    voiceText:
        "Vitamin C: Para sa immune system. Sa Cebuano: Para sa immune system. Sa Tagalog: Para sa immune system.",
  ),
  "MED-007": Medicine(
    name: "Vitamin D",
    code: "MED-007",
    description: "Supports bone health and immunity.",
    isAuthentic: true,
    expiryDate: "2027-02-14",
    illnessSuggestions: ["Bone Weakness", "Depression"],
    alternatives: ["Calcium", "Vitamin C"],
    voiceText:
        "Vitamin D: Para sa mga bukog ug immune. Sa Cebuano: Para sa mga bukog ug immune. Sa Tagalog: Para sa mga buto at immune.",
  ),

  // Antihistamines
  "MED-008": Medicine(
    name: "Cetirizine",
    code: "MED-008",
    description: "Allergy relief medication.",
    isAuthentic: true,
    expiryDate: "2026-07-25",
    illnessSuggestions: ["Allergies", "Hay Fever"],
    alternatives: ["Loratadine", "Diphenhydramine"],
    voiceText:
        "Cetirizine: Para sa allergy. Sa Cebuano: Para sa allergy. Sa Tagalog: Para sa allergy.",
  ),

  // Cough/Cold Remedies
  "MED-009": Medicine(
    name: "Dextromethorphan",
    code: "MED-009",
    description: "Cough suppressant.",
    isAuthentic: true,
    expiryDate: "2026-06-18",
    illnessSuggestions: ["Cough", "Cold"],
    alternatives: ["Guaifenesin", "Honey"],
    voiceText:
        "Dextromethorphan: Para sa ubo. Sa Cebuano: Para sa ubo. Sa Tagalog: Para sa ubo.",
  ),

  // Antacids
  "MED-010": Medicine(
    name: "Omeprazole",
    code: "MED-010",
    description: "Reduces stomach acid.",
    isAuthentic: true,
    expiryDate: "2026-12-01",
    illnessSuggestions: ["Heartburn", "Acid Reflux"],
    alternatives: ["Ranitidine", "Antacids"],
    voiceText:
        "Omeprazole: Para sa sakit sa tiyan. Sa Cebuano: Para sa sakit sa tiyan. Sa Tagalog: Para sa sakit ng tiyan.",
  ),

  // More Common Ones (expand as needed)
  "MED-011": Medicine(
    name: "Metformin",
    code: "MED-011",
    description: "For diabetes management.",
    isAuthentic: true,
    expiryDate: "2026-11-20",
    illnessSuggestions: ["Diabetes"],
    alternatives: ["Insulin", "Glipizide"],
    voiceText:
        "Metformin: Para sa diabetes. Sa Cebuano: Para sa diabetes. Sa Tagalog: Para sa diabetes.",
  ),
  "MED-012": Medicine(
    name: "Lisinopril",
    code: "MED-012",
    description: "Blood pressure medication.",
    isAuthentic: true,
    expiryDate: "2026-10-30",
    illnessSuggestions: ["Hypertension"],
    alternatives: ["Amlodipine", "Losartan"],
    voiceText:
        "Lisinopril: Para sa presyon sa dugo. Sa Cebuano: Para sa presyon sa dugo. Sa Tagalog: Para sa presyon ng dugo.",
  ),
  "MED-013": Medicine(
    name: "Simvastatin",
    code: "MED-013",
    description: "Cholesterol-lowering drug.",
    isAuthentic: true,
    expiryDate: "2026-09-15",
    illnessSuggestions: ["High Cholesterol"],
    alternatives: ["Atorvastatin", "Pravastatin"],
    voiceText:
        "Simvastatin: Para sa cholesterol. Sa Cebuano: Para sa cholesterol. Sa Tagalog: Para sa cholesterol.",
  ),
  "MED-014": Medicine(
    name: "Warfarin",
    code: "MED-014",
    description: "Blood thinner.",
    isAuthentic: true,
    expiryDate: "2026-08-10",
    illnessSuggestions: ["Blood Clots"],
    alternatives: ["Heparin", "Aspirin"],
    voiceText:
        "Warfarin: Para sa dugo nga nipis. Sa Cebuano: Para sa dugo nga nipis. Sa Tagalog: Para sa dugo na manipis.",
  ),
  "MED-015": Medicine(
    name: "Prednisone",
    code: "MED-015",
    description: "Steroid for inflammation.",
    isAuthentic: true,
    expiryDate: "2026-07-05",
    illnessSuggestions: ["Inflammation", "Asthma"],
    alternatives: ["Hydrocortisone", "Dexamethasone"],
    voiceText:
        "Prednisone: Para sa pamamaga. Sa Cebuano: Para sa pamamaga. Sa Tagalog: Para sa pamamaga.",
  ),
  "MED-016": Medicine(
    name: "Furosemide",
    code: "MED-016",
    description: "Diuretic for fluid retention.",
    isAuthentic: true,
    expiryDate: "2026-06-22",
    illnessSuggestions: ["Edema", "Heart Failure"],
    alternatives: ["Spironolactone", "Hydrochlorothiazide"],
    voiceText:
        "Furosemide: Para sa tubig sa lawas. Sa Cebuano: Para sa tubig sa lawas. Sa Tagalog: Para sa tubig sa katawan.",
  ),
  "MED-017": Medicine(
    name: "Albuterol",
    code: "MED-017",
    description: "Bronchodilator for asthma.",
    isAuthentic: true,
    expiryDate: "2026-05-18",
    illnessSuggestions: ["Asthma", "COPD"],
    alternatives: ["Salbutamol", "Ipratropium"],
    voiceText:
        "Albuterol: Para sa asthma. Sa Cebuano: Para sa asthma. Sa Tagalog: Para sa asthma.",
  ),
  "MED-018": Medicine(
    name: "Levothyroxine",
    code: "MED-018",
    description: "Thyroid hormone replacement.",
    isAuthentic: true,
    expiryDate: "2027-03-12",
    illnessSuggestions: ["Hypothyroidism"],
    alternatives: ["Liothyronine", "Natural Thyroid"],
    voiceText:
        "Levothyroxine: Para sa thyroid. Sa Cebuano: Para sa thyroid. Sa Tagalog: Para sa thyroid.",
  ),
  "MED-019": Medicine(
    name: "Gabapentin",
    code: "MED-019",
    description: "For nerve pain and seizures.",
    isAuthentic: true,
    expiryDate: "2026-04-28",
    illnessSuggestions: ["Neuropathic Pain", "Epilepsy"],
    alternatives: ["Pregabalin", "Carbamazepine"],
    voiceText:
        "Gabapentin: Para sa sakit sa nerbiyos. Sa Cebuano: Para sa sakit sa nerbiyos. Sa Tagalog: Para sa sakit ng nerbiyos.",
  ),
  "MED-020": Medicine(
    name: "Sertraline",
    code: "MED-020",
    description: "Antidepressant.",
    isAuthentic: true,
    expiryDate: "2026-03-15",
    illnessSuggestions: ["Depression", "Anxiety"],
    alternatives: ["Fluoxetine", "Escitalopram"],
    voiceText:
        "Sertraline: Para sa depression. Sa Cebuano: Para sa depression. Sa Tagalog: Para sa depression.",
  ),

  // Example of a counterfeit/unverified medicine (for testing alerts)
  "FAKE-001": Medicine(
    name: "Fake Paracetamol",
    code: "FAKE-001",
    description: "Counterfeit version - do not use.",
    isAuthentic: false,
    expiryDate: "2024-01-01", // Expired
    illnessSuggestions: [],
    alternatives: [],
    voiceText:
        "Warning: Kini counterfeit! Sa Cebuano: Warning: Kini counterfeit! Sa Tagalog: Babala: Ito ay counterfeit!",
  ),
};

// Helper function to search by name (for input_screen.dart)
Medicine? searchByName(String name) {
  for (var med in medicineDatabase.values) {
    if (med.name.toLowerCase() == name.toLowerCase()) {
      return med;
    }
  }
  return null;
}
