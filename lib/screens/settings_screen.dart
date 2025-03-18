import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notifyHighRisk = true;
  bool _autoRecording = false;
  int _sensitivityLevel = 2; // 1-3, where 3 is most sensitive
  String _recordingDuration = '8 hours';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: AppTheme.backgroundColor,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSectionTitle('Recording Settings'),
          _buildSettingItem(
            'Auto Recording',
            'Start recording automatically at bedtime',
            Switch(
              value: _autoRecording,
              onChanged: (value) {
                setState(() {
                  _autoRecording = value;
                });
              },
              activeColor: AppTheme.primaryColor,
            ),
          ),
          _buildSettingItem(
            'Recording Duration',
            _recordingDuration,
            DropdownButton<String>(
              value: _recordingDuration,
              items: ['6 hours', '8 hours', '10 hours', 'Until stopped'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _recordingDuration = value;
                  });
                }
              },
              style: const TextStyle(color: Colors.white),
              dropdownColor: AppTheme.cardColor,
              underline: Container(),
            ),
          ),
          _buildSectionTitle('Detection Settings'),
          _buildSettingItem(
            'Sensitivity',
            'Adjust detection sensitivity',
            Slider(
              value: _sensitivityLevel.toDouble(),
              min: 1,
              max: 3,
              divisions: 2,
              label: _getSensitivityLabel(),
              onChanged: (value) {
                setState(() {
                  _sensitivityLevel = value.round();
                });
              },
              activeColor: AppTheme.primaryColor,
            ),
          ),
          _buildSectionTitle('Notifications'),
          _buildSettingItem(
            'High Risk Alerts',
            'Get notified for high risk results',
            Switch(
              value: _notifyHighRisk,
              onChanged: (value) {
                setState(() {
                  _notifyHighRisk = value;
                });
              },
              activeColor: AppTheme.primaryColor,
            ),
          ),
          _buildSectionTitle('App Info'),
          ListTile(
            title: const Text('About RespireGuard'),
            subtitle: const Text('Version 1.0.0'),
            onTap: () {
              _showAboutDialog();
            },
            trailing: const Icon(Icons.info_outline, color: Colors.white70),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppTheme.primaryColor,
        ),
      ),
    );
  }

  Widget _buildSettingItem(String title, String subtitle, Widget trailing) {
    return Card(
      color: AppTheme.cardColor,
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(title, style: const TextStyle(color: Colors.white)),
        subtitle: Text(subtitle, style: const TextStyle(color: Colors.white70)),
        trailing: trailing,
      ),
    );
  }

  String _getSensitivityLabel() {
    switch (_sensitivityLevel) {
      case 1:
        return 'Low';
      case 2:
        return 'Medium';
      case 3:
        return 'High';
      default:
        return 'Medium';
    }
  }

  void _showAboutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppTheme.cardColor,
          title: const Text('About RespireGuard', style: TextStyle(color: Colors.white)),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'RespireGuard is an AI-powered sleep apnea detection app that monitors your breathing patterns during sleep.',
                style: TextStyle(color: Colors.white70),
              ),
              SizedBox(height: 16),
              Text(
                'This app is designed to help users identify potential sleep apnea symptoms and track their sleep quality over time.',
                style: TextStyle(color: Colors.white70),
              ),
              SizedBox(height: 16),
              Text(
                'Disclaimer: This app is not a medical device and should not replace professional medical advice.',
                style: TextStyle(color: AppTheme.highRiskColor, fontSize: 12),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Close', style: TextStyle(color: AppTheme.primaryColor)),
            ),
          ],
        );
      },
    );
  }
}