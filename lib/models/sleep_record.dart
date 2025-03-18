// models/sleep_record.dart
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class SleepRecord {
  final DateTime date;
  final int irregularities;
  final String risk;
  final String session;

  SleepRecord({
    required this.date,
    required this.irregularities,
    required this.risk,
    required this.session,
  });

  factory SleepRecord.fromJson(Map<String, dynamic> json) {
    return SleepRecord(
      date: DateTime.parse(json['date']),
      irregularities: json['irregularities'],
      risk: json['risk'],
      session: json['session'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String(),
      'irregularities': irregularities,
      'risk': risk,
      'session': session,
    };
  }

  // Helper method to determine risk level color
  Color getRiskColor() {
    switch (risk.toLowerCase()) {
      case 'high':
        return AppTheme.highRiskColor;
      case 'med':
        return AppTheme.mediumRiskColor;
      case 'low':
        return AppTheme.lowRiskColor;
      default:
        return AppTheme.lowRiskColor;
    }
  }
}