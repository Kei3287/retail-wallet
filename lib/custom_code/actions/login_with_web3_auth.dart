// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
import 'package:web3auth_flutter/enums.dart';
import 'package:web3auth_flutter/input.dart';
import 'package:web3auth_flutter/web3auth_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../app_state.dart';

Future<bool> loginWithWeb3Auth(BuildContext context, String idToken) async {
  try {
    final response = await Web3AuthFlutter.login(
      LoginParams(
        loginProvider: Provider.jwt,
        extraLoginOptions: ExtraLoginOptions(
          id_token: idToken,
          domain: 'https://${FFDevEnvironmentValues().firebaseAuthDomain}',
          verifierIdField: "sub",
        ),
        mfaLevel: MFALevel.MANDATORY,
      ),
    );

    final address = await getWalletAddress();
    if (address.isEmpty) {
      throw Exception('Failed to get wallet address after login.');
    }
    return response.privKey?.isNotEmpty ?? false;
  } catch (e) {
    debugPrint("Web3Auth login error: $e");
    // await logoutFromWeb3Auth();
    await FirebaseAuth.instance.signOut();
    return false;
  }
}
