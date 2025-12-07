class ScanResult {
  final String id;
  final String patientName;
  final int age;
  final String riskLevel; // 'Low', 'Medium', 'High', 'Critical'
  final double confidence;
  final DateTime scanDate;
  final List<String> findings;
  final String? imageUrl;
  final List<String> symptoms;
  final String status; // 'Normal', 'Suspicious', 'High Risk', 'Critical'
  final double detectionScore; // 0.0 to 1.0

  ScanResult({
    required this.id,
    required this.patientName,
    required this.age,
    required this.riskLevel,
    required this.confidence,
    required this.scanDate,
    required this.findings,
    this.imageUrl,
    required this.symptoms,
    required this.status,
    required this.detectionScore,
  });

  bool get hasAbnormality => riskLevel != 'Low' && detectionScore > 0.3;
}
