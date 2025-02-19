// Automatic FlutterFlow imports
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart' as http;

import '../app_constants.dart';
import '../environment_values.dart';

// Singleton class to manage Web3Client (We cannot store web3Client in app state because it is not serializable)
class Web3ClientManager {
  static final Web3ClientManager _instance = Web3ClientManager._internal();
  Web3Client? _web3Client;
  DeployedContract? _rlusdContract;

  // ERC20 ABI
  static const String _erc20ABI = '''[
    {
      "inputs": [
        {
          "internalType": "address",
          "name": "account",
          "type": "address"
        }
      ],
      "name": "balanceOf",
      "outputs": [
        {
          "internalType": "uint256",
          "name": "",
          "type": "uint256"
        }
      ],
      "stateMutability": "view",
      "type": "function"
    },
    {
      "constant": false,
      "inputs": [
        {
          "name": "recipient",
          "type": "address"
        },
        {
          "name": "amount",
          "type": "uint256"
        }
      ],
      "name": "transfer",
      "outputs": [
        {
          "name": "",
          "type": "bool"
        }
      ],
      "payable": false,
      "stateMutability": "nonpayable",
      "type": "function"
    },
    {
      "anonymous": false,
      "inputs": [
        {"indexed": true, "internalType": "address", "name": "from", "type": "address"},
        {"indexed": true, "internalType": "address", "name": "to", "type": "address"},
        {"indexed": false, "internalType": "uint256", "name": "value", "type": "uint256"}
      ],
      "name": "Transfer",
      "type": "event"
    }
  ]''';

  factory Web3ClientManager() {
    return _instance;
  }

  Web3ClientManager._internal();

  Web3Client? get client => _web3Client;
  DeployedContract? get rlusdContract => _rlusdContract;

  void initialize(String rpcUrl) {
    _web3Client?.dispose();
    _web3Client = Web3Client(rpcUrl, http.Client());

    final contractAddress = FFDevEnvironmentValues().rlusdContractAddress;
    if (contractAddress.isEmpty) {
      throw Exception('rlusd contract address is not set.');
    }
    _rlusdContract = DeployedContract(
      ContractAbi.fromJson(_erc20ABI, 'rlusdl'),
      EthereumAddress.fromHex(contractAddress),
    );
  }

  void dispose() {
    _web3Client?.dispose();
    _web3Client = null;
    _rlusdContract = null;
  }
}
