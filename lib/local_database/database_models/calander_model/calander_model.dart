// ignore_for_file: public_member_api_docs, sort_constructors_first

import '../../data_type.dart';

const String tableNotes = "notesTable";

class NotesFields {
  static final List<String> values = [id, value, notes];

  static const String id = "_id";
  static const String value = "_value";
  static const String notes = "notes";
}

//model
class NotessModelDatabase {
  int? id;
  int value;
  String? notes;
  NotessModelDatabase({
    this.id,
    required this.value,
    this.notes,
  });

  NotessModelDatabase copy(
      {int? id, int? value, String? notes, String? remarks}) {
    return NotessModelDatabase(
      id: id ?? this.id,
      value: value ?? this.value,
      notes: notes ?? this.notes,
    );
  }

  static NotessModelDatabase fromJson(Map<String, Object?> json) =>
      NotessModelDatabase(
        id: json[NotesFields.id] as int?,
        value: json[NotesFields.value] as int,
        notes: json[NotesFields.notes] as String?,
      );
  Map<String, Object?> toJson() => {
        NotesFields.id: id,
        NotesFields.value: value,
        NotesFields.notes: notes,
      };

  //types
  static String tableCreation = '''
CREATE TABLE $tableNotes(
  ${NotesFields.id} $idType,
  ${NotesFields.value} $integerType,
  ${NotesFields.notes} $textNullType
)
''';
}
