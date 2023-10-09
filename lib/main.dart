import 'package:flutter/material.dart';
import 'package:flutter_application/local_database/database_tables_controller/calander/calander_controller.dart';
import 'package:get/get.dart';
import 'package:flutter_application/edependencies.dart' as dep;
import 'package:get/get_connect/http/src/utils/utils.dart';

import 'local_database/database_models/calander_model/calander_model.dart';

Future<void> main() async {
  await dep.init();

  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SQFlite Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  var notesController = TextEditingController();
  int currentIndex = 0;

  // homepage layout
  @override
  Widget build(BuildContext context) {
    Get.find<NotesTableController>().getNotes();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes App"),
      ),
      body: GetBuilder<NotesTableController>(builder: (notes) {
        var allnotes = notes.notesModel.toList();
        return ListView(
          padding: EdgeInsets.all(24),
          children: [
            TextField(
              keyboardType: TextInputType.text,
              onSubmitted: (value) {},
              controller: notesController,
              maxLines: 4,
              decoration: const InputDecoration(
                  hintText: "Notes..", border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 16,
            ),
            OutlinedButton(
                onPressed: () {
                  var allnotes = NotessModelDatabase(
                      value: currentIndex, notes: notesController.text);
                  notes.create(allnotes, currentIndex).then((value) {
                    Get.find<NotesTableController>().getNotes();
                  });
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                ),
                child: Text(
                  'Save',
                  style: TextStyle(color: Colors.white),
                )),
            const SizedBox(
              height: 16,
            ),
            allnotes.isEmpty
                ? Center(child: Text("Start Writing your notes"))
                : ListView.builder(
                    itemCount: allnotes.length,
                    shrinkWrap: true,
                    reverse: true,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        leading: Text(allnotes[index].notes ?? "-"),
                        trailing: GestureDetector(
                            onTap: () {
                              notes.delete(allnotes[index].id).then((value) {
                                if (value == true) {
                                  Get.find<NotesTableController>().getNotes();
                                } else {}
                              });
                            },
                            child: Icon(Icons.delete)),
                      );
                    },
                  ),
          ],
        );
      }),
    );
  }
}
