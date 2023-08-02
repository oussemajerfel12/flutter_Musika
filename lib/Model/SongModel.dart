import 'package:sqflite/sqflite.dart'; //sqflite package
import 'package:path_provider/path_provider.dart'; //path_provider package
import 'package:path/path.dart'; //used to join paths
import './SongModel.dart'; //import model class
import 'dart:io';
import 'dart:async';

class SongModel {
  final String? RscUid;
  final String? ThumbSmall;
  final String? Id;
  final String? Crtr;
  final String? Lien;

  SongModel({this.RscUid, this.ThumbSmall, this.Id, this.Crtr, this.Lien});

  Map<String, dynamic> toMap() {
    // used when inserting data to the database
    return <String, dynamic>{
      "RscUid": RscUid,
      "ThumbSmall": ThumbSmall,
      "Id": Id,
      "Crtr": Crtr,
      "Lien": Lien
    };
  }
}
