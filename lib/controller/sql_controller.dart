import 'dart:developer';

import 'package:get/get.dart';
import 'package:getx_sql/models/todo_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqlController extends GetxController {
  late Database database;

  @override
  void onInit() {
    createDataBase();
    super.onInit();
  }

  // create database
  void createDataBase() async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'todo.db');

    openAppDataBase(path: path);
  }

  // delete all database From Device (Table)
  void deleteAllDataBase() async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'todo.db');
    // Delete the database
    await deleteDatabase(path);
    log('All Database is Deleted');
  }

  // open database
  void openAppDataBase({required String path}) async {
    // open the database
    await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        // When creating the db, create the table
        // "todo" =>is our table name // id => PRIMARY KEY increment auto
        await db.execute(
          'CREATE TABLE todo (id INTEGER PRIMARY KEY,'
          'title TEXT,'
          'description TEXT,'
          'time TEXT,'
          'favorite INTEGER,'
          'completed INTEGER)',
        );
        log('database is created');
      },
      onOpen: (Database db) {
        database = db;
        log('database is opened');
        // To show the data in the console
        getAllDataBase();
      },
    );
  }

  // get all data
  List<ToDOModel> list = [];
  List<ToDOModel> favList = [];
  void getAllDataBase() async {
    list = [];
    favList = [];
    var allData = await database.query('todo');
    for (var i in allData) {
      list.add(ToDOModel.fromJson(i));
      if (i['favorite'] == 1) favList.add(ToDOModel.fromJson(i));
      log(i.toString());
    }
    // To Update State of UI
    update();
    log('all data list ${list.toString()}');
    log('Favorite list ${list.toString()}');
  }

  // insert data
  void insertDataBase({
    required String title,
    required String description,
    required String time,
  }) async {
    try {
      var insert = await database.insert('todo', {
        'title': title,
        'description': description,
        'time': time,
        'favorite': 0,
        'completed': 0,
      });
      log('$insert Data is inserted');
      // Navigate to back and get all data
      Get.back();
      getAllDataBase();
    } catch (e) {
      log(e.toString());
    }
  }

  // update data
  bool isUpdateTask = false;
  // int? id;

  void updateDataBase({
    required int id,
    required String title,
    required String description,
    required String time,
  }) async {
    try {
      var updateData = await database.update('todo', {
        'title': title,
        'description': description,
        'time': time,
        'favorite': 0,
        'completed': 0,
      }, where: 'id = $id');
      log('$updateData Data is updated');
      // Navigate to back and get all data
      Get.back();
      getAllDataBase();
    } catch (e) {
      log(e.toString());
    }
  }

  // delete one Item data from list by id
  void deleteOneItemData({required int id}) async {
    var deleteData = await database.delete('todo', where: 'id = $id');
    log('Deleted Item $deleteData');
    // To Update State of UI
    getAllDataBase();
  }

  void updateItemToBeFav({required int taskId, required int favorite}) async {
    // update item to be favorite
    var updateData = await database.update('todo', {
      'favorite': (favorite == 0) ? 1 : 0,
    }, where: 'id = $taskId');
    log('$updateData Favorite Data is updated');
    getAllDataBase();
  }
}
