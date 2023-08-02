import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:musika/Model/AlbumModel.dart';
import 'package:musika/Model/ArtisteModel.dart';
import 'package:musika/Model/SongModel.dart';
import 'package:requests/requests.dart';

import 'package:musika/Model/SearchResult.dart';

import '../Provider/dbprovider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class libraryViewModel extends GetxController {
  final getStorge = GetStorage();
  RxBool hasItems = false.obs;
  RxList<SongModel> items = RxList<SongModel>([]);
  RxList<SongModel> itemsR = RxList<SongModel>();

  RxList<ArtisteModel> itemsArtiste = RxList<ArtisteModel>([]);
  RxList<AlbumModel> itemsAlbum = RxList<AlbumModel>([]);

  Future<List<Label>?> loadPlayList() async {
    String body =
        '{"query":{"ResultSize":10,"Page":0,"SearchInput":"","LabelFilter":[]}}';

    Uri linkLogin = Uri(
      scheme: 'https',
      host: 'integ03-cmam.archimed.fr',
      path: 'MUSIKA/Portal/Recherche/search.svc/SearchUserBasket',
    );

    var cookiza = getStorge.read("syrSessGuid");

    var InstanceST = getStorge.read("InstanceST");

    try {
      final response = await http.post(
        linkLogin,
        headers: {
          'Accept': 'application/json, text/javascript, */*; q=0.01',
          'Accept-Language': 'en,fr;q=0.9,fr-FR;q=0.8,en-GB;q=0.7,en-US;q=0.6',
          'Connection': 'keep-alive',
          'Content-Type': 'application/json; charset=UTF-8',
          'Cookie':
              '_ga=GA1.1.404841984.1647868640; visitor=7393425991312395164924237809598378---5f900337e317a7563398ae4f; _ga=GA1.1.989755541.1650373771; _syrPrefsGuid=cb41a5c1-d056-4cf0-b2e0-1d680d0f5ab4; Computer-CMAM=SYSTEM; _ga_9QBGJF7JY8=GS1.1.1681720611.1.0.1681720611.60.0.0; _ga_Q32DEL1X8Q=GS1.1.1681720611.8.0.1681720611.0.0.0; InstanceLGFO=CMAM=fr-FR; InstanceCI=CMAM=gDAbEevZiCSbMh_w8_kUyn4SzY_vlPwDsrrDsMVy; ErmesSearch_MUSIKA=%7B%22mainScenario%22%3A%22MUSIQUE%22%2C%22mainScenarioText%22%3A%22MUSIQUE%20CMAM%22%7D; _syrSessGuid$cookiza; InstanceST=$InstanceST; InstanceST=$InstanceST',
          'Origin': 'https://integ03-cmam.archimed.fr',
          'Referer': 'https://integ03-cmam.archimed.fr/MUSIKA/account.aspx',
        },
        body: body,
      );
      print(response);

      if (response.statusCode == 200) {
        var _apirespond = jsonDecode(response.body) as Map<String, dynamic>;

        Map<String, dynamic> search = _apirespond["d"] as Map<String, dynamic>;

        if (search != null) {
          List<Label> rslt1 = <Label>[];

          List<dynamic> rslt = [];

          List<dynamic> Results = search['UserLabels'];
          print(Results);

          for (dynamic i in Results) {
            rslt.add(i);
            print(i);

            Label lib = new Label(
                culture: i["Culture"],
                displayLabel: i["DisplayLabel"].toString(),
                isSystem: i["IsSystem"],
                labelUid: i["LabelUid"],
                site: i["Site"],
                whenAdded: i["WhenAdded"].toString());

            rslt1.add(lib);
            print(rslt1);
          }

          return rslt1;
        }
      }
    } catch (e) {
      print(e);
    }
  }

/*  Future<List<Result>> loadPanier() async {
    String body =
        '{"query":{"ResultSize":10,"Page":0,"SearchInput":"","LabelFilter":[]}}';

    Uri linkLogin = Uri(
      scheme: 'https',
      host: 'integ03-cmam.archimed.fr',
      path: 'MUSIKA/Portal/Recherche/search.svc/SearchUserBasket',
    );

    List<Result> rslt1 = <Result>[];

    var cookiza = getStorge.read("syrSessGuid");

    var InstanceST = getStorge.read("InstanceST");

    try {
      final response = await http.post(
        linkLogin,
        headers: {
          'Accept': 'application/json, text/javascript, */ /*; q=0.01',
          'Accept-Language': 'en,fr;q=0.9,fr-FR;q=0.8,en-GB;q=0.7,en-US;q=0.6',
          'Connection': 'keep-alive',
          'Content-Type': 'application/json; charset=UTF-8',
          'Cookie':
              '_ga=GA1.1.404841984.1647868640; visitor=7393425991312395164924237809598378---5f900337e317a7563398ae4f; _ga=GA1.1.989755541.1650373771; _syrPrefsGuid=cb41a5c1-d056-4cf0-b2e0-1d680d0f5ab4; Computer-CMAM=SYSTEM; _ga_9QBGJF7JY8=GS1.1.1681720611.1.0.1681720611.60.0.0; _ga_Q32DEL1X8Q=GS1.1.1681720611.8.0.1681720611.0.0.0; InstanceLGFO=CMAM=fr-FR; InstanceCI=CMAM=gDAbEevZiCSbMh_w8_kUyn4SzY_vlPwDsrrDsMVy; ErmesSearch_MUSIKA=%7B%22mainScenario%22%3A%22MUSIQUE%22%2C%22mainScenarioText%22%3A%22MUSIQUE%20CMAM%22%7D; _syrSessGuid$cookiza; InstanceST=$InstanceST; InstanceST=$InstanceST',
          'Origin': 'https://integ03-cmam.archimed.fr',
          'Referer': 'https://integ03-cmam.archimed.fr/MUSIKA/account.aspx',
        },
        body: body,
      );

      if (response.statusCode == 200) {
        var _apirespond = jsonDecode(response.body) as Map<String, dynamic>;

        Map<String, dynamic> search = _apirespond["d"] as Map<String, dynamic>;

        if (search != null) {
          List<Label> rslt1 = <Label>[];

          List<dynamic> rslt = [];

          List<dynamic> Results = search['UserLabels'];
          print(Results);

          for (dynamic i in Results) {
            rslt.add(i);
            print(i);

            Label lib = new Label(
                culture: i["Culture"],
                displayLabel: i["DisplayLabel"].toString(),
                isSystem: i["IsSystem"],
                labelUid: i["LabelUid"],
                site: i["Site"],
                whenAdded: i["WhenAdded"].toString());

            rslt1.add(lib);
            print(rslt1);
          }

          return rslt1;
        }
      }
    } catch (e) {
      print(e);
    }

    return rslt1;
  }
*/
  Future<void> getCookies() async {
    var headers = {
      'authority': 'integ03-cmam.archimed.fr',
      'accept': 'application/json, text/javascript, */*; q=0.01',
      'accept-language': 'fr-FR,fr;q=0.9,en-US;q=0.8,en;q=0.7',
      'content-type': 'application/json; charset=UTF-8',
      'cookie': getStorge.read("cookie"),
      'origin': 'https://integ03-cmam.archimed.fr',
      'referer': 'https://integ03-cmam.archimed.fr/musika/account.aspx',
      'sec-ch-ua':
          '"Google Chrome";v="113", "Chromium";v="113", "Not-A.Brand";v="24"',
      'sec-ch-ua-mobile': '?0',
      'sec-ch-ua-platform': '"Windows"',
      'sec-fetch-dest': 'empty',
      'sec-fetch-mode': 'cors',
      'sec-fetch-site': 'same-origin',
      'user-agent':
          'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/113.0.0.0 Safari/537.36',
      'x-requested-with': 'XMLHttpRequest'
    };
    print(headers);
    String body =
        '{"query":{"ResultSize":10,"Page":0,"SearchInput":"","LabelFilter":[]}}';

    // "https://integ03-cmam.archimed.fr/MUSIKA/Portal/Recherche/Search.svc/SearchUserBasket"
    var response = await http.post(
      Uri.parse(
          'https://integ03-cmam.archimed.fr/MUSIKA/Portal/Recherche/Search.svc/SearchUserBasket'),
      body: body,
    );

    if (response.statusCode == 200) {
      var headers = response.headers;
      print(headers);
      var responseBody = response.body;

      // Access specific headers
      var contentType = headers['content-type'];
      var authorization = headers['authorization'];

      // Print headers
      headers.forEach((key, value) {
        print('$key: $value');
      });

      // Access response body
      var apiResponse = jsonDecode(responseBody);
      print(apiResponse['d']);

      // Rest of your code...
    } else {
      print('Login failed with status code: ${response.statusCode}');
    }
  }

  // Fetch the items from the database and update the RxList
  Future<void> fetchItems() async {
    items.value = await fetchSongs();
  }

  // Delete an item from the database and update the RxList
  Future<void> deleteItem(String itemId) async {
    await deleteSong(itemId);
    await fetchItems();
  }

  Future<int> deleteSong(String RscUid) async {
    //returns number of items deleted
    final db = await MemoDbProvider().init();

    int result = await db.delete("SongsF", //table name
        where: "RscUid = ?",
        whereArgs: [RscUid] // use whereArgs to avoid SQL injection
        );

    return result;
  }

  /*Recently */

  Future<void> deleteItems() async {
    await deleteAllSongs();
    await fRecent();
  }

  Future<void> fetchItemR() async {
    itemsR.value = await fRecent();
    hasItems.value = itemsR.value.isNotEmpty;
  }

  Future<List<SongModel>> fetchSongs() async {
    //returns the Songs as a list (array)

    final db = await MemoDbProvider().init();
    ;
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

/*Recently */
  Future<RxList<SongModel>> fRecent() async {
    final db = await MemoDbProvider().init();
    final maps = await db.query("RecentlyPlayed");

    return RxList.generate(maps.length, (i) {
      return SongModel(
        RscUid: maps[i]['RscUid'] as String,
        ThumbSmall: maps[i]['ThumbSmall'] as String,
        Id: maps[i]['Id'] as String,
        Crtr: maps[i]['Crtr'] as String,
        Lien: maps[i]['Lien'] as String,
      );
    });
  }

  /*Recently */

  Future<List<SongModel>> fetchSongsR() async {
    //returns the Songs as a list (array)

    final db = await MemoDbProvider().init();
    ;
    final maps = await db.query(
        "RecentlyPlayed"); //query all the rows in a table as an array of maps

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

  /*Recently */

  Future<int> deleteAllSongs() async {
    final db = await MemoDbProvider().init();

    int result = await db.delete(
        "RecentlyPlayed"); // Supprimer tous les enregistrements de la table

    return result;
  }

  /*partie Artiste  */

  Future<List<ArtisteModel>> fetchArtiste() async {
    //returns the Songs as a list (array)

    final db = await MemoDbProvider().init();
    ;
    final maps = await db
        .query("ArtisteF"); //query all the rows in a table as an array of maps

    return List.generate(maps.length, (i) {
      //create a list of Songs
      return ArtisteModel(
        RscUid: maps[i]['RscUid'] as String,
        Id: maps[i]['Id'] as String,
        ttl: maps[i]['ttl'] as String,
        ThumbSmall: maps[i]['ThumbSmall'] as String,
      );
    });
  }

  Future<int> deleteArtiste(String RscUid) async {
    //returns number of items deleted
    final db = await MemoDbProvider().init();

    int result = await db.delete("ArtisteF", //table name
        where: "RscUid = ?",
        whereArgs: [RscUid] // use whereArgs to avoid SQL injection
        );

    return result;
  }

  Future<void> fetchItemsA() async {
    itemsArtiste.value = await fetchArtiste();
  }

  // Delete an item from the database and update the RxList
  Future<void> deleteItema(String itemId) async {
    await deleteArtiste(itemId);
    await fetchItemsA();
  }

  /*partie Album */

  Future<List<AlbumModel>> fetchAlbum() async {
    //returns the Songs as a list (array)

    final db = await MemoDbProvider().init();

    final maps = await db
        .query("AlbumF"); //query all the rows in a table as an array of maps

    return List.generate(maps.length, (i) {
      //create a list of Songs
      return AlbumModel(
        RscUid: maps[i]['RscUid'] as String,
        thumbSmall: maps[i]['thumbSmall'] as String,
        ttl: maps[i]['ttl'] as String,
        Id: maps[i]['Id'] as String,
      );
    });
  }

  Future<int> deleteAlbum(String RscUid) async {
    //returns number of items deleted
    final db = await MemoDbProvider().init();

    int result = await db.delete("AlbumF", //table name
        where: "RscUid = ?",
        whereArgs: [RscUid] // use whereArgs to avoid SQL injection
        );

    return result;
  }

  Future<void> fetchItemsAB() async {
    itemsAlbum.value = await fetchAlbum();
  }

  // Delete an item from the database and update the RxList
  Future<void> deleteItemab(String itemId) async {
    await deleteAlbum(itemId);
    await fetchItemsAB();
  }
}
