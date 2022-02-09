// import 'package:sqflite/sqflite.dart' as sql;
// import 'package:path/path.dart' as path;

// class DBHelper {
//   static Future<sql.Database> getDatabase() async {
//     final dbPath = await sql.getDatabasesPath();
//     return sql.openDatabase(path.join(dbPath, 'goodHabits.db'),
//         onCreate: (db, version) {
//       return db.execute(
//           'CREATE TABLE good_habits(id TEXT PRIMARY KEY, title TEXT, startDate TEXT, duration INTEGER)');
//     }, version: 1);
//   }

//   static Future<void> insert(String table, Map<String, Object> data) async {
//     final db = await DBHelper.getDatabase();
//     db.insert(
//       table,
//       data,
//       conflictAlgorithm: sql.ConflictAlgorithm.replace,
//     );
//   }

//   static Future<List<Map<String, dynamic>>> getData(String table) async {
//     final db = await DBHelper.getDatabase();
//     return db.query(table);
//   }
// }
