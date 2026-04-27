import 'package:flutter/material.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {}

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  String _rfidStatus = 'Disconnected';
  String get rfidStatus => _rfidStatus;
  set rfidStatus(String value) {
    _rfidStatus = value;
  }

  String _scannedTagId = '';
  String get scannedTagId => _scannedTagId;
  set scannedTagId(String value) {
    _scannedTagId = value;
  }

  bool _rfidConnected = false;
  bool get rfidConnected => _rfidConnected;
  set rfidConnected(bool value) {
    _rfidConnected = value;
  }

  List<String> _scannedTagList = [];
  List<String> get scannedTagList => _scannedTagList;
  set scannedTagList(List<String> value) {
    _scannedTagList = value;
  }

  void addToScannedTagList(String value) {
    scannedTagList.add(value);
  }

  void removeFromScannedTagList(String value) {
    scannedTagList.remove(value);
  }

  void removeAtIndexFromScannedTagList(int index) {
    scannedTagList.removeAt(index);
  }

  void updateScannedTagListAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    scannedTagList[index] = updateFn(_scannedTagList[index]);
  }

  void insertAtIndexInScannedTagList(int index, String value) {
    scannedTagList.insert(index, value);
  }
}
