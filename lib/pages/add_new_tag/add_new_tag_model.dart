import '/backend/sqlite/sqlite_manager.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'add_new_tag_widget.dart' show AddNewTagWidget;
import 'package:flutter/material.dart';

class AddNewTagModel extends FlutterFlowModel<AddNewTagWidget> {
  ///  Local state fields for this page.

  String scannedTagId = ' test';

  ///  State fields for stateful widgets in this page.

  // State field(s) for PartNODropDown widget.
  String? partNODropDownValue;
  FormFieldController<String>? partNODropDownValueController;
  // Stores action output result for [Backend Call - SQLite (GetPartNoDesc)] action in PartNODropDown widget.
  List<GetPartNoDescRow>? getPartNoDesc;
  // State field(s) for DescTextField widget.
  FocusNode? descTextFieldFocusNode;
  TextEditingController? descTextFieldTextController;
  String? Function(BuildContext, String?)? descTextFieldTextControllerValidator;
  // State field(s) for SerialTextField widget.
  FocusNode? serialTextFieldFocusNode;
  TextEditingController? serialTextFieldTextController;
  String? Function(BuildContext, String?)?
      serialTextFieldTextControllerValidator;
  // Stores action output result for [Backend Call - SQLite (CheckTagExists)] action in Button widget.
  List<CheckTagExistsRow>? checkTagExistsResult;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    descTextFieldFocusNode?.dispose();
    descTextFieldTextController?.dispose();

    serialTextFieldFocusNode?.dispose();
    serialTextFieldTextController?.dispose();
  }
}
