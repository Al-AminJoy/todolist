import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
class DatabaseConnection{
  setDatabase() async {
    var directory=await getApplicationDocumentsDirectory();
    var path=join(directory.path,'db.todoList');
    var database=
        await openDatabase(path,version: 1,onCreate: _onCreatingDatabase);
    return database;
  }
  _onCreatingDatabase(Database database,int version) async{
    await database.execute(
      "CREATE TABLE categories(id INTEGER PRIMARY KEY, name TEXT, description TEXT)");
    await database.execute(
        "CREATE TABLE todos(id INTEGER PRIMARY KEY, title TEXT, description TEXT, category TEXT, todoDate TEXT,isFinished INTEGER)");
  }
}