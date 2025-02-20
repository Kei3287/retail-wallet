// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:collection';

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
import 'dart:io';
import 'package:web3auth_flutter/enums.dart';
import 'package:web3auth_flutter/input.dart';
import 'package:web3auth_flutter/web3auth_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../app_constants.dart';

Future<bool> initializeWeb3Auth() async {
  try {
    Uri redirectUrl;
    final clientId = FFDevEnvironmentValues().web3AuthClientId;

    if (Platform.isAndroid) {
      redirectUrl = Uri.parse('w3a://rlusd.com');
    } else if (Platform.isIOS) {
      redirectUrl = Uri.parse('rlusd.com://auth');
    } else {
      throw UnKnownException('Unknown platform');
    }

    final loginConfig = HashMap<String, LoginConfigItem>();

    loginConfig['jwt'] = LoginConfigItem(
      verifier: FFDevEnvironmentValues()
          .web3AuthVerifierName, // get it from web3auth dashboard
      typeOfLogin: TypeOfLogin.jwt,
      name: "Firebase JWT Login",
      clientId: FFDevEnvironmentValues()
          .web3AuthClientId, // web3auth's plug and play client id
    );

    await Web3AuthFlutter.init(
      Web3AuthOptions(
        clientId: clientId,
        network: FFDevEnvironmentValues.currentEnvironment.toLowerCase() !=
                FFAppConstants.production.toLowerCase()
            ? Network.sapphire_devnet
            : Network.sapphire_mainnet,
        redirectUrl: redirectUrl,
        loginConfig: loginConfig,
        // mfaSettings: TODO
        // buildEnv: BuildEnv.production.name == FFAppConstants.env ? BuildEnv.production : BuildEnv.testing,
        sessionTime: 2592000, // 30 days
        // whiteLabel: WhiteLabelData(
        //   defaultLanguage: Language.ja,
        // ),
      ),
    );

    await Web3AuthFlutter.initialize();

    // Check if user is already logged in
    final privateKey = await Web3AuthFlutter.getPrivKey();
    return privateKey.isNotEmpty;
  } catch (e) {
    debugPrint("Web3Auth initialization error: $e");
    return false;
  }
}
