import 'package:new_recofarm_app/model/interesting_area_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
/* 
    Description : local db viewmodel
    Author 		: Lcy
    Date 			: 2024.04.19
*/

class DatabaseHandler {

  Future<Database> initalizeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'intersteplace.db'),
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE place '
          '(seq integer primary key autoincrement,'
          'name text(50),'
          'area numeric(50)'
          'lat numeric(30),'
          'long numeric(30),'
        );
      },
      version: 1,
    );
  }

  Future<List<Area>> queryReview() async {
    final Database db = await initalizeDB();
    final List<Map<String, Object?>> result = await db.rawQuery('SELECT * FROM place');

    return result.map((e) => Area.fromMap(e)).toList();
  }

  // Future<int> insertReview(Area review) async {
  //   final Database db = await initalizeDB();
  //   int result;
  //   result = await db.rawInsert(
  //     'INSERT INTO musteatplace '
  //     '(name,phone,lat,long,image,estimate,initdate) '
  //     'VALUES (?,?,?,?,?,?,?)',
  //     [review.name, review.phone, review.lat, review.long, review.image, review.estimate, review.initdate]
  //   );
  //   return result;
  // }

  // Future<int> updateReview(Review review) async {
  //   final Database db = await initalizeDB();
  //   int result;
  //   result = await db.rawInsert(
  //     'UPDATE musteatplace SET '
  //     'name=?, phone=?, lat=?, long=?, image=?, estimate=? '
  //     'WHERE seq=?',
  //     [review.name, review.phone, review.lat, review.long, review.image, review.estimate, review.seq]
  //   );
  //   return result;
  // }

  // Future<void> deleteReview(int? seq) async {
  //   final Database db = await initalizeDB();
  //   await db.rawDelete(
  //     'DELETE FROM musteatplace '
  //     'WHERE seq = ?',
  //     [seq]
  //   );
  // }

}