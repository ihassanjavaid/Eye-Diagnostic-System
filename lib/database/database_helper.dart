import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper{
  static final _dbName = 'eyeseeDatabase.db';
  static final _dbVersion = 1;

  //columns for user profile table
  static final _userProfileTable = 'userProfileTable';
  static final idColumn = '_id';
  static final emailColumn = 'email';
  static final ageColumn = 'age';
  static final displayName = 'displayName';
  static final photoRef = 'photoRef';

  //columns for reminders table
  static final _remindersTable = 'remindersTable';
  static final actualDate = 'actualDate';
  static final isRecurring = 'isRecurring';
  static final timestamp = 'timestamp';
  static final recurrence = 'recurrence';

  //columns for reports table
  static final _reportsTable = 'reportsTable';
  static final onMedicine = 'onMedicine';
  static final report = 'report';

  //columns for ailments table
  static final _ailmentsTable = 'ailmentsTable';
  static final reportid = 'reportid';
  static final name = 'name';




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
      $emailColumn TEXT NOT NULL, 
      $ageColumn INTEGER NOT NULL   
      $displayName TEXT NOT NULL, 
      $photoRef TEXT NOT NULL   
      ) 
      '''
    );

    db.execute(
        '''
      CREATE TABLE $_remindersTable(
      $idColumn INTEGER PRIMARY KEY, 
      $emailColumn TEXT NOT NULL,
      $actualDate TEXT NOT NULL,
      $isRecurring INTEGER NOT NULL, 
      $timestamp TEXT NOT NULL, 
      $recurrence INTEGER NOT NULL, 
      ) 
      '''
    );

    db.execute(
        '''
      CREATE TABLE $_reportsTable(
      $idColumn INTEGER PRIMARY KEY, 
      $report TEXT NOT NULL,
      $emailColumn TEXT NOT NULL, 
      $onMedicine INTEGER NOT NULL, 
      ) 
      '''
    );

    db.execute(
        '''
      CREATE TABLE $_ailmentsTable(
      $idColumn INTEGER PRIMARY KEY, 
      $name TEXT NOT NULL,
      $reportid INTEGER NOT NULL, 
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