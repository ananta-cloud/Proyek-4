import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CounterController {
  int _counter = 0;
  int _step = 1;

  // int get value => _counter;
  // int get step => _step;
  // List<String> get history => _history.reversed.take(5).toList();

  final List<Map<String, dynamic>> _history = []; // simpan Map
  int get value => _counter;
  int get step => _step;
  List<Map<String, dynamic>> get history => _history.reversed.take(5).toList();

  void setStep(int newStep) {
    if (newStep > 0) {
      _step = newStep;
    }
  }

  void increment() {
    _counter += _step;
    _addHistory("Nilai ditambah sebesar $_step", Colors.green);
  }

  void decrement() {
    if (_counter >= _step) {
      _counter -= _step;
      _addHistory("Nilai dikurang sebesar $_step", Colors.red);
    } else if (_counter == 0) {
      _addHistory("Nilai sudah di 0", Colors.red);
    } else if (_counter < _step) {
      _addHistory("Nilai terlalu kecil, tidak bisa dikurang", Colors.red);
    }
  }

  void reset() {
    _counter = 0;
    _addHistory("Nilai direset", Colors.red);
  }

  void _addHistory(String action, Color color) {
    final now = DateFormat.Hm().format(DateTime.now());
    _history.add({"text": action, "color": color, "time": now});
  }

  
}
