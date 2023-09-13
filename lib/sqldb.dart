import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqlDb {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await initialDb();
      return _db;
    } else {
      return _db;
    }
  }



  initialDb() async {
    String databaseName = "ecommerce.db";
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, databaseName);
    print(path);
    Database mydb = await openDatabase(path,
        onCreate: _onCreate, version: 2, onUpgrade: _onUpgrade);

    return mydb;
  }

  _onCreate(Database db, int version) async {
    print("here");
    await db.execute('''
    DROP TABLE IF EXISTS FavoriteItems;
    DROP TABLE IF EXISTS Users;
''');

    await db.execute('''
    CREATE TABLE IF NOT EXISTS Users(
      "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
      "username" TEXT NOT NULL,
      "email" TEXT NOT NULL,
      "region" TEXT NOT NULL
    )
''');
    await db.execute('''
    CREATE TABLE IF NOT EXISTS FavoriteItems(
      "userId" INTEGER NOT NULL,
      "itemId" INTEGER NOT NULL,
      "favorite" BOOLEAN,    
      PRIMARY KEY("userId", "itemId"),
      FOREIGN KEY("userId") REFERENCES "Users" (id)
    )
''');

    print("TABLE CREATED==========================");
  }

  _onUpgrade(Database db, int oldVersion, int newVersion) async {
    await db.execute('''
    DROP TABLE FavoriteItems;
    DROP TABLE Users;
''');

    await db.execute('''
    CREATE TABLE IF NOT EXISTS Users(
      "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      "region" TEXT NOT NULL
    )
''');
    await db.execute('''
    CREATE TABLE IF NOT EXISTS FavoriteItems(
      "userId" INTEGER NOT NULL,
      "itemId" INTEGER NOT NULL,
      "favorite" BOOLEAN, 
      PRIMARY KEY("userId", "itemId"),
      FOREIGN KEY("userId") REFERENCES "Users" (id)
    )
''');

    print(
        "TABLE UPGRADED FROM VERSION $oldVersion TO: $newVersion========================");
  }

  readData(String sql) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery(sql);
    return response;
  }

  insertData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawInsert(sql);
    return response;
  }

  updateData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawUpdate(sql);
    return response;
  }

  deleteData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawDelete(sql);
    return response;
  }
}
