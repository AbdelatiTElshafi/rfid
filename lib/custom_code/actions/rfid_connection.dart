// Automatic FlutterFlow imports
import '/backend/supabase/supabase.dart';
import '/backend/sqlite/sqlite_manager.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '/custom_code/rfid_service.dart';

Future<bool> rfidConnection() async {
  try {
    final connected = await RFIDService.connectRFID();
    return connected;
  } catch (e) {
    return false;
  }
}
