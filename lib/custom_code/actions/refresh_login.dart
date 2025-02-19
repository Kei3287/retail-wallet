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
import 'package:firebase_auth/firebase_auth.dart';
import 'package:web3auth_flutter/enums.dart';
import 'package:web3auth_flutter/input.dart';
import 'package:web3auth_flutter/web3auth_flutter.dart';

// If the login session for web3auth is expired while the idToken is updated on firebase,
// we need to update the session for web3auth using the new idToken
Future<bool> refreshLogin() async {
  try {
    final idToken = await FirebaseAuth.instance.currentUser?.getIdToken(true);
    if (idToken == null || idToken.isEmpty) {
      throw Exception('The new IdToken is null or empty.');
    }
    await Web3AuthFlutter.login(
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

    return true;
  } catch (e) {
    debugPrint('Error refreshing login: $e');
    return false;
  }
}
