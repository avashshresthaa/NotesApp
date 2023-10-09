import 'package:flutter_application/local_database/sqflite_database.dart';
import 'package:get/get.dart';

import 'local_database/database_tables_controller/calander/calander_controller.dart';

Future<void> init() async {
  Get.lazyPut(
      () => NotesTableController(policeDatabase: DatabaseHelper.instance));
}
