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

import '/flutter_flow/custom_functions.dart'; // Imports custom functions

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
import 'package:web3auth_flutter/web3auth_flutter.dart';
import 'package:web3dart/web3dart.dart' as web3dart;
import 'package:flutter/foundation.dart';
import '../web3_client_manager.dart';
import 'get_wallet_address.dart';

Future<String> transfer(String recipientAddress, String amount) async {
  try {
    if (recipientAddress.isEmpty) {
      throw ArgumentError('RecipientAddress is empty,');
    }
    final amountDouble = double.parse(amount);
    final recipient = web3dart.EthereumAddress.fromHex(recipientAddress);
    final bigIntAmount = BigInt.from(
        (amountDouble * BigInt.from(10).pow(18).toDouble()).round());

    // RLUSD uses 18 decimals
    final value = bigIntAmount;

    final address = await getWalletAddress();
    if (address.isEmpty) {
      throw Exception('Failed to get wallet address');
    }

    final web3Client = Web3ClientManager().client;
    final contract = Web3ClientManager().rlusdContract;
    if (web3Client == null || contract == null) {
      throw Exception('Web3Client or RLUSD contract not initialized');
    }

    final privateKey = await getPrivateKey();
    if (privateKey.isEmpty) {
      throw Exception('privateKey is null or empty. User must be logged in.');
    }
    final credentials = web3dart.EthPrivateKey.fromHex(privateKey);

    final txHash = await web3Client.sendTransaction(
      credentials,
      web3dart.Transaction.callContract(
        contract: contract,
        function: contract.function('transfer'),
        parameters: [recipient, value],
        from: web3dart.EthereumAddress.fromHex(address),
      ),
      chainId: null,
      fetchChainIdFromNetworkId: true,
    );
    return txHash;
  } catch (e) {
    debugPrint('Failed to send RLUSD: $e');
    return '';
  }
}
