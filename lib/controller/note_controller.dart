import 'package:local_storage/model/note_model.dart';

import '../database/note_database.dart';

class NoteController {
  final DatabaseService _service = DatabaseService();
  Future<void> insertData(NoteModel model) async {
    final db = await _service.initializeData();
    await db.insert(_service.table, model.fromJson());
  }

  Future<List<NoteModel>> getData() async {
    final db = await _service.initializeData();
    List<Map<String, dynamic>> result = await db.query(_service.table);
    return result.map((e) => NoteModel.toJson(e)).toList();
  }

  Future<void> updateData(NoteModel model) async {
    final db = await _service.initializeData();
    await db.update(_service.table, model.fromJson(),
        where: 'id=?', whereArgs: [model.id]);
  }

  Future<void> deleteData(int id) async {
    final db = await _service.initializeData();
    await db.delete(_service.table, where: 'id=?', whereArgs: [id]);
  }
}
