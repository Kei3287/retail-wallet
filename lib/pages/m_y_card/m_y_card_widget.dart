import '/backend/schema/enums/enums.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'm_y_card_model.dart';
export 'm_y_card_model.dart';

class MYCardWidget extends StatefulWidget {
  const MYCardWidget({super.key});

  static String routeName = 'MY_Card';
  static String routePath = '/mYCard';

  @override
  State<MYCardWidget> createState() => _MYCardWidgetState();
}

class _MYCardWidgetState extends State<MYCardWidget> {
  late MYCardModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MYCardModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.rlusdBalance = await actions.getRLUSDBalance();
      FFAppState().rlusdBalance = _model.rlusdBalance!;
      safeSetState(() {});
      _model.transactionsResult = await actions.getrlusdTransactionHistory(
        FFAppState().walletAddress,
      );
      if (_model.transactionsResult?.length != 0) {
        FFAppState().transactionHistory =
            _model.transactionsResult!.toList().cast<TransactionStruct>();
        safeSetState(() {});
      }
      await actions.getNativeBalance();
    });
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        automaticallyImplyLeading: false,
        title: Text(
          FFLocalizations.of(context).getText(
            'xn2so8km' /* My Wallet */,
          ),
          style: FlutterFlowTheme.of(context).displaySmall.override(
                fontFamily: 'Lexend',
                letterSpacing: 0.0,
              ),
        ),
        actions: [],
        centerTitle: false,
        elevation: 0.0,
      ),
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.sizeOf(context).width * 0.92,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 6.0,
                            color: Color(0x4B1A1F24),
                            offset: Offset(
                              0.0,
                              2.0,
                            ),
                          )
                        ],
                        gradient: LinearGradient(
                          colors: [Color(0xFF00968A), Color(0xFFF2A384)],
                          stops: [0.0, 1.0],
                          begin: AlignmentDirectional(0.94, -1.0),
                          end: AlignmentDirectional(-0.94, 1.0),
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                20.0, 24.0, 20.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  FFLocalizations.of(context).getText(
                                    '6t7n9ugd' /* Balance */,
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Lexend',
                                        color: FlutterFlowTheme.of(context)
                                            .textColor,
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                20.0, 8.0, 20.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  valueOrDefault<String>(
                                    formatNumber(
                                      FFAppState().rlusdBalance,
                                      formatType: FormatType.decimal,
                                      decimalType: DecimalType.periodDecimal,
                                      currency: '＄',
                                    ),
                                    '0.00',
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .displaySmall
                                      .override(
                                        fontFamily: 'Lexend',
                                        color: FlutterFlowTheme.of(context)
                                            .textColor,
                                        fontSize: 32.0,
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                20.0, 12.0, 20.0, 16.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  FFLocalizations.of(context).getText(
                                    'ic89l140' /* ※It may take a few minutes to ... */,
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodySmall
                                      .override(
                                        fontFamily: 'Lexend',
                                        color: FlutterFlowTheme.of(context)
                                            .alternate,
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.sizeOf(context).width * 1.0,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(0.0),
                    bottomRight: Radius.circular(0.0),
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(16.0),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(20.0, 16.0, 20.0, 0.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [],
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 0.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(3.0),
                            child: Container(
                              width: MediaQuery.sizeOf(context).width * 0.4,
                              height: 100.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .primaryBackground,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  context.pushNamed(
                                    TransferFundsWidget.routeName,
                                    extra: <String, dynamic>{
                                      kTransitionInfoKey: TransitionInfo(
                                        hasTransition: true,
                                        transitionType:
                                            PageTransitionType.bottomToTop,
                                        duration: Duration(milliseconds: 220),
                                      ),
                                    },
                                  );
                                },
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.swap_horiz_rounded,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      size: 40.0,
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 8.0, 0.0, 0.0),
                                      child: Text(
                                        FFLocalizations.of(context).getText(
                                          '8bnd6lco' /* Transfer */,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Lexend',
                                              letterSpacing: 0.0,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(1.0),
                            child: Container(
                              width: MediaQuery.sizeOf(context).width * 0.4,
                              height: 100.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .primaryBackground,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  context.pushNamed(
                                    TransferFundsWidget.routeName,
                                    extra: <String, dynamic>{
                                      kTransitionInfoKey: TransitionInfo(
                                        hasTransition: true,
                                        transitionType:
                                            PageTransitionType.bottomToTop,
                                        duration: Duration(milliseconds: 220),
                                      ),
                                    },
                                  );
                                },
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.wallet_sharp,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      size: 40.0,
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 8.0, 0.0, 0.0),
                                      child: Text(
                                        FFLocalizations.of(context).getText(
                                          '1qz20d2b' /* Withdraw */,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Lexend',
                                              letterSpacing: 0.0,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          20.0, 12.0, 20.0, 12.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            FFLocalizations.of(context).getText(
                              '27pb7ji4' /* Transaction */,
                            ),
                            style:
                                FlutterFlowTheme.of(context).bodySmall.override(
                                      fontFamily: 'Lexend',
                                      letterSpacing: 0.0,
                                    ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 24.0),
                      child: Builder(
                        builder: (context) {
                          final transactionsList = FFAppState()
                              .transactionHistory
                              .toList()
                              .take(10)
                              .toList();
                          if (transactionsList.isEmpty) {
                            return Center(
                              child: Image.asset(
                                'assets/images/noTransactions.png',
                                width: 230.0,
                                height: 300.0,
                                fit: BoxFit.fitWidth,
                              ),
                            );
                          }

                          return Column(
                            mainAxisSize: MainAxisSize.max,
                            children: List.generate(transactionsList.length,
                                (transactionsListIndex) {
                              final transactionsListItem =
                                  transactionsList[transactionsListIndex];
                              return Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 8.0),
                                child: Container(
                                  width:
                                      MediaQuery.sizeOf(context).width * 0.92,
                                  height: 70.0,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            8.0, 0.0, 0.0, 0.0),
                                        child: Card(
                                          clipBehavior:
                                              Clip.antiAliasWithSaveLayer,
                                          color: Color(0x6639D2C0),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(40.0),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Icon(
                                              Icons.monetization_on_rounded,
                                              color: Color(0xFFEFE0CA),
                                              size: 24.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  12.0, 0.0, 0.0, 0.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              if (transactionsListItem.type ==
                                                  TransactionType.send)
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 4.0, 0.0, 0.0),
                                                  child: Text(
                                                    FFLocalizations.of(context)
                                                        .getText(
                                                      'xs4cn7uk' /* Sent */,
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .titleSmall
                                                        .override(
                                                          fontFamily: 'Lexend',
                                                          color:
                                                              Color(0xFF39D2C0),
                                                          letterSpacing: 0.0,
                                                        ),
                                                  ),
                                                ),
                                              if (transactionsListItem.type ==
                                                  TransactionType.receive)
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 4.0, 0.0, 0.0),
                                                  child: Text(
                                                    FFLocalizations.of(context)
                                                        .getText(
                                                      'h98ttn1q' /* Received */,
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .titleSmall
                                                        .override(
                                                          fontFamily: 'Lexend',
                                                          color:
                                                              Color(0xFF39D2C0),
                                                          letterSpacing: 0.0,
                                                        ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            12.0, 0.0, 12.0, 0.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              formatNumber(
                                                transactionsListItem.value,
                                                formatType: FormatType.decimal,
                                                decimalType:
                                                    DecimalType.periodDecimal,
                                                currency: '＄',
                                              ),
                                              textAlign: TextAlign.end,
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .titleSmall
                                                      .override(
                                                        fontFamily: 'Lexend',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .tertiary,
                                                        letterSpacing: 0.0,
                                                      ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
