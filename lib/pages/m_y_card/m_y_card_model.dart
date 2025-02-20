import '/backend/schema/enums/enums.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'm_y_card_widget.dart' show MYCardWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MYCardModel extends FlutterFlowModel<MYCardWidget> {
  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - getRLUSDBalance] action in MY_Card widget.
  double? rlusdBalance;
  // Stores action output result for [Custom Action - getrlusdTransactionHistory] action in MY_Card widget.
  List<TransactionStruct>? transactionsResult;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
