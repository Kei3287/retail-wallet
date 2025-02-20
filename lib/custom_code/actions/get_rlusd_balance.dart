// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!

import '/flutter_flow/custom_functions.dart'; // Imports custom functionsimport 'package:flutter/material.dart';

import 'package:web3dart/web3dart.dart';
import 'package:flutter/foundation.dart';
import '../web3_client_manager.dart';
import 'get_wallet_address.dart';

Future<double> getRLUSDBalance() async {
  try {
    final address = await getWalletAddress();
    if (address.isEmpty) {
      throw Exception('Failed to get wallet address');
    }

    final web3Client = Web3ClientManager().client;
    final contract = Web3ClientManager().rlusdContract;
    if (web3Client == null || contract == null) {
      throw Exception('Web3Client or RLUSD contract not initialized');
    }

    final balance = await web3Client.call(
      contract: contract,
      function: contract.function('balanceOf'),
      params: [EthereumAddress.fromHex(address)],
    );

    // Convert from Wei (18 decimals for RLUSD contract)
    final balanceInRlusd = balance[0] ~/ BigInt.from(10).pow(18);
    return balanceInRlusd.toDouble();
  } catch (e) {
    debugPrint('Failed to get RLUSD balance: $e');
    return 0;
  }
}
