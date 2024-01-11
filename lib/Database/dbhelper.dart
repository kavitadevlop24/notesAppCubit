import 'dart:io';

import 'package:notes_app_cubit/Models/notesmodel.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  DbHelper._();

  static final DbHelper instance = DbHelper._();

  Database? _database;

  static final note_table = "note_table";
  static final note_id = "note_id";
  static final note_title = "note_title";
  static final note_desc = "note_desc";

  Future<Database> getDb() async {
    if (_database != null) {
      return _database!;
    } else {
      return await initDb();
    }
  }

  Future<Database> initDb() async {
    Directory directory = await getApplicationDocumentsDirectory();
    var dbpath = join(directory.path + "notesdb.db");
    return openDatabase(dbpath, version: 1, onCreate: (db, version) {
      return db.execute(
          "create table $note_table ( $note_id integer primary key autoincrement,$note_title text,$note_desc )");
    });
  }

  addNotes(NotesModel notesModel) async {
    var db = await getDb();
    db.insert(note_table, notesModel.toMap());
  }

  Future<List<NotesModel>> getNotes() async {
    var db = await getDb();
    List<NotesModel> listNotes = [];
    var data = await db.query(note_table);
    for (Map<String, dynamic> getdata in data) {
      NotesModel notesModel = NotesModel.fromMap(getdata);
      listNotes.add(notesModel);
    }
    return listNotes;
  }
Future<bool>updateNote(NotesModel notesModel)async{
    var db = await getDb();
    var count = await db.update(note_table, notesModel.toMap(),where:'$note_id=${notesModel.id}');
    return count>0;
}
Future<bool>deleteNote(int id)async{
    var db = await getDb();
    var count = await db.delete(note_table,where: '$note_id=?',whereArgs: [id]);
    return count>0;
}

}
