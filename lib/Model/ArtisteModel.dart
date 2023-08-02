import 'package:sqflite/sqflite.dart'; //sqflite package
import 'package:path_provider/path_provider.dart'; //path_provider package
import 'package:path/path.dart'; //used to join paths
import './ArtisteModel.dart';
import 'dart:io';
import 'dart:async';

class ArtisteModel {
  final String? RscUid;
  final String? ttl;
  final String? Id;
  final String? ThumbSmall;

  ArtisteModel({this.RscUid, this.ttl, this.Id, this.ThumbSmall});
  Map<String, dynamic> toMap() {
    // used when inserting data to the database
    return <String, dynamic>{
      // used when inserting data to the database
      "RscUid": RscUid, "ttl": ttl, "Id": Id, "ThumbSmall": ThumbSmall
    };
  }
}
