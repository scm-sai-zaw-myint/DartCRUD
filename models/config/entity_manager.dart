import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../../main.dart';
import 'table.dart';

/// # EntityManager
/// The entity manager class to use for analysis the database
///
/// @author SaiZawMyint
class EntityManager {

  late Database _database;

  /// ## Constructor
  /// the initialize the [sqlflite]
  EntityManager(){
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  /// To initialize the database
  ///
  /// Parameters:
  /// - tables [List<Table>]
  Future<void> initDatabase(List<Table> tables) async{
    this._database = await openDatabase('$projectPath\\Test.db');
     await _checkTables(tables);
  }
  /// To check the tables
  ///
  /// Parameters:
  /// - tables [List<Table>?]
  Future<void> _checkTables(List<Table>? tables) async{
    if(tables == null || tables.length ==0){return;}
    tables.forEach((table) async {
      final dbTables = await _tablesName();
      if(!dbTables.contains(table.getClassName())){
        await database.execute(table.createQuery());
        print('Table with the name ${table.getClassName()} created');
      }
    });
  }

  /// Get the database's table names
  ///
  /// @return [Future<List<String>>]
  Future<List<String>> _tablesName() async{
    List<Map<String, dynamic>> tables = await database
        .query('sqlite_master', where: 'type = ?', whereArgs: ['table']);
    return tables.map((row) => row['name'] as String).toList();
  }

  /// get the current database
  ///
  /// @return [Database]
  Database get database => _database;
}