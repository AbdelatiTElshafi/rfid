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
import 'package:mysql_client/mysql_client.dart';

Future<bool> syncSqliteToMysql(
  String host,
  int port,
  String dbName,
  String user,
  String password,
) async {
  MySQLConnection? mysqlConn;
  Database? sqliteDb;

  try {
    // 1. Locate SQLite database file dynamically
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

    if (!await databaseExists(path)) {
      print('Sync Error: Local database file not found at path: $path');
      return false;
    }

    sqliteDb = await openDatabase(path);

    // 2. Fetch rows from SQLite
    final products = await sqliteDb.query('Products');
    final inventoryItems = await sqliteDb.query('inventory_items');
    final inventoryOrders = await sqliteDb.query('inventory_orders');
    final savedTags = await sqliteDb.query('saved_tags');

    // 3. Connect to MySQL server via mysql_client
    mysqlConn = await MySQLConnection.createConnection(
      host: host,
      port: port,
      userName: user,
      password: password,
      databaseName: dbName,
      secure: false, // Set to true if server requires SSL
    );

    await mysqlConn.connect();

    // 4. Batch sync within a transaction
    await mysqlConn.transactional((conn) async {
      if (products.isNotEmpty) {
        final stmt = await conn.prepare(
          'INSERT IGNORE INTO Products (id, name_description, Brand, part_number) VALUES (?, ?, ?, ?)',
        );
        for (var row in products) {
          await stmt.execute([
            row['id'],
            row['name_description'],
            row['Brand'],
            row['part_number'],
          ]);
        }
      }

      if (inventoryItems.isNotEmpty) {
        final stmt = await conn.prepare(
          'INSERT IGNORE INTO inventory_items (id, inventory_order_id, tag_id, scan_time, part_no, serial, name) VALUES (?, ?, ?, ?, ?, ?, ?)',
        );
        for (var row in inventoryItems) {
          await stmt.execute([
            row['id'],
            row['inventory_order_id'],
            row['tag_id'],
            row['scan_time'],
            row['part_no'],
            row['serial'],
            row['name'],
          ]);
        }
      }

      if (inventoryOrders.isNotEmpty) {
        final stmt = await conn.prepare(
          'INSERT IGNORE INTO inventory_orders (id, inventory_no, start_time, end_time, status, total_scanned, notes) VALUES (?, ?, ?, ?, ?, ?, ?)',
        );
        for (var row in inventoryOrders) {
          await stmt.execute([
            row['id'],
            row['inventory_no'],
            row['start_time'],
            row['end_time'],
            row['status'],
            row['total_scanned'],
            row['notes'],
          ]);
        }
      }

      if (savedTags.isNotEmpty) {
        final stmt = await conn.prepare(
          'INSERT IGNORE INTO saved_tags (id, name_description, serial_number, tag_id, part_number) VALUES (?, ?, ?, ?, ?)',
        );
        for (var row in savedTags) {
          await stmt.execute([
            row['id'],
            row['name_description'],
            row['serial_number'],
            row['tag_id'],
            row['part_number'],
          ]);
        }
      }
    });

    return true;
  } catch (e) {
    print('Sync Error: $e');
    return false;
  } finally {
    await sqliteDb?.close();
    if (mysqlConn != null && mysqlConn.connected) {
      await mysqlConn.close();
    }
  }
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the `</>` button on the right!
