import '/components/tag_i_d_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'nnn_widget.dart' show NnnWidget;
import 'package:flutter/material.dart';

class NnnModel extends FlutterFlowModel<NnnWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for Tag_ID component.
  late TagIDModel tagIDModel;

  @override
  void initState(BuildContext context) {
    tagIDModel = createModel(context, () => TagIDModel());
  }

  @override
  void dispose() {
    tagIDModel.dispose();
  }
}
