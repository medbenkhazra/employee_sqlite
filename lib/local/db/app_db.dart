import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:sqlite/local/entity/employee.dart';
part  'app_db.g.dart';
LazyDatabase _opneConnection(){
  return LazyDatabase(
    () async{
      final dbFolder=await getApplicationDocumentsDirectory();
      final file=File(path.join(dbFolder.path,'employee.sqlite'));
      return NativeDatabase(file);
   
    }
  );
}

@DriftDatabase(tables:[Employee])
class AppDb extends _$AppDb{
  AppDb():super(_opneConnection());

  /* @override
  int get shemaVersion=>1; */

  @override
  // TODO: implement schemaVersion
  int get schemaVersion => 1;



  Future<List<EmployeeData>> getEmployees() async {
    return await select(employee).get();
  }

  Future<EmployeeData> getEmployee(int id) async {
    return await (select(employee)..where((tbl) => tbl.id.equals(id))).getSingle();
  }

  Future<bool> updateEmployee(EmployeeCompanion entity) async {
    return await update(employee).replace(entity);
  }

  Future<int> insertEmployee(EmployeeCompanion entity) async {
    return await into(employee).insert(entity);
  }

  Future<int> deleteEmployee(int id) async {
    return await (delete(employee)..where((tbl) => tbl.id.equals(id))).go();
  }

  
}