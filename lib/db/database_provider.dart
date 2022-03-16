// ignore_for_file: prefer_const_declarations, unused_local_variable

import 'package:dreamnote/model/dream_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  DatabaseProvider._();
  static final DatabaseProvider db = DatabaseProvider._();
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database ?? await initDb('dreams.db');
    }
    _database = await initDb('dreams.db');
    return _database ?? await initDb('dreams.db');
  }

  Future<Database> initDb(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = ' INTEGER PRIMARY KEY AUTOINCREMENT ';
    final textType = ' TEXT NOT NULL ';
    final dateType = ' DATE NOT NULL ';
    await db.execute('''
CREATE TABLE $tableDreams (
    ${DreamField.id} $idType,
    ${DreamField.title} $textType,
    ${DreamField.description} $textType,
    ${DreamField.picturepath} $textType,
    ${DreamField.category} $textType,
    ${DreamField.time} $dateType
)
''');
  }

  Future<DreamModel> create(DreamModel dream) async {
    final daba = await db.database;
    final id = await daba.insert(tableDreams, dream.toMap());
    return dream.copy(id: id);
  }

  Future<DreamModel> readDream(int id) async {
    final daba = await db.database;
    final maps = await daba.query(
      tableDreams,
      columns: DreamField.values,
      where: '${DreamField.id} = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return DreamModel.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<DreamModel>> readAllDreams() async {
    final daba = await db.database;
    final orderBy = '${DreamField.time} ASC';
    final result = await daba.query(tableDreams, orderBy: orderBy);
    return result.map((json) => DreamModel.fromJson(json)).toList();
  }

  Future<int> update(DreamModel dream) async {
    final daba = await db.database;
    return daba.update(
      tableDreams,
      dream.toMap(),
      where: '${DreamField.id} = ?',
      whereArgs: [dream.id],
    );
  }

  Future<int> delete(int id) async {
    final daba = await db.database;
    return await daba.delete(
      tableDreams,
      where: '${DreamField.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final daba = await db.database;
  }

  /*addNewDream(DreamModel dream) async {
    final db = await database;
    db.insert(
      "dreams",
      dream.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }


  Future<dynamic> getDreams() async{
    final db = await database;
    var res = await db.query("dreams");
    if(res.length == 0){
      return Null;
    }else{
      var resultMap = res.toList();
      return resultMap.isNotEmpty ? resultMap : Null;
    }
  }*/
}
