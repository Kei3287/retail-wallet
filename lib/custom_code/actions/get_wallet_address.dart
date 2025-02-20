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

import 'package:web3dart/web3dart.dart';

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web3auth_flutter/web3auth_flutter.dart';

Future<String> getWalletAddress() async {
  try {
    final appState = FFAppState();

    final privateKey = await getPrivateKey();
    if (privateKey.isEmpty) {
      throw Exception('privateKey is null or empty. User must be logged in.');
    }
    final credentials = EthPrivateKey.fromHex(privateKey);
    appState.walletAddress = credentials.address.hexEip55;
    return credentials.address.hexEip55;
  } catch (e) {
    debugPrint('Failed to get the wallet address: $e');
    return '';
  }
}
