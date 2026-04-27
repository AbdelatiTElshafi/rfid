import '/components/button2_widget.dart';
import '/components/stat_card_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'r_f_i_d_scanning_widget.dart' show RFIDScanningWidget;
import 'package:flutter/material.dart';

class RFIDScanningModel extends FlutterFlowModel<RFIDScanningWidget> {
  ///  Local state fields for this page.

  List<String> orderRFIDList = [];
  void addToOrderRFIDList(String item) => orderRFIDList.add(item);
  void removeFromOrderRFIDList(String item) => orderRFIDList.remove(item);
  void removeAtIndexFromOrderRFIDList(int index) =>
      orderRFIDList.removeAt(index);
  void insertAtIndexInOrderRFIDList(int index, String item) =>
      orderRFIDList.insert(index, item);
  void updateOrderRFIDListAtIndex(int index, Function(String) updateFn) =>
      orderRFIDList[index] = updateFn(orderRFIDList[index]);

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - checkStringInList] action in RFIDScanning widget.
  bool? exist;
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
