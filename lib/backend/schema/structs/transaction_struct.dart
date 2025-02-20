// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TransactionStruct extends FFFirebaseStruct {
  TransactionStruct({
    String? from,
    String? to,
    double? value,
    String? blockNumber,
    String? transactionHash,
    TransactionType? type,
    DateTime? date,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _from = from,
        _to = to,
        _value = value,
        _blockNumber = blockNumber,
        _transactionHash = transactionHash,
        _type = type,
        _date = date,
        super(firestoreUtilData);

  // "from" field.
  String? _from;
  String get from => _from ?? '';
  set from(String? val) => _from = val;

  bool hasFrom() => _from != null;

  // "to" field.
  String? _to;
  String get to => _to ?? '';
  set to(String? val) => _to = val;

  bool hasTo() => _to != null;

  // "value" field.
  double? _value;
  double get value => _value ?? 0.0;
  set value(double? val) => _value = val;

  void incrementValue(double amount) => value = value + amount;

  bool hasValue() => _value != null;

  // "blockNumber" field.
  String? _blockNumber;
  String get blockNumber => _blockNumber ?? '';
  set blockNumber(String? val) => _blockNumber = val;

  bool hasBlockNumber() => _blockNumber != null;

  // "transactionHash" field.
  String? _transactionHash;
  String get transactionHash => _transactionHash ?? '';
  set transactionHash(String? val) => _transactionHash = val;

  bool hasTransactionHash() => _transactionHash != null;

  // "type" field.
  TransactionType? _type;
  TransactionType? get type => _type;
  set type(TransactionType? val) => _type = val;

  bool hasType() => _type != null;

  // "date" field.
  DateTime? _date;
  DateTime? get date => _date;
  set date(DateTime? val) => _date = val;

  bool hasDate() => _date != null;

  static TransactionStruct fromMap(Map<String, dynamic> data) =>
      TransactionStruct(
        from: data['from'] as String?,
        to: data['to'] as String?,
        value: castToType<double>(data['value']),
        blockNumber: data['blockNumber'] as String?,
        transactionHash: data['transactionHash'] as String?,
        type: data['type'] is TransactionType
            ? data['type']
            : deserializeEnum<TransactionType>(data['type']),
        date: data['date'] as DateTime?,
      );

  static TransactionStruct? maybeFromMap(dynamic data) => data is Map
      ? TransactionStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'from': _from,
        'to': _to,
        'value': _value,
        'blockNumber': _blockNumber,
        'transactionHash': _transactionHash,
        'type': _type?.serialize(),
        'date': _date,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'from': serializeParam(
          _from,
          ParamType.String,
        ),
        'to': serializeParam(
          _to,
          ParamType.String,
        ),
        'value': serializeParam(
          _value,
          ParamType.double,
        ),
        'blockNumber': serializeParam(
          _blockNumber,
          ParamType.String,
        ),
        'transactionHash': serializeParam(
          _transactionHash,
          ParamType.String,
        ),
        'type': serializeParam(
          _type,
          ParamType.Enum,
        ),
        'date': serializeParam(
          _date,
          ParamType.DateTime,
        ),
      }.withoutNulls;

  static TransactionStruct fromSerializableMap(Map<String, dynamic> data) =>
      TransactionStruct(
        from: deserializeParam(
          data['from'],
          ParamType.String,
          false,
        ),
        to: deserializeParam(
          data['to'],
          ParamType.String,
          false,
        ),
        value: deserializeParam(
          data['value'],
          ParamType.double,
          false,
        ),
        blockNumber: deserializeParam(
          data['blockNumber'],
          ParamType.String,
          false,
        ),
        transactionHash: deserializeParam(
          data['transactionHash'],
          ParamType.String,
          false,
        ),
        type: deserializeParam<TransactionType>(
          data['type'],
          ParamType.Enum,
          false,
        ),
        date: deserializeParam(
          data['date'],
          ParamType.DateTime,
          false,
        ),
      );

  @override
  String toString() => 'TransactionStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is TransactionStruct &&
        from == other.from &&
        to == other.to &&
        value == other.value &&
        blockNumber == other.blockNumber &&
        transactionHash == other.transactionHash &&
        type == other.type &&
        date == other.date;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([from, to, value, blockNumber, transactionHash, type, date]);
}

TransactionStruct createTransactionStruct({
  String? from,
  String? to,
  double? value,
  String? blockNumber,
  String? transactionHash,
  TransactionType? type,
  DateTime? date,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    TransactionStruct(
      from: from,
      to: to,
      value: value,
      blockNumber: blockNumber,
      transactionHash: transactionHash,
      type: type,
      date: date,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

TransactionStruct? updateTransactionStruct(
  TransactionStruct? transaction, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    transaction
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addTransactionStructData(
  Map<String, dynamic> firestoreData,
  TransactionStruct? transaction,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (transaction == null) {
    return;
  }
  if (transaction.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && transaction.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final transactionData =
      getTransactionFirestoreData(transaction, forFieldValue);
  final nestedData =
      transactionData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = transaction.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getTransactionFirestoreData(
  TransactionStruct? transaction, [
  bool forFieldValue = false,
]) {
  if (transaction == null) {
    return {};
  }
  final firestoreData = mapToFirestore(transaction.toMap());

  // Add any Firestore field values
  transaction.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getTransactionListFirestoreData(
  List<TransactionStruct>? transactions,
) =>
    transactions?.map((e) => getTransactionFirestoreData(e, true)).toList() ??
    [];
