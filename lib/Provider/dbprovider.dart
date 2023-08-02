import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart'; //sqflite package
import 'package:path_provider/path_provider.dart'; //path_provider package
import 'package:path/path.dart'; //used to join paths
//import model class
import 'dart:io';
import 'dart:async';

import '../Model/AlbumModel.dart';
import '../Model/SongModel.dart';
import '../Model/ArtisteModel.dart';

class MemoDbProvider {
  List<SongModel> _favorites = [];
  final String SongsF = 'SongsF';
  final String RecentlyPlayed = 'RecentlyPlayed';
  final String ArtisteF = 'ArtisteF';
  Future<Database> init() async {
    Directory directory =
        await getApplicationDocumentsDirectory(); //returns a directory which stores permanent files
    final path = join(directory.path, "Lib.db"); //create path to database

    return await openDatabase(
        //open the database or create a database if there isn't any
        path,
        version: 5, onCreate: (Database db, int version) async {
      await db.execute('''
          CREATE TABLE IF NOT EXISTS SongsF(
          RscUid TEXT PRIMARY KEY ,
          ThumbSmall TEXT,
          Id TEXT,
          Crtr TEXT,
          Lien TEXT

          )''');

      await db.execute('''
          CREATE TABLE IF NOT EXISTS RecentlyPlayed(
          RscUid TEXT PRIMARY KEY ,
          ThumbSmall TEXT,
          Id TEXT,
          Crtr TEXT,
          Lien TEXT

          )''');

      await db.execute('''
          CREATE TABLE IF NOT EXISTS ArtisteF(
          RscUid TEXT PRIMARY KEY ,
          ttl TEXT,
          Id TEXT,
          ThumbSmall TEXT
          

          )''');

      await db.execute('''
          CREATE TABLE IF NOT EXISTS AlbumF(
          RscUid TEXT PRIMARY KEY ,
          thumbSmall TEXT,
          ttl TEXT,
          Id TEXT,
          identifiant TEXT

          )''');
    });
  }

  Future<void> deleteDatabase([String? path]) async {
    Directory directory = await getApplicationDocumentsDirectory();
    final String path = join(directory.path, "Library.db");

    // Delete the database file
    await deleteDatabase(path);
  }

  /*Recent */

  Future<int> addItemRecent(SongModel item) async {
    final db = await init(); // Open the database
    final existingItems = await db.query(
      RecentlyPlayed,
      where: 'Lien = ?',
      whereArgs: [
        item.Lien
      ], // Assuming 'id' is the unique identifier column in the database
      limit: 1, // Only retrieve one item
    );

    if (existingItems.isEmpty) {
      return db.insert(
        RecentlyPlayed,
        item.toMap(),
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
    } else {
      return 0; // Item already exists, no insertion needed
    }
  }

  /*  Debut Partie Faviorite Songs */

  Future<int> addItem(SongModel item) async {
    final db = await init();
    final result = await db.insert(
      SongsF,
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );

    // Ajouter l'élément à la liste favorites si l'insertion a réussi
    if (result != null && result > 0) {
      _favorites.add(item);
    }

    return result;
  }

  Future<List<SongModel>> fetchSongs() async {
    //returns the Songs as a list (array)

    final db = await init();
    final maps = await db
        .query("SongsF"); //query all the rows in a table as an array of maps

    return List.generate(maps.length, (i) {
      //create a list of Songs
      return SongModel(
        RscUid: maps[i]['RscUid'] as String,
        ThumbSmall: maps[i]['ThumbSmall'] as String,
        Id: maps[i]['Id'] as String,
        Crtr: maps[i]['Crtr'] as String,
        Lien: maps[i]['Lien'] as String,
      );
    });
  }

  Future<int> deleteSong(String RscUid) async {
    //returns number of items deleted
    final db = await init();

    int result = await db.delete("SongsF", //table name
        where: "RscUid = ?",
        whereArgs: [RscUid] // use whereArgs to avoid SQL injection
        );

    return result;
  }

  Future<int> findFavMusic(String RscUid) async {
    final db = await init();

    List<Map<String, dynamic>> result = await db.query(
      "SongsF",
      where: "RscUid = ?",
      whereArgs: [RscUid],
    );

    return result.length;
  }

  bool removeFavorite(SongModel item) {
    if (_favorites.contains(item)) {
      _favorites.remove(item);
      MemoDbProvider()
          .deleteSong(item.RscUid!); // remove the item from the database
      return true;
    }
    return false;
  }
  /*  fin Partie Faviorite Songs */

  /*Future<int> updateMemo(int id, SongModel item) async {
    // returns the number of rows updated

    final db = await init();

    int result = await db
        .update("Memos", item.toMap(), where: "id = ?", whereArgs: [id]);
    return result;
  }*/
/* partie Artiste */
  Future<int> addartiste(ArtisteModel item1) async {
    final db = await init();
    final result = await db.insert(
      "ArtisteF",
      item1.toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
    return result;
  }

  Future<int> deleteArtisteF(String RscUid) async {
    //returns number of items deleted
    final db = await init();

    int result = await db.delete("ArtisteF", //table name
        where: "RscUid = ?",
        whereArgs: [RscUid] // use whereArgs to avoid SQL injection
        );

    return result;
  }

  Future<int> FindArtiste(String RscUid) async {
    final db = await init();

    List<Map<String, dynamic>> result = await db.query(
      "ArtisteF",
      where: "RscUid = ?",
      whereArgs: [RscUid],
    );

    return result.length;
  }

  Future<int> addAlbum(AlbumModel item1) async {
    final db = await init();

    final result = await db.insert(
      "AlbumF",
      item1.toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );

    return result;
  }

  Future<int> deleteAlbumF(String RscUid) async {
    //returns number of items deleted
    final db = await init();

    int result = await db.delete("AlbumF", //table name
        where: "RscUid = ?",
        whereArgs: [RscUid] // use whereArgs to avoid SQL injection
        );

    return result;
  }

  Future<int> FindAlbum(String RscUid) async {
    final db = await init();

    List<Map<String, dynamic>> result = await db.query(
      "AlbumF",
      where: "RscUid = ?",
      whereArgs: [RscUid],
    );

    return result.length;
  }
}
