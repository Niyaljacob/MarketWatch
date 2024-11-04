

import 'package:flutter/material.dart';
import 'package:market_watch/data/helper/sql_helper.dart';
import 'package:market_watch/model/data_model.dart';

Future<void> addData(LocalStock value) async {
  try {
    final db = await DatabaseHelper.instance.database;
    final int id = await db.insert('bullbear', value.toMap());
    value.id = id;
    debugPrint('Added company: ${value.companyName} with ID: $id');
  } catch (e) {
    debugPrint("Error adding data: $e");
  }
}


Future<List<LocalStock>> getAllLocalData() async {
  try {
    final db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> data = await db.query('bullbear');

    return data.map((json) => LocalStock.fromMap(json)).toList();
  } catch (e) {
    debugPrint("Error fetching data: $e");
    return [];
  }
}

Future<void> deleteData(int id) async {
  try {
    final db = await DatabaseHelper.instance.database;
    await db.delete('bullbear', where: 'id = ?', whereArgs: [id]);
    debugPrint('Deleted item with ID: $id');
  } catch (e) {
    debugPrint("Error deleting data: $e");
  }
}
