import 'package:sqflite/sqflite.dart';
import 'Depense.dart';

class DBManager {
  static Database? db;
  static int version = 1;
  static String tableName = "depense";
  static String dbName = 'depense';

  //Creation de la base de donne si elle n'existe pas
  static Future<void> initDB() async {
    if (db != null) return;
    String path = await getDatabasesPath() + dbName;
    db = await openDatabase(path, version: version, onCreate: (db, version) {
      return db.execute('''
      CREATE TABLE $tableName(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        description TEXT,
        montant BIGINT,
        categorie STRING,
        date STRING
      )
''');
    });
  }

  static Future<List<int>> getAllDepense() async {
    List<int> allDepense = [];
    try {
      List<Map<String, dynamic>> result = await query();
      // Traitement des données ici
      for (var row in result) {
        int montant = row['montant'];
        allDepense.add(montant);
      }
    } catch (error) {
      print('Erreur lors de la récupération des données : $error');
    }
    return allDepense;
  }

  //Insertion d'une donnee dans la base
  static Future<int> insert(Depense? task) async {
    return await db?.insert(tableName, task!.toJson()) ?? 1;
  }

  //Prendre les donnes dans la base
  static Future<List<Map<String, dynamic>>> query() async {
    return await db!.query(tableName);
  }

  static Future<List<int>> getAllLoyer() async {
    List<int> loyer = [];
    try {
      List<Map<String, dynamic>> result = await query();
      // Traitement des données ici
      for (var row in result) {
        var categorie = row['categorie'];
        var montant = row['montant'];
        if (categorie == 'Loyer') loyer.add(montant);
      }
    } catch (error) {
      print('Erreur lors de la récupération des données : $error');
    }
    return loyer;
  }

  static Future<List<int>> getAllLoisir() async {
    List<int> loyer = [];
    try {
      List<Map<String, dynamic>> result = await query();
      // Traitement des données ici
      for (var row in result) {
        var categorie = row['categorie'];
        var montant = row['montant'];
        if (categorie == 'Loisir') loyer.add(montant);
      }
    } catch (error) {
      print('Erreur lors de la récupération des données : $error');
    }
    return loyer;
  }

  static Future<List<int>> getAllAutre() async {
    List<int> loyer = [];
    try {
      List<Map<String, dynamic>> result = await query();
      // Traitement des données ici
      for (var row in result) {
        var categorie = row['categorie'];
        var montant = row['montant'];
        if (categorie == 'Autre') loyer.add(montant);
      }
    } catch (error) {
      print('Erreur lors de la récupération des données : $error');
    }
    return loyer;
  }

  static Future<List<int>> getAllAlimentation() async {
    List<int> loyer = [];
    try {
      List<Map<String, dynamic>> result = await query();
      // Traitement des données ici
      for (var row in result) {
        var categorie = row['categorie'];
        var montant = row['montant'];
        if (categorie == 'Alimentation') loyer.add(montant);
      }
    } catch (error) {
      print('Erreur lors de la récupération des données : $error');
    }
    return loyer;
  }

  static Future<List<Depense>> getAllData() async {
    List<Depense> depense = [];
    try {
      List<Map<String, dynamic>> result = await query();
      // Traitement des données ici
      for (var row in result) {
        var id = row['id'];
        var description = row['description'];
        var categorie = row['categorie'];
        var montant = row['montant'];
        var date = row['date'];
        Depense d = Depense(
            id: id,
            description: description,
            categorie: categorie,
            montant: montant,
            date: date);
        depense.add(d);
      }
    } catch (error) {
      print('Erreur lors de la récupération des données : $error');
    }
    return depense;
  }

  static delete(Depense task) async {
    return await db!.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [task.getId()],
    );
  }

  static Future<int> updateNote(Depense note) async {
    return db!.rawUpdate(
        'UPDATE $tableName SET descrption = ?, montant = ?,categorie = ?,date = ? WHERE id = ?',
        [
          note.getDescription(),
          note.getMontant(),
          note.getCategorie(),
          note.getDate(),
          note.getId()
        ]);
  }
}
