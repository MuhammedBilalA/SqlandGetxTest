import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sql_test/controller.dart';
import 'package:sql_test/model.dart';

class SqlFunctions {
  late Database _db;
  Future<void> initializeDatabase() async {
    _db = await openDatabase(
      'details.db',
      version: 1,
      onCreate: (db, version) async {
        db.execute('CREATE TABLE details (id INTEGER PRIMARY KEY, name TEXT, age TEXT)');
      },
    );
  }

  Future<void> deleteDetails(int id) async {
    await _db.rawDelete('DELETE FROM details WHERE id = ?', [id]);
    await getAllData();
  }

  Future<void> addDetails(DetailsModel value) async {
    await _db.rawInsert('INSERT INTO details (name,age) VALUES (?,?)', [value.name, value.age]);
  await  getAllData();
  }

  Future<void>editStudent(String name, String age, int id) async {
    await _db.rawUpdate('UPDATE details SET name = ?, age = ? WHERE id = ?', [name, age, id]);
   await getAllData();
  }

  Future<void> getAllData() async {
    final controller = Get.find<DetailsController>();

    final _values = await _db.rawQuery('SELECT * FROM details');
    print(_values);
    controller.detailsList.clear();
    for (var map in _values) {
      final details = DetailsModel.fromMap(map);
      controller.detailsList.add(details);
    }
  }
}
