import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qrreaderapp/src/models/scan_model.dart';
export 'package:qrreaderapp/src/models/scan_model.dart';




class DBProvider {

  static Database _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    
    if(_database != null) return _database;

    _database = await _initDB();

    return _database;

  }

   _initDB() async {

     Directory documentsDirectory = await getApplicationDocumentsDirectory();
     final path = join(documentsDirectory.path, 'scansDB.db');

     return await openDatabase(
       path,
       version: 1,
       onOpen: (db) {},
       onCreate: (Database db, int version) async {
         await db.execute(
           'create table Scans ('
            ' id integer primary key,'
            ' tipo text,'
            ' valor text'
           ')'
         );
       }
      );

  }

  // crear registros

  nuevoScanRow(ScanModel nuevoScan) async {

    final db = await database;

    final res = await db.rawInsert(
      " insert into Scans (id,tipo,valor) "
      " values ( ${nuevoScan.id}, '${nuevoScan.tipo}', '${nuevoScan.valor}' )"
    );

    return res;
  }

  Future<int> nuevoScan( ScanModel nuevoScan ) async{
    final db = await database;
    final res = await db.insert('Scans', nuevoScan.toJson());
    return res;
  }

  //Obtener registros
  Future<ScanModel> getScanId(int id) async {
    
    final db = await database;
    final res = await db.query('Scans', where: ' id = ?', whereArgs: [id]);
    return res.isNotEmpty ? ScanModel.fromJson(res.first) : null;

  }

  Future<List<ScanModel>> getTodosScans() async {
    final db = await database;
    final res = await db.query('Scans');
    
    return res.isNotEmpty ? res.map((scan) { 
      return ScanModel.fromJson(scan);
    }).toList() : [];

  }

   Future<List<ScanModel>> getScansPorTipo(String tipo) async {
    final db = await database;
    final res = await db.rawQuery("select * from Scans where tipo = '$tipo'");
    
    return res.isNotEmpty ? res.map((scan) { 
      return ScanModel.fromJson(scan);
    }).toList() : [];

  }

  //Actualizar registros

  Future<int> updateScan( ScanModel nuevoScan ) async {

    final db = await database;
    final res = await db.update('Scans', nuevoScan.toJson(), where: ' id = ?', whereArgs: [nuevoScan.id]);
    return res;

  }

  //Eliminar registros
  Future<int> deleteScan(int id) async{
    final db = await database;
    final res = await db.delete('Scans', where: ' id = ?', whereArgs: [id]);
    return res;
  }

  Future<int> deleteAll() async{
    final db = await database;
    final res = await db.rawDelete('delete from Scans');
    return res;
  } 

}