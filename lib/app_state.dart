import 'package:flutter/material.dart';
import '/backend/backend.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _rlusdBalance = prefs.getDouble('ff_rlusdBalance') ?? _rlusdBalance;
    });
    _safeInit(() {
      _walletAddress = prefs.getString('ff_walletAddress') ?? _walletAddress;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  double _rlusdBalance = 0.0;
  double get rlusdBalance => _rlusdBalance;
  set rlusdBalance(double value) {
    _rlusdBalance = value;
    prefs.setDouble('ff_rlusdBalance', value);
  }

  String _walletAddress = '';
  String get walletAddress => _walletAddress;
  set walletAddress(String value) {
    _walletAddress = value;
    prefs.setString('ff_walletAddress', value);
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
