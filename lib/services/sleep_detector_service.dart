import 'dart:async';
import 'dart:math';
import '../models/sleep_record.dart';

class SleepDetectorService {
  bool _isRecording = false;
  Timer? _timer;
  final List<SleepRecord> _records = [];
  final StreamController<int> _irregularitiesController = StreamController<int>.broadcast();
  final StreamController<List<SleepRecord>> _recordsController = StreamController<List<SleepRecord>>.broadcast();
  int _currentIrregularities = 0;

  Stream<int> get irregularitiesStream => _irregularitiesController.stream;
  Stream<List<SleepRecord>> get recordsStream => _recordsController.stream;
  bool get isRecording => _isRecording;

  SleepDetectorService() {
    // Load some sample data
    _loadSampleData();
  }

  void _loadSampleData() {
    final now = DateTime.now();
    
    _records.add(SleepRecord(
      date: now.subtract(const Duration(days: 1)),
      irregularities: 3,
      risk: 'LOW',
      session: '3/5',
    ));
    
    _records.add(SleepRecord(
      date: now.subtract(const Duration(days: 2)),
      irregularities: 7,
      risk: 'MED',
      session: '3/7',
    ));
    
    _records.add(SleepRecord(
      date: now.subtract(const Duration(days: 3)),
      irregularities: 12,
      risk: 'HIGH',
      session: '3/8',
    ));
    
    _records.add(SleepRecord(
      date: now.subtract(const Duration(days: 4)),
      irregularities: 4,
      risk: 'LOW',
      session: '3/6',
    ));
    
    _recordsController.add(_records);
  }

  void startRecording() {
    if (_isRecording) return;
    
    _isRecording = true;
    _currentIrregularities = 0;
    _irregularitiesController.add(_currentIrregularities);
    
    // Simulate irregularities detection
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      // Randomly detect irregularities (this is where your AI model would be integrated)
      if (Random().nextDouble() < 0.3) {
        _currentIrregularities++;
        _irregularitiesController.add(_currentIrregularities);
      }
    });
  }

  Future<SleepRecord> stopRecording() async {
    if (!_isRecording) throw Exception('Not recording');
    
    _isRecording = false;
    _timer?.cancel();
    
    // Determine risk level
    String risk = 'LOW';
    String session = '3/5';
    
    if (_currentIrregularities > 10) {
      risk = 'HIGH';
      session = '3/8';
    } else if (_currentIrregularities > 5) {
      risk = 'MED';
      session = '3/7';
    } else if (_currentIrregularities > 3) {
      risk = 'LOW';
      session = '3/6';
    }
    
    final record = SleepRecord(
      date: DateTime.now(),
      irregularities: _currentIrregularities,
      risk: risk,
      session: session,
    );
    
    _records.insert(0, record); // Add to beginning of list
    _recordsController.add(_records);
    
    return record;
  }

  List<SleepRecord> getRecords() {
    return List.from(_records);
  }

  void dispose() {
    _timer?.cancel();
    _irregularitiesController.close();
    _recordsController.close();
  }
}