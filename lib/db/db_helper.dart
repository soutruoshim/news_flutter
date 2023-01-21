import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE bookmarks(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        source TEXT,
        author TEXT,
        title TEXT,
        description TEXT,
        url TEXT,
        urlToImage TEXT,
        publishedAt TEXT,
        content TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'news.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  // Create new item (journal)
  static Future<int> createItem(
  String source,
  String author,
  String title,
  String description,
  String url,
  String urlToImage,
  String publishedAt,
  String content) async {
    final db = await SQLHelper.db();
    final data = {
      'source':source,
      'author':author,
      'title':title,
      'description':description,
      'url':url,
      'urlToImage':urlToImage,
      'publishedAt':publishedAt,
      'content':content
    };
    final id = await db.insert('bookmarks', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }
  // Read all items
  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await SQLHelper.db();
    print(db.query('bookmarks', orderBy: "id"));
    return db.query('bookmarks', orderBy: "id DESC");
  }

  // Read all items
  static Future<List<Map<String, dynamic>>> searchItems({String query = ""}) async {
    final db = await SQLHelper.db();
    print(db.query('bookmarks',where: "title Like ?",whereArgs: ['%$query%']));
    return db.query('bookmarks',where: "title Like ?",whereArgs: ['%$query%']);
  }

  // Read a single item by id
  // The app doesn't use this method but I put here in case you want to see it
  static Future<List<Map<String, dynamic>>> getItem(String title) async {
    final db = await SQLHelper.db();
    print(db.query('bookmarks', where: "title = ?", whereArgs: [title], limit: 1));
    return db.query('bookmarks', where: "title = ?", whereArgs: [title], limit: 1);
  }

  // Update an item by id
  static Future<int> updateItem(
      String source,
      String author,
      String title,
      String description,
      String url,
      String urlToImage,
      String publishedAt,
      String content) async {
    final db = await SQLHelper.db();

    final data = {
      'source':source,
      'author':author,
      'title':title,
      'description':description,
      'url':url,
      'urlToImage':urlToImage,
      'publishedAt':publishedAt,
      'content':content,
      'createdAt': DateTime.now().toString()
    };

    final result =
    await db.update('bookmarks', data, where: "title = ?", whereArgs: [title]);
    return result;
  }

  // Delete
  static Future<void> deleteItem(String title) async {
    final db = await SQLHelper.db();
    try {
      await db.delete("bookmarks", where: "title = ?", whereArgs: [title]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
}