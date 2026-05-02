import '/backend/sqlite/sqlite_manager.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'add_new_tag_widget.dart' show AddNewTagWidget;
import 'package:flutter/material.dart';

class AddNewTagModel extends FlutterFlowModel<AddNewTagWidget> {
  ///  Local state fields for this page.

  String scannedTagId = ' test';

  List<String> partsno = [];
  void addToPartsno(String item) => partsno.add(item);
  void removeFromPartsno(String item) => partsno.remove(item);
  void removeAtIndexFromPartsno(int index) => partsno.removeAt(index);
  void insertAtIndexInPartsno(int index, String item) =>
      partsno.insert(index, item);
  void updatePartsnoAtIndex(int index, Function(String) updateFn) =>
      partsno[index] = updateFn(partsno[index]);

  ///  State fields for stateful widgets in this page.

  // State field(s) for PartNOText widget.
  final partNOTextKey = GlobalKey();
  FocusNode? partNOTextFocusNode;
  TextEditingController? partNOTextTextController;
  String? partNOTextSelectedOption;
  String? Function(BuildContext, String?)? partNOTextTextControllerValidator;
  // Stores action output result for [Backend Call - SQLite (GetPartNoDesc)] action in PartNOText widget.
  List<GetPartNoDescRow>? getPartNoDesc;
  // Stores action output result for [Backend Call - SQLite (GetAllPartNO)] action in PartNOText widget.
  List<GetAllPartNORow>? partNumbersData;
  // Stores action output result for [Backend Call - SQLite (GetPartNoDesc)] action in PartNOText widget.
  List<GetPartNoDescRow>? getPartNoDescOnChange;
  // State field(s) for DescTextField widget.
  FocusNode? descTextFieldFocusNode;
  TextEditingController? descTextFieldTextController;
  String? Function(BuildContext, String?)? descTextFieldTextControllerValidator;
  // State field(s) for SerialTextField widget.
  FocusNode? serialTextFieldFocusNode;
  TextEditingController? serialTextFieldTextController;
  String? Function(BuildContext, String?)?
      serialTextFieldTextControllerValidator;
  // Stores action output result for [Backend Call - SQLite (GetTagData)] action in Button widget.
  List<GetTagDataRow>? checkTagExistsResult;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    partNOTextFocusNode?.dispose();

    descTextFieldFocusNode?.dispose();
    descTextFieldTextController?.dispose();

    serialTextFieldFocusNode?.dispose();
    serialTextFieldTextController?.dispose();
  }
}
