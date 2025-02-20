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

import '/flutter_flow/custom_functions.dart'; // Imports custom functionsimport 'package:flutter/material.dart';

import '../../backend/schema/enums/enums.dart';
import '../../backend/schema/structs/transaction_struct.dart';
import '/flutter_flow/custom_functions.dart'; // Imports custom functionsimport 'package:flutter/material.dart';

import 'package:web3dart/web3dart.dart';
import 'package:flutter/foundation.dart';
import '../web3_client_manager.dart';

Future<List<TransactionStruct>> getrlusdTransactionHistory(
    String address) async {
  try {
    if (address.isEmpty) {
      throw Exception('Failed to get wallet address');
    }

    final web3Client = Web3ClientManager().client;
    final rlusdContract = Web3ClientManager().rlusdContract;

    if (web3Client == null || rlusdContract == null) {
      throw Exception('Web3Client or rlusd contract not initialized');
    }
    final EthereumAddress userAddress = EthereumAddress.fromHex(address);

    // Define the Transfer event signature
    final transferEvent = rlusdContract.event('Transfer');
    final int latestBlock = await web3Client.getBlockNumber();
    
    // Create a filter for Transfer events involving the user's address
    final filter = FilterOptions.events(
      contract: rlusdContract,
      event: transferEvent,
      fromBlock: BlockNum.exact(latestBlock - 4000),
      toBlock: BlockNum.exact(latestBlock),
    );

    final List<FilterEvent> logs = await web3Client.getLogs(filter);

    // Decode the logs into transaction history
    List<TransactionStruct> transactions = [];

    for (var log in logs) {
      final decoded = transferEvent.decodeResults(log.topics!, log.data!);
      if (decoded.length != 3) {
        throw Exception('Failed to decode transaction. decoded: $decoded');
      }
      final from = decoded[0] as EthereumAddress;
      final to = decoded[1] as EthereumAddress;
      final value = decoded[2] as BigInt; // Convert to rlusd decimal format

      // skip this transaction if it is not relevent
      if ((from.hex != userAddress.hex && to.hex != userAddress.hex) ||
          value.toInt() == 0) {
        continue;
      }

      TransactionStruct tx = TransactionStruct(
        from: from.hex,
        to: to.hex,
        value: (value / BigInt.from(10).pow(18)).toDouble(),
        blockNumber: log.blockNum.toString(),
        transactionHash: log.transactionHash,
        type: from.hex == userAddress.hex
            ? TransactionType.send
            : TransactionType.receive,
      );
      // if (log.blockNum != null) {
      //   final String hexBlockNumber = '0x${log.blockNum?.toRadixString(16)}';
      //   final block =
      //       await web3Client.getBlockInformation(blockNumber: hexBlockNumber);
      //   tx.date = block.timestamp;
      // }
      transactions.add(tx);
    }

    return transactions;
  } catch (e) {
    debugPrint('Failed to get rlusd transaction history: $e');
    return [];
  }
}
