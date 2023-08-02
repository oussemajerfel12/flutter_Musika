import 'package:sqflite/sqflite.dart'; //sqflite package
import 'package:path_provider/path_provider.dart'; //path_provider package
import 'package:path/path.dart'; //used to join paths

import 'dart:io';
import 'dart:async';

class AlbumModel {
  final String? RscUid;
  final String? thumbSmall;
  final String? ttl;
  final String? Id;
  final String? identifiant;

  AlbumModel(
      {this.RscUid, this.thumbSmall, this.ttl, this.Id, this.identifiant});

  Map<String, dynamic> toMap() {
    // used when inserting data to the database
    return <String, dynamic>{
      "RscUid": RscUid,
      "thumbSmall": thumbSmall,
      "ttl": ttl,
      "Id": Id,
      "identifiant": identifiant,
    };
  }
}
