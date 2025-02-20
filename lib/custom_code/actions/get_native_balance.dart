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

import '../../custom_code/actions/get_wallet_address.dart';
import '../../custom_code/web3_client_manager.dart';
import 'package:web3dart/web3dart.dart';

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
import 'package:flutter/foundation.dart';
import 'package:web3auth_flutter/web3auth_flutter.dart';

Future<String> getNativeBalance() async {
  try {
    final address = await getWalletAddress();
    if (address.isEmpty) {
      throw Exception('Failed to get the wallet address.');
    }
    final web3Client = Web3ClientManager().client;
    if (web3Client == null) {
      throw Exception('Web3Client not initialized');
    }

    final balanceResponse =
        await web3Client.getBalance(EthereumAddress.fromHex(address));

    // Convert the balance to ether format, and round off to 4 decimal places.
    // EtherUnit.ether corresponds to POL on polygon chain
    final ethBalance =
        balanceResponse.getValueInUnit(EtherUnit.ether).toStringAsFixed(4);

    return ethBalance;
  } catch (e) {
    debugPrint('Failed to get the balance: $e');
    return '';
  }
}
