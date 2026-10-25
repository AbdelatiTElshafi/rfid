// Automatic FlutterFlow imports
import '/flutter_flow/ff_builtin_enums.dart';
import '/backend/sqlite/sqlite_manager.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import 'package:flutter/material.dart' hide RepeatMode;
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:io';
import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import 'dart:io';
import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

Future<void> exportnonToCSV(
  List<String> tagIds,
) async {
  final rows = <List<dynamic>>[];

  // Header row
  rows.add(['tag_id']);

  // Set to store unique normalized tag_ids
  final seenTagIds = <String>{};

  for (int i = 0; i < tagIds.length; i++) {
    final rawTagId = tagIds[i].trim();
    final lookupKey = rawTagId.toLowerCase();

    // Skip empty or white-space tag IDs
    if (lookupKey.isEmpty) continue;

    // Only add row if lookupKey hasn't been added yet
    if (seenTagIds.add(lookupKey)) {
      rows.add([rawTagId]);
    }
  }

  final csvString = const ListToCsvConverter().convert(rows);

  final dir = await getApplicationDocumentsDirectory();
  final now = DateTime.now().millisecondsSinceEpoch;
  final path = '${dir.path}/export_tag_ids_$now.csv';

  final file = File(path);
  await file.writeAsString(csvString);

  await Share.shareXFiles(
    [XFile(path)],
    text: 'Exported Tag IDs CSV',
    subject: 'Tag IDs Export',
  );
}
