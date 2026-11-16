import 'dart:io';

import 'package:path/path.dart'; // OJO: Dependiendo de tu version puede ser import 'package:path/path.dart';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  static Database? _database;

  // 1. Instancia única privada (El Singleton)
  static final DBProvider db = DBProvider._();
  DBProvider._();

  // 2. Getter para obtener la base de datos
  Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await initDB();
    return _database;
  }

  // 3. Método para inicializar la BD
  Future<Database> initDB() async {
    // Obtener el path donde se almacenarán las bases de datos del teléfono
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'ScansDB.db');

    print(
      path,
    ); // Esto te sirve para ver dónde se guarda el archivo en tu PC/móvil

    // Crear la tabla inicial de la base de datos
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE Scans(
            id INTEGER PRIMARY KEY,
            tipo TEXT,
            valor TEXT
          )
        ''');
      },
    );
  }
}
