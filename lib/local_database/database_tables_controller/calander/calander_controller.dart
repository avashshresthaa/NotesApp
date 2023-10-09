import 'package:get/get.dart';

import '../../database_models/calander_model/calander_model.dart';
import '../../sqflite_database.dart';

class NotesTableController extends GetxController {
  final DatabaseHelper policeDatabase;
  NotesTableController({required this.policeDatabase});
  bool loading = false;

  List<NotessModelDatabase> notesModel = [];
  String notes = "";

// Future updateData(location,address,title,remarks,addressId)async{
//      final data = AddressModelDatabase(address: location.address.toString(),title: title,remarks: remarks);
//      address.updateAddress(data, addressId);
//   }
//create table
//create database
  Future<void> create(NotessModelDatabase notesModelDatabase, value) async {
    final db = await policeDatabase.database;
    final existingRecord = await db.query(
      tableNotes,
      where: '${NotesFields.value} = ?',
      whereArgs: [value],
    );

    // if (existingRecord.isEmpty) {
    try {
      final id = await db.insert(tableNotes, notesModelDatabase.toJson());
      print("Record inserted. ID: $id");
    } catch (e) {
      print("Insertion failed: $e");
    }
    // } else {
    //   try {
    //     final updatedRows = await db.update(
    //       tableNotes,
    //       {NotesFields.notes: notesModelDatabase.notes},
    //       where: '${NotesFields.value} = ?',
    //       whereArgs: [value],
    //     );
    //     update();
    //     if (updatedRows > 0) {
    //       print("Record updated. ID: ${notesModelDatabase.value}");
    //     } else {
    //       print("No records updated. ID: ${notesModelDatabase.value}");
    //     }
    //   } catch (e) {
    //     print("Update failed: $e");
    //   }
    // }
  }

// get Database
  Future<List<NotessModelDatabase>> getNotes() async {
    final db = await policeDatabase.database;
    final result = await db.query(
      tableNotes,
    );
    notesModel = [];
    notesModel.addAll(
        result.map((json) => NotessModelDatabase.fromJson(json)).toList());
    update();
    return result.map((json) => NotessModelDatabase.fromJson(json)).toList();
  }

  Future<void> getSingleNotes(value) async {
    final db = await policeDatabase.database;
    final result = await db.query(tableNotes,
        where: '${NotesFields.value} = ?', whereArgs: [value]);

    if (result.isNotEmpty) {
      final row = result.first;
      notes = row[NotesFields.notes].toString();
      update();
    } else {
      notes = "";
      update();
    }
  }

  Future<bool> delete(id) async {
    final db = await policeDatabase.database;
    try {
      await db
          .delete(tableNotes, where: '${NotesFields.id} = ?', whereArgs: [id]);
      update();
      return true;
    } catch (e) {
      return false;
    }
  }
}
