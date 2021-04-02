import 'package:sqflite/sqflite.dart';
import 'package:todolist/repositories/database_connection.dart';

class Repository{
  DatabaseConnection _databaseConnection;
  Repository(){
    _databaseConnection=DatabaseConnection();
  }
  static Database _database;
  Future<Database> get database async {
    if(_database!=null) return _database;
    _database=await _databaseConnection.setDatabase();
    return _database;
  }

  insertData(table,data) async {
    var connection=await database;
    return await connection.insert(table, data);
  }

  readData(table) async{
    var connection=await database;
    return await connection.query(table);
  }
  readDatById(table,itemId) async{
    var connection=await database;
    return await connection.query(table,where:'id=?',whereArgs: [itemId]);
  }

  update(table,data)async {
    var connection=await database;
    return await connection.update(table, data,where: 'id=?',whereArgs: [data['id']]);

  }

  deleteDatById(table, itemId) async{
    var connection=await database;
    return await connection.rawDelete("DELETE FROM $table WHERE id= $itemId");
  }

}