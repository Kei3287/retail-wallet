// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
import 'package:web3auth_flutter/web3auth_flutter.dart';

Future<String> getPrivateKey() async {
  String privateKey = await Web3AuthFlutter.getPrivKey();
  if (privateKey.isEmpty) {
    // try refreshing the session using the updated jwt from firebase auth
    await refreshLogin();
    privateKey = await Web3AuthFlutter.getPrivKey();
  }
  return privateKey;
}
