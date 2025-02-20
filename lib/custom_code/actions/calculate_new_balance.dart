// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '/flutter_flow/custom_functions.dart'; // Imports custom functionsimport 'package:flutter/material.dart';

Future<double> calculateNewBalance(double balance, String amount) async {
  final amountDouble = double.parse(amount);
  if (balance - amountDouble < 0) {
    throw Exception('Insufficient funds');
  }
  return balance - amountDouble;
}
