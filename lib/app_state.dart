import 'package:flutter/material.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
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
    _safeInit(() {
      _transactionHistory = prefs
              .getStringList('ff_transactionHistory')
              ?.map((x) {
                try {
                  return TransactionStruct.fromSerializableMap(jsonDecode(x));
                } catch (e) {
                  print("Can't decode persisted data type. Error: $e.");
                  return null;
                }
              })
              .withoutNulls
              .toList() ??
          _transactionHistory;
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

  List<TransactionStruct> _transactionHistory = [];
  List<TransactionStruct> get transactionHistory => _transactionHistory;
  set transactionHistory(List<TransactionStruct> value) {
    _transactionHistory = value;
    prefs.setStringList(
        'ff_transactionHistory', value.map((x) => x.serialize()).toList());
  }

  void addToTransactionHistory(TransactionStruct value) {
    transactionHistory.add(value);
    prefs.setStringList('ff_transactionHistory',
        _transactionHistory.map((x) => x.serialize()).toList());
  }

  void removeFromTransactionHistory(TransactionStruct value) {
    transactionHistory.remove(value);
    prefs.setStringList('ff_transactionHistory',
        _transactionHistory.map((x) => x.serialize()).toList());
  }

  void removeAtIndexFromTransactionHistory(int index) {
    transactionHistory.removeAt(index);
    prefs.setStringList('ff_transactionHistory',
        _transactionHistory.map((x) => x.serialize()).toList());
  }

  void updateTransactionHistoryAtIndex(
    int index,
    TransactionStruct Function(TransactionStruct) updateFn,
  ) {
    transactionHistory[index] = updateFn(_transactionHistory[index]);
    prefs.setStringList('ff_transactionHistory',
        _transactionHistory.map((x) => x.serialize()).toList());
  }

  void insertAtIndexInTransactionHistory(int index, TransactionStruct value) {
    transactionHistory.insert(index, value);
    prefs.setStringList('ff_transactionHistory',
        _transactionHistory.map((x) => x.serialize()).toList());
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
