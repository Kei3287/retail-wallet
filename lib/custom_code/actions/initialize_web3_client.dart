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
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../web3_client_manager.dart';

Future<bool> initializeWeb3Client() async {
  try {
    // TODO: replace the public rpc endpoints with private endpoints
    final String rpcUrl =
        FFDevEnvironmentValues.currentEnvironment.toLowerCase() !=
                FFAppConstants.production.toLowerCase()
            ? 'https://ethereum-sepolia.publicnode.com'
            : 'https://ethereum.publicnode.com';

    // Initialize the Web3Client using the singleton manager
    Web3ClientManager().initialize(rpcUrl);

    return true;
  } catch (e) {
    debugPrint('Error initializing Web3Client: $e');
    return false;
  }
}
