import 'package:sqflite/sqflite.dart';

/// BEGIN INSERTTAG
Future performInsertTag(
  Database database, {
  String? nameDesc,
  String? serialNumber,
  String? tagId,
  String? partNo,
}) {
  final query = '''
INSERT INTO saved_tags (name_description,serial_number,tag_id,part_number)
 VALUES ('${nameDesc}','${serialNumber}','${tagId}','${partNo}');
''';
  return database.rawQuery(query);
}

/// END INSERTTAG

/// BEGIN UPDATETAG
Future performUpdateTag(
  Database database, {
  String? nameDesc,
  String? serialNumber,
  String? tagId,
}) {
  final query = '''
UPDATE saved_tags
SET
name_description = '${nameDesc}',
serial_number = '${serialNumber}'
WHERE tag_id = '${tagId}';
''';
  return database.rawQuery(query);
}

/// END UPDATETAG

/// BEGIN DELETETAG
Future performDeleteTag(
  Database database, {
  String? tagId,
}) {
  final query = '''
DELETE FROM saved_tags
WHERE tag_id = '${tagId}';

''';
  return database.rawQuery(query);
}

/// END DELETETAG

/// BEGIN CREATEINVENTORYORDER
Future performCreateInventoryOrder(
  Database database, {
  String? inventoryno,
  DateTime? starttime,
}) {
  final query = '''
INSERT INTO inventory_orders (
  inventory_no,
  start_time,
  status,
  total_scanned,
  notes
)
VALUES (
 '${inventoryno}',
 '${starttime}',
  'OPEN',
  0,
  'notes'
);
''';
  return database.rawQuery(query);
}

/// END CREATEINVENTORYORDER

/// BEGIN SAVETAGSTOINVENTORYORDERS
Future performSaveTagsToInventoryOrders(
  Database database, {
  String? inventoryorderid,
  List<String>? tagidList,
  String? scantime,
}) {
  final tagid = tagidList;
  final query = '''
INSERT INTO inventory_items (inventory_order_id,tag_id,tag_id,scan_time)
 VALUES ('${inventoryorderid}','${tagid}','${scantime}');
''';
  return database.rawQuery(query);
}

/// END SAVETAGSTOINVENTORYORDERS
