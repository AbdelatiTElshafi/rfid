import '/backend/sqlite/sqlite_manager.dart';
import '/components/tag_i_d_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'saved_tags_model.dart';
export 'saved_tags_model.dart';

/// Design a clean “Saved Tags” page for an RFID app with black and orange
/// branding, white/light background, rounded cards, and orange gradient
/// action buttons.
///
/// Structure:
/// - App bar with Back button, title “Saved Tags”, and Search icon
/// - Search field below app bar
/// - Filter chips: All, Saved, Scanned, Matched, Unmatched
///
/// Important layout rule:
/// - The Saved Tags section must take the main body of the page
/// - The Saved Tags items must be displayed in one vertical scrollable list
/// - Only this list should scroll
/// - Keep the search bar and filters fixed at the top
/// - Keep bottom action buttons separate from the list
///
/// Each saved tag card must show:
/// - Name or Description
/// - Reference / Serial Number
/// - Tag ID
/// - Status badge
/// - View, Edit, Delete icons
///
/// Bottom section:
/// - Scan RFID Tags button
/// - Export to CSV button
///
/// Use local SQLite storage with full CRUD. Highlight matched tags in green
/// and unmatched in orange/red. Add a clean empty state when no tags exist.
class SavedTagsWidget extends StatefulWidget {
  const SavedTagsWidget({super.key});

  static String routeName = 'SavedTags';
  static String routePath = '/savedTags';

  @override
  State<SavedTagsWidget> createState() => _SavedTagsWidgetState();
}

class _SavedTagsWidgetState extends State<SavedTagsWidget> {
  late SavedTagsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SavedTagsModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.allTagsData = await SQLiteManager.instance.getAllTags();
      _model.tagsID = _model.allTagsData!
          .map((e) => e.tagId)
          .withoutNulls
          .toList()
          .toList()
          .cast<String>();
      _model.serials = _model.allTagsData!
          .map((e) => e.serialNumber)
          .withoutNulls
          .toList()
          .toList()
          .cast<String>();
      _model.name = _model.allTagsData!
          .map((e) => e.nameDescription)
          .withoutNulls
          .toList()
          .toList()
          .cast<String>();
      _model.partNOs = _model.allTagsData!
          .map((e) => e.partNumber)
          .withoutNulls
          .toList()
          .toList()
          .cast<String>();
      safeSetState(() {});
    });
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Color(0xFFF5F5F5),
        appBar: AppBar(
          backgroundColor: Color(0xFF1A1A1A),
          automaticallyImplyLeading: false,
          leading: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
            child: FlutterFlowIconButton(
              borderRadius: 22.0,
              buttonSize: 44.0,
              icon: Icon(
                Icons.arrow_back_rounded,
                color: Colors.white,
                size: 24.0,
              ),
              onPressed: () async {
                context.pushNamed(HomeWidget.routeName);
              },
            ),
          ),
          title: Text(
            'Saved Tags',
            style: FlutterFlowTheme.of(context).titleLarge.override(
                  font: GoogleFonts.interTight(
                    fontWeight: FontWeight.bold,
                    fontStyle:
                        FlutterFlowTheme.of(context).titleLarge.fontStyle,
                  ),
                  color: Colors.white,
                  fontSize: 20.0,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.bold,
                  fontStyle: FlutterFlowTheme.of(context).titleLarge.fontStyle,
                ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0x00BEBEBE),
                      ),
                      child: Builder(
                        builder: (context) {
                          final itemAtIndex = _model.tagsID.toList();

                          return ListView.separated(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: itemAtIndex.length,
                            separatorBuilder: (_, __) => SizedBox(height: 10.0),
                            itemBuilder: (context, itemAtIndexIndex) {
                              final itemAtIndexItem =
                                  itemAtIndex[itemAtIndexIndex];
                              return TagIDWidget(
                                key: Key(
                                    'Key2vi_${itemAtIndexIndex}_of_${itemAtIndex.length}'),
                                name: _model.name
                                    .elementAtOrNull(itemAtIndexIndex),
                                serial: _model.serials
                                    .elementAtOrNull(itemAtIndexIndex),
                                tagId: _model.tagsID
                                    .elementAtOrNull(itemAtIndexIndex),
                                partNo: _model.partNOs
                                    .elementAtOrNull(itemAtIndexIndex),
                                rebuild: () async {
                                  safeSetState(() {});
                                },
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Align(
                alignment: AlignmentDirectional(0.0, 1.0),
                child: Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          height: 50.0,
                          decoration: BoxDecoration(),
                          child: FFButtonWidget(
                            onPressed: () async {
                              var confirmDialogResponse =
                                  await showDialog<bool>(
                                        context: context,
                                        builder: (alertDialogContext) {
                                          return AlertDialog(
                                            title: Text(
                                                _model.tagsID.firstOrNull!),
                                            actions: [
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    alertDialogContext, false),
                                                child: Text('Cancel'),
                                              ),
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    alertDialogContext, true),
                                                child: Text('Confirm'),
                                              ),
                                            ],
                                          );
                                        },
                                      ) ??
                                      false;
                              await actions.exportToCSV(
                                _model.tagsID.toList(),
                                _model.name.toList(),
                                _model.partNOs.toList(),
                                _model.serials.toList(),
                              );
                            },
                            text: 'Export Data',
                            icon: Icon(
                              Icons.upgrade_sharp,
                              size: 25.0,
                            ),
                            options: FFButtonOptions(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 0.0, 16.0, 0.0),
                              iconAlignment: IconAlignment.end,
                              iconPadding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              color: FlutterFlowTheme.of(context).tertiary,
                              textStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                    font: GoogleFonts.interTight(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .fontStyle,
                                    ),
                                    color: Colors.white,
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontStyle,
                                  ),
                              elevation: 0.0,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                      ),
                    ],
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
