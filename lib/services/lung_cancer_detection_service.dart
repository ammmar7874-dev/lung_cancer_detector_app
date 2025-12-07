import '../models/scan_result.dart';
import 'dart:math';

class LungCancerDetectionService {
  static final List<ScanResult> _scanHistory = [
    ScanResult(
      id: 'SCAN001',
      patientName: 'John Doe',
      age: 45,
      riskLevel: 'Low',
      confidence: 0.92,
      scanDate: DateTime.now().subtract(const Duration(days: 2)),
      findings: [
        'Clear lung fields',
        'No nodules detected',
        'Normal lung structure',
      ],
      symptoms: ['No symptoms reported'],
      status: 'Normal',
      detectionScore: 0.05,
    ),
    ScanResult(
      id: 'SCAN002',
      patientName: 'Jane Smith',
      age: 58,
      riskLevel: 'High',
      confidence: 0.87,
      scanDate: DateTime.now().subtract(const Duration(days: 1)),
      findings: [
        'Small nodule detected in right upper lobe',
        'Irregular margins observed',
        'Follow-up recommended',
      ],
      symptoms: ['Persistent cough', 'Shortness of breath'],
      status: 'Suspicious',
      detectionScore: 0.68,
    ),
    ScanResult(
      id: 'SCAN003',
      patientName: 'Robert Johnson',
      age: 62,
      riskLevel: 'Medium',
      confidence: 0.75,
      scanDate: DateTime.now().subtract(const Duration(hours: 5)),
      findings: ['Minor opacity in left lung', 'Requires monitoring'],
      symptoms: ['Mild chest discomfort'],
      status: 'Suspicious',
      detectionScore: 0.42,
    ),
    ScanResult(
      id: 'SCAN004',
      patientName: 'Mary Williams',
      age: 55,
      riskLevel: 'Critical',
      confidence: 0.95,
      scanDate: DateTime.now().subtract(const Duration(hours: 2)),
      findings: [
        'Large mass detected in right lung',
        'Irregular shape and borders',
        'Immediate medical consultation required',
      ],
      symptoms: ['Severe cough', 'Chest pain', 'Weight loss', 'Fatigue'],
      status: 'High Risk',
      detectionScore: 0.89,
    ),
  ];

  static Future<ScanResult> scanImage({
    required String patientName,
    required int age,
    String? imagePath,
  }) async {
    // Simulate AI processing delay
    await Future.delayed(const Duration(seconds: 3));

    // Advanced detection logic (simulating AI/ML analysis)
    final random = Random(DateTime.now().millisecondsSinceEpoch);
    double detectionScore = 0.0;
    String riskLevel = 'Low';
    String status = 'Normal';
    List<String> findings = [];
    List<String> symptoms = [];

    // Age-based risk factor
    double ageRisk = 0.0;
    if (age >= 60) {
      ageRisk = 0.3;
    } else if (age >= 50) {
      ageRisk = 0.2;
    } else if (age >= 40) {
      ageRisk = 0.1;
    }

    // Simulate AI detection (combining age risk with random analysis)
    detectionScore = ageRisk + (random.nextDouble() * 0.5);

    // Determine findings based on detection score
    if (detectionScore > 0.7) {
      riskLevel = 'Critical';
      status = 'High Risk';
      findings = [
        'Significant abnormality detected',
        'Mass or nodule with irregular borders',
        'Immediate medical consultation required',
        'Biopsy recommended',
      ];
      symptoms = [
        'Persistent cough',
        'Chest pain',
        'Shortness of breath',
        'Weight loss',
      ];
    } else if (detectionScore > 0.5) {
      riskLevel = 'High';
      status = 'Suspicious';
      findings = [
        'Nodule or opacity detected',
        'Irregular margins observed',
        'Follow-up scan recommended',
        'Consult with pulmonologist',
      ];
      symptoms = ['Cough', 'Chest discomfort', 'Fatigue'];
    } else if (detectionScore > 0.3) {
      riskLevel = 'Medium';
      status = 'Suspicious';
      findings = [
        'Minor opacity detected',
        'Requires monitoring',
        'Follow-up in 3-6 months',
      ];
      symptoms = ['Mild symptoms'];
    } else {
      riskLevel = 'Low';
      status = 'Normal';
      findings = [
        'Clear lung fields',
        'No nodules detected',
        'Normal lung structure',
      ];
      symptoms = ['No symptoms reported'];
    }

    // Add some randomness to findings
    if (random.nextDouble() > 0.7 && detectionScore > 0.3) {
      findings.add('Pleural thickening observed');
    }
    if (random.nextDouble() > 0.8 && detectionScore > 0.4) {
      findings.add('Lymph node enlargement');
    }

    final confidence = 0.75 + (random.nextDouble() * 0.2); // 75-95% confidence

    final result = ScanResult(
      id: 'SCAN${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
      patientName: patientName,
      age: age,
      riskLevel: riskLevel,
      confidence: confidence,
      scanDate: DateTime.now(),
      findings: findings,
      imageUrl: imagePath,
      symptoms: symptoms,
      status: status,
      detectionScore: detectionScore.clamp(0.0, 1.0),
    );

    _scanHistory.insert(0, result);
    return result;
  }

  static List<ScanResult> getScanHistory() {
    return List.from(_scanHistory);
  }

  static int getTotalScans() => _scanHistory.length;
  static int getHighRiskScans() => _scanHistory
      .where((s) => s.riskLevel == 'High' || s.riskLevel == 'Critical')
      .length;
  static int getNormalScans() =>
      _scanHistory.where((s) => s.riskLevel == 'Low').length;
  static int getSuspiciousScans() => _scanHistory
      .where((s) => s.status == 'Suspicious' || s.status == 'High Risk')
      .length;
}
