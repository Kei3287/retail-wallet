import 'dart:convert';
import 'package:flutter/services.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFDevEnvironmentValues {
  static const String currentEnvironment = 'Development';
  static const String environmentValuesPath =
      'assets/environment_values/environment.json';

  static final FFDevEnvironmentValues _instance =
      FFDevEnvironmentValues._internal();

  factory FFDevEnvironmentValues() {
    return _instance;
  }

  FFDevEnvironmentValues._internal();

  Future<void> initialize() async {
    try {
      final String response =
          await rootBundle.loadString(environmentValuesPath);
      final data = await json.decode(response);
      _rlusdContractAddress = data['rlusdContractAddress'];
      _web3AuthClientId = data['web3AuthClientId'];
      _web3AuthVerifierName = data['web3AuthVerifierName'];
      _firebaseAuthDomain = data['firebaseAuthDomain'];
    } catch (e) {
      print('Error loading environment values: $e');
    }
  }

  String _rlusdContractAddress = '';
  String get rlusdContractAddress => _rlusdContractAddress;

  String _web3AuthClientId = '';
  String get web3AuthClientId => _web3AuthClientId;

  String _web3AuthVerifierName = '';
  String get web3AuthVerifierName => _web3AuthVerifierName;

  String _firebaseAuthDomain = '';
  String get firebaseAuthDomain => _firebaseAuthDomain;
}
