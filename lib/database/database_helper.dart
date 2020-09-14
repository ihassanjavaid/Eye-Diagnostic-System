import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper{
  static final _dbName = 'eyeseeDatabase.db';
  static final _dbVersion = 1;
  static final _userProfileTable = 'userProfileTable';
  static final idColumn = '_id';
  static final nameColumn = 'name';

  //creating a singleton constructor
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database _database;

  Future<Database> get database async{
    if(_database != null){
      print('database found');
      return _database;
    }
    else{
      _database = await _initiateDatabase();
      print('creating database');
      return _database;
    }
  }

  _initiateDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path,_dbName);
    return await openDatabase(path,version: _dbVersion, onCreate: _onCreate);
  }


  Future _onCreate(Database db, int version){
    db.execute(
      '''
      CREATE TABLE $_userProfileTable(
      $idColumn INTEGER PRIMARY KEY,
      $nameColumn TEXT NOT NULL
      ) 
         
      '''
    );
  }


  Future<int> insert(Map<String,dynamic> row) async{
    Database db = await instance.database;
    return await db.insert(_userProfileTable, row);
  }


  Future<List<Map<String,dynamic>>> queryAll() async{
    Database db = await instance.database;
    return await db.query(_userProfileTable);
  }


  Future<int> update(Map<String,dynamic> row) async{
    Database db = await instance.database;
    int id = row[idColumn];
    return await db.update(_userProfileTable, row, where: '$idColumn = ?', whereArgs: [id]);
  }


  Future<int> delete(int id) async{
    Database db = await instance.database;
    return await db.delete(_userProfileTable,where: '$idColumn = ?', whereArgs: [id]);

  }

}