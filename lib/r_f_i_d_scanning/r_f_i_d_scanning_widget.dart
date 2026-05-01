import '/backend/sqlite/sqlite_manager.dart';
import '/components/button2_widget.dart';
import '/components/stat_card_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'r_f_i_d_scanning_model.dart';
export 'r_f_i_d_scanning_model.dart';

class RFIDScanningWidget extends StatefulWidget {
  const RFIDScanningWidget({
    super.key,
    required this.inventoryOrder,
  });

  final String? inventoryOrder;

  static String routeName = 'RFIDScanning';
  static String routePath = '/rFIDScanning';

  @override
  State<RFIDScanningWidget> createState() => _RFIDScanningWidgetState();
}

class _RFIDScanningWidgetState extends State<RFIDScanningWidget> {
  late RFIDScanningModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => RFIDScanningModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      FFAppState().scannedTagList = [];
      safeSetState(() {});
      _model.newScannedRFIDTags = [];
      _model.savedTagsCount = 0;
      _model.allOrderRFIDList = [];
      _model.startListen = true;
      safeSetState(() {});
      _model.getInventoryItems = await SQLiteManager.instance.getInventoryItems(
        inventoryorderid: widget.inventoryOrder,
      );
      _model.allOrderRFIDList = _model.getInventoryItems!
          .map((e) => e.tagId)
          .withoutNulls
          .toList()
          .toList()
          .cast<String>();
      safeSetState(() {});
      _model.savedTagsCount = valueOrDefault<int>(
        _model.allOrderRFIDList.length,
        0,
      );
      safeSetState(() {});
      safeSetState(() {});
      while (_model.startListen) {
        await Future.delayed(
          Duration(
            milliseconds: 100,
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'bbhb',
              style: TextStyle(
                color: FlutterFlowTheme.of(context).primaryText,
              ),
            ),
            duration: Duration(milliseconds: 50),
            backgroundColor: FlutterFlowTheme.of(context).secondary,
          ),
        );
        for (int loop1Index = 0;
            loop1Index < FFAppState().scannedTagList.length;
            loop1Index++) {
          final currentLoop1Item = FFAppState().scannedTagList[loop1Index];
          _model.exist = await actions.checkStringInList(
            FFAppState().scannedTagList.elementAtOrNull(loop1Index)!,
            _model.allOrderRFIDList.toList(),
          );
          if (!_model.exist!) {
            _model.addToAllOrderRFIDList(
                FFAppState().scannedTagList.elementAtOrNull(loop1Index)!);
            safeSetState(() {});
            _model.addToNewScannedRFIDTags(
                FFAppState().scannedTagList.elementAtOrNull(loop1Index)!);
            safeSetState(() {});
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  '${FFAppState().scannedTagList.elementAtOrNull(loop1Index)} Scanned',
                  style: TextStyle(
                    color: FlutterFlowTheme.of(context).primaryText,
                  ),
                ),
                duration: Duration(milliseconds: 1000),
                backgroundColor: FlutterFlowTheme.of(context).secondary,
              ),
            );
          }
          FFAppState().removeAtIndexFromScannedTagList(loop1Index);
          safeSetState(() {});
        }
      }
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

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SingleChildScrollView(
          primary: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.all(24.0),
                child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'RFID Scanning',
                                style: FlutterFlowTheme.of(context)
                                    .headlineMedium
                                    .override(
                                      font: GoogleFonts.plusJakartaSans(
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .headlineMedium
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .headlineMedium
                                          .fontStyle,
                                      lineHeight: 1.25,
                                    ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 8.0,
                                    height: 8.0,
                                    decoration: BoxDecoration(
                                      color:
                                          FlutterFlowTheme.of(context).success,
                                      borderRadius:
                                          BorderRadius.circular(9999.0),
                                      shape: BoxShape.rectangle,
                                    ),
                                  ),
                                  Text(
                                    'Zebra RFD8500 Connected',
                                    style: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                          font: GoogleFonts.plusJakartaSans(
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium
                                                    .fontStyle,
                                          ),
                                          color: FlutterFlowTheme.of(context)
                                              .success,
                                          letterSpacing: 0.0,
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .labelMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .labelMedium
                                                  .fontStyle,
                                          lineHeight: 1.3,
                                        ),
                                  ),
                                ].divide(SizedBox(width: 4.0)),
                              ),
                            ].divide(SizedBox(height: 4.0)),
                          ),
                          Container(
                            width: 48.0,
                            height: 48.0,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              borderRadius: BorderRadius.circular(16.0),
                              shape: BoxShape.rectangle,
                              border: Border.all(
                                color: FlutterFlowTheme.of(context).alternate,
                                width: 1.0,
                              ),
                            ),
                            alignment: AlignmentDirectional(0.0, 0.0),
                            child: Icon(
                              Icons.settings_input_antenna_rounded,
                              color: FlutterFlowTheme.of(context).tertiary,
                              size: 24.0,
                            ),
                          ),
                        ],
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(32.0),
                        child: Container(
                          height: 220.0,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                Color(0xFF121618)
                              ],
                              stops: [0.0, 1.0],
                              begin: AlignmentDirectional(1.0, 1.0),
                              end: AlignmentDirectional(-1.0, -1.0),
                            ),
                            borderRadius: BorderRadius.circular(32.0),
                            shape: BoxShape.rectangle,
                            border: Border.all(
                              color: FlutterFlowTheme.of(context).onPrimary6,
                              width: 1.0,
                            ),
                          ),
                          child: Stack(
                            alignment: AlignmentDirectional(-1.0, -1.0),
                            children: [
                              Container(
                                alignment: AlignmentDirectional(0.0, 0.0),
                              ),
                              Align(
                                alignment: AlignmentDirectional(0.0, 0.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'New TAGS',
                                      style: FlutterFlowTheme.of(context)
                                          .labelLarge
                                          .override(
                                            font: GoogleFonts.plusJakartaSans(
                                              fontWeight: FontWeight.w600,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .labelLarge
                                                      .fontStyle,
                                            ),
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelLarge
                                                    .fontStyle,
                                            lineHeight: 1.3,
                                          ),
                                    ),
                                    Text(
                                      valueOrDefault<String>(
                                        _model.newScannedRFIDTags.length
                                            .toString(),
                                        '0',
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .headlineLarge
                                          .override(
                                            font: GoogleFonts.plusJakartaSans(
                                              fontWeight: FontWeight.w900,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .headlineLarge
                                                      .fontStyle,
                                            ),
                                            color: FlutterFlowTheme.of(context)
                                                .tertiary,
                                            fontSize: 56.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w900,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .headlineLarge
                                                    .fontStyle,
                                            lineHeight: 1.2,
                                          ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .primary25,
                                        borderRadius:
                                            BorderRadius.circular(9999.0),
                                        shape: BoxShape.rectangle,
                                        border: Border.all(
                                          color: FlutterFlowTheme.of(context)
                                              .primary25,
                                          width: 1.0,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            16.0, 6.0, 16.0, 6.0),
                                        child: Container(
                                          child: Text(
                                            'Session: ${widget.inventoryOrder}',
                                            style: FlutterFlowTheme.of(context)
                                                .labelSmall
                                                .override(
                                                  font: GoogleFonts
                                                      .plusJakartaSans(
                                                    fontWeight: FontWeight.bold,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelSmall
                                                            .fontStyle,
                                                  ),
                                                  color: Colors.white,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.bold,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelSmall
                                                          .fontStyle,
                                                  lineHeight: 1.2,
                                                ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ].divide(SizedBox(height: 4.0)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 1,
                            child: wrapWithModel(
                              model: _model.statCardModel1,
                              updateCallback: () => safeSetState(() {}),
                              child: StatCardWidget(
                                label: 'Saved Tags',
                                value: valueOrDefault<String>(
                                  _model.savedTagsCount?.toString(),
                                  '0',
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: wrapWithModel(
                              model: _model.statCardModel2,
                              updateCallback: () => safeSetState(() {}),
                              child: StatCardWidget(
                                label: 'Total Tags',
                                value: valueOrDefault<String>(
                                  _model.allOrderRFIDList.length.toString(),
                                  '0',
                                ),
                              ),
                            ),
                          ),
                        ].divide(SizedBox(width: 16.0)),
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 40.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                borderRadius: BorderRadius.circular(20.0),
                                shape: BoxShape.rectangle,
                                border: Border.all(
                                  color: FlutterFlowTheme.of(context).alternate,
                                  width: 1.0,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    24.0, 16.0, 24.0, 16.0),
                                child: Container(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.info_outline_rounded,
                                        color: FlutterFlowTheme.of(context)
                                            .onSurface,
                                        size: 20.0,
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          'Trigger pulled: High-power mode active. Keep device moving for best results..',
                                          style: FlutterFlowTheme.of(context)
                                              .bodySmall
                                              .override(
                                                font: GoogleFonts.inter(
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodySmall
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodySmall
                                                          .fontStyle,
                                                ),
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                letterSpacing: 0.0,
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .bodySmall
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodySmall
                                                        .fontStyle,
                                                lineHeight: 1.4,
                                              ),
                                        ),
                                      ),
                                    ].divide(SizedBox(width: 16.0)),
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                _model.startListen = false;
                                safeSetState(() {});
                                for (int loop1Index = 0;
                                    loop1Index <
                                        _model.newScannedRFIDTags.length;
                                    loop1Index++) {
                                  final currentLoop1Item =
                                      _model.newScannedRFIDTags[loop1Index];
                                  if (_model.newScannedRFIDTags.elementAtOrNull(
                                                  loop1Index) !=
                                              null &&
                                          _model.newScannedRFIDTags
                                                  .elementAtOrNull(
                                                      loop1Index) !=
                                              ''
                                      ? true
                                      : false) {
                                    await SQLiteManager.instance
                                        .saveTagsToInventoryOrders(
                                      inventoryorderid: widget.inventoryOrder,
                                      tagid: _model.newScannedRFIDTags
                                          .elementAtOrNull(loop1Index),
                                      scantime: getCurrentTimestamp.toString(),
                                    );
                                  }
                                }
                                context.safePop();
                              },
                              child: wrapWithModel(
                                model: _model.buttonModel1,
                                updateCallback: () => safeSetState(() {}),
                                child: Button2Widget(
                                  content: 'Complete Session',
                                  icon: Icon(
                                    Icons.check_circle_rounded,
                                    color:
                                        FlutterFlowTheme.of(context).onPrimary,
                                    size: 16.0,
                                  ),
                                  icon_present: true,
                                  icon_end_present: false,
                                  variant: 'primary',
                                  size: 'large',
                                  full_width: true,
                                  loading: false,
                                  disabled: false,
                                ),
                              ),
                            ),
                            wrapWithModel(
                              model: _model.buttonModel2,
                              updateCallback: () => safeSetState(() {}),
                              child: Button2Widget(
                                content: 'Pause Scanning',
                                icon: Icon(
                                  Icons.pause_rounded,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  size: 16.0,
                                ),
                                icon_present: true,
                                icon_end_present: false,
                                variant: 'outline',
                                size: 'large',
                                full_width: true,
                                loading: false,
                                disabled: false,
                              ),
                            ),
                          ].divide(SizedBox(height: 16.0)),
                        ),
                      ),
                    ].divide(SizedBox(height: 24.0)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
