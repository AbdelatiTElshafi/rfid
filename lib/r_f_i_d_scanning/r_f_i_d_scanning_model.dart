import '/components/button2_widget.dart';
import '/components/stat_card_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'r_f_i_d_scanning_widget.dart' show RFIDScanningWidget;
import 'package:flutter/material.dart';

class RFIDScanningModel extends FlutterFlowModel<RFIDScanningWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for StatCard.
  late StatCardModel statCardModel1;
  // Model for StatCard.
  late StatCardModel statCardModel2;
  // Model for Button.
  late Button2Model buttonModel1;
  // Model for Button.
  late Button2Model buttonModel2;

  @override
  void initState(BuildContext context) {
    statCardModel1 = createModel(context, () => StatCardModel());
    statCardModel2 = createModel(context, () => StatCardModel());
    buttonModel1 = createModel(context, () => Button2Model());
    buttonModel2 = createModel(context, () => Button2Model());
  }

  @override
  void dispose() {
    statCardModel1.dispose();
    statCardModel2.dispose();
    buttonModel1.dispose();
    buttonModel2.dispose();
  }
}
