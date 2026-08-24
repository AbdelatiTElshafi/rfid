// Automatic FlutterFlow imports
import '/backend/sqlite/sqlite_manager.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:async';
import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;
import 'package:mysql1/mysql1.dart';

Future<bool> syncSqliteToMysql(
  String host,
  int port,
  String dbName,
  String user,
  String password,
) async {
  MySqlConnection? mysqlConn;
  Database? sqliteDb;

  try {
    // 1. Locate existing SQLite local database dynamically
    final databasesPath = await getDatabasesPath();
    String path = p.join(databasesPath, 'rfiddb.db');

    final dbDir = Directory(databasesPath);
    if (await dbDir.exists()) {
      final files = dbDir.listSync();
      for (final file in files) {
        if (p.basename(file.path).toLowerCase() == 'rfiddb.db') {
          path = file.path;
          break;
        }
      }
    }

    bool dbExists = await databaseExists(path);
    if (!dbExists) {
      print('Sync Error: Local database file not found at path: $path');
      return false;
    }

    sqliteDb = await openDatabase(path);

    // 2. Fetch rows from all SQLite tables
    final List<Map<String, dynamic>> products =
        await sqliteDb.query('Products');
    final List<Map<String, dynamic>> inventoryItems =
        await sqliteDb.query('inventory_items');
    final List<Map<String, dynamic>> inventoryOrders =
        await sqliteDb.query('inventory_orders');
    final List<Map<String, dynamic>> savedTags =
        await sqliteDb.query('saved_tags');

    // 3. Connect to MySQL server with extended timeout
    final settings = ConnectionSettings(
      host: host,
      port: port,
      user: user,
      password: password,
      db: dbName,
      timeout: const Duration(seconds: 30),
    );
    mysqlConn = await MySqlConnection.connect(settings);

    // 4. Batch Sync Products Table
    if (products.isNotEmpty) {
      final params = products
          .map((row) => [
                row['id'],
                row['name_description'],
                row['Brand'],
                row['part_number'],
              ])
          .toList();

      await mysqlConn.queryMulti(
        'INSERT IGNORE INTO Products (id, name_description, Brand, part_number) VALUES (?, ?, ?, ?)',
        params,
      );
    }

    // 5. Batch Sync inventory_items Table
    if (inventoryItems.isNotEmpty) {
      final params = inventoryItems
          .map((row) => [
                row['id'],
                row['inventory_order_id'],
                row['tag_id'],
                row['scan_time'],
                row['part_no'],
                row['serial'],
                row['name'],
              ])
          .toList();

      await mysqlConn.queryMulti(
        'INSERT IGNORE INTO inventory_items (id, inventory_order_id, tag_id, scan_time, part_no, serial, name) VALUES (?, ?, ?, ?, ?, ?, ?)',
        params,
      );
    }

    // 6. Batch Sync inventory_orders Table
    if (inventoryOrders.isNotEmpty) {
      final params = inventoryOrders
          .map((row) => [
                row['id'],
                row['inventory_no'],
                row['start_time'],
                row['end_time'],
                row['status'],
                row['total_scanned'],
                row['notes'],
              ])
          .toList();

      await mysqlConn.queryMulti(
        'INSERT IGNORE INTO inventory_orders (id, inventory_no, start_time, end_time, status, total_scanned, notes) VALUES (?, ?, ?, ?, ?, ?, ?)',
        params,
      );
    }

    // 7. Batch Sync saved_tags Table
    if (savedTags.isNotEmpty) {
      final params = savedTags
          .map((row) => [
                row['id'],
                row['name_description'],
                row['serial_number'],
                row['tag_id'],
                row['part_number'],
              ])
          .toList();

      await mysqlConn.queryMulti(
        'INSERT IGNORE INTO saved_tags (id, name_description, serial_number, tag_id, part_number) VALUES (?, ?, ?, ?, ?)',
        params,
      );
    }

    return true;
  } catch (e) {
    print('Sync Error: $e');
    return false;
  } finally {
    // 8. Safely close database connections
    await sqliteDb?.close();
    try {
      await mysqlConn?.close();
    } catch (_) {
      // Ignore socket tear-down exceptions if already disconnected
    }
  }
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the `</>` button on the right!
