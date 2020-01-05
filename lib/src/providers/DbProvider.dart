import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_scanner/src/models/ScanModel.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  static Database _database;
  static final DBProvider db = DBProvider._(); /*Constructor privado.*/

  DBProvider._();

  Future<Database> get database async {
    if(_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async{
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'ScansDB.db');

    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE Scans('
          'id INTEGER PRIMARY KEY,'
          'tipo TEXT,'
          'valor TEXT'
          ')'
        );
      }
    );
  }

  //Crear registros

  newScanRaw(ScanModel newScan) async {
    final db = await database;
    final res = await db.rawInsert(
      "INSERT Into Scans (id, tipo, valor) "
      "VALUES (${newScan.id}, '${newScan.tipo}', '${newScan.valor}')"
    );
    return res;
  }

  //Select

  Future<ScanModel> getScanId(int id) async{ 
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM Scans where id=$id");
    return res.isNotEmpty ? ScanModel.fromJson(res.first) : null;
  }

  Future<List<ScanModel>> getAllScans() async{
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM Scans");
    if(res.isNotEmpty){
      return [];
    }
    else {
      return res.map((scan) => ScanModel.fromJson(scan)).toList();
    }
  }

  Future<List<ScanModel>> getScansForType(String tipo) async{
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM Scans where tipo ='$tipo'");
    if(res.isNotEmpty) return [];
    else {
      return res.map((scan) => ScanModel.fromJson(scan)).toList();
    }
  }

  Future<int> updateScan(ScanModel newScan) async {
    final db = await database;
    return await db.update('Scans', newScan.toJson(), where: 'id= ?', whereArgs: [newScan.id]);
  }


}
