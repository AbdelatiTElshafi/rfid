// Automatic FlutterFlow imports
import '/backend/sqlite/sqlite_manager.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '/custom_code/actions/index.dart';
import '/flutter_flow/custom_functions.dart';

import 'dart:io';
import 'package:excel/excel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

Future<void> exportInventoryExcelWithSummary(
  List<String> tagIds,
  List<String> names,
  List<String> partNumbers,
  List<String> serialNumbers,
) async {
  if (tagIds.length != names.length ||
      tagIds.length != partNumbers.length ||
      tagIds.length != serialNumbers.length) {
    throw Exception('All input lists must have the same length.');
  }

  final excel = Excel.createExcel();

  // Sheet 1: Full Data
  final dataSheet = excel['Data'];

  dataSheet.appendRow([
    TextCellValue('tag_id'),
    TextCellValue('name_description'),
    TextCellValue('part_number'),
    TextCellValue('serial_number'),
  ]);

  for (int i = 0; i < tagIds.length; i++) {
    dataSheet.appendRow([
      TextCellValue(tagIds[i]),
      TextCellValue(names[i]),
      TextCellValue(partNumbers[i]),
      TextCellValue(serialNumbers[i]),
    ]);
  }

  // Sheet 2: Summary
  final Map<String, Map<String, dynamic>> summary = {};

  for (int i = 0; i < partNumbers.length; i++) {
    final partNumber =
        partNumbers[i].trim().isEmpty ? 'Unknown' : partNumbers[i].trim();

    final name = names[i].trim().isEmpty ? 'Unknown' : names[i].trim();

    if (!summary.containsKey(partNumber)) {
      summary[partNumber] = {
        'name': name,
        'count': 0,
      };
    }

    summary[partNumber]!['count'] = summary[partNumber]!['count'] + 1;
  }

  final summarySheet = excel['Summary'];

  summarySheet.appendRow([
    TextCellValue('part_number'),
    TextCellValue('name_description'),
    TextCellValue('tag_count'),
  ]);

  summary.forEach((partNumber, data) {
    summarySheet.appendRow([
      TextCellValue(partNumber),
      TextCellValue(data['name'].toString()),
      IntCellValue(data['count']),
    ]);
  });

  if (excel.sheets.containsKey('Sheet1')) {
    excel.delete('Sheet1');
  }

  final dir = await getApplicationDocumentsDirectory();
  final now = DateTime.now().millisecondsSinceEpoch;
  final path = '${dir.path}/inventory_export_$now.xlsx';

  final fileBytes = excel.save();

  if (fileBytes == null) {
    throw Exception('Failed to generate Excel file.');
  }

  final file = File(path);
  await file.writeAsBytes(fileBytes);

  await Share.shareXFiles(
    [XFile(path)],
    text: 'Inventory Excel Export',
    subject: 'Inventory Export',
  );
}
