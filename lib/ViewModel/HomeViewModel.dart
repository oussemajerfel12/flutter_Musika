import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:musika/Model/AlbumModel.dart';
import 'package:musika/Model/ArtisteModel.dart';
import 'package:musika/ViewModel/ProfilViewModel.dart';

import '../Model/CheckAvailabilityOptions.dart';

import '../Model/SearchOptions.dart';
import '../Model/SearchResult.dart';

import '../Model/SongModel.dart';
import '../Provider/dbprovider.dart';
import '../routes/app_page.dart';
import '../Service/IRequestService.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomeViewModel extends GetxController
    with GetSingleTickerProviderStateMixin {
  RxInt selectedIndex = 0.obs;

  late IRequestService requestService;
  final getStorge = GetStorage();
  final List<String> rslt = [];
  var isdark = ProfilViewModel().isdark;
  RxBool Miniplayer = false.obs;

  var ListTile = "";

  var _pageArtist = 0.obs;
  var _page = 0.obs;
  // Getter for page
  int get page => _page.value;
  var rtl = false.obs; // Setter for page
  set page(int value) => _page.value = value;
  // Getter for page Artist
  int get pageArtist => _pageArtist.value;
// Setter for page Artist
  set pageArtist(int value) => _pageArtist.value = value;

  @override
  void onInit() {
    super.onInit();

    if (getStorge.read("isDarkMode") == null) {
      isdark = true.obs;
      getStorge.write('isDarkMode', isdark.value);
    } else {
      isdark = getStorge.read("isDarkMode");
    }

    if (getStorge.read('locale') == null) {
      getStorge.write('locale', 'en_US');
      Get.updateLocale(Locale('en_US'));
    }

    //ListTile = getStorge.read("ListTitle");
  }

  void updateSelectedIndex(int index) {
    selectedIndex.value = index;
  }

  @override
  void onReady() {
    super.onReady();
    if (getStorge.read("isDarkMode") == null) {
      isdark.value = getStorge.read("isDarkMode");
    } else {
      isdark = true.obs;
    }
    update();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void reload() {
    super.onReady();
  }

  Future<List<Result>?> loadPageArtist() async {
    String body =
        '{"query":{"ForceSearch":true,"InitialSearch":true,"Page":0,"PageRange":3,"QueryGuid":"","QueryString":"*:*","InjectFields":true,"ResultSize":-1,"ScenarioCode":"AUTHORITY","ScenarioDisplayMode":"","SearchContext":0,"SearchTerms":"","SortField":null}}';

    try {
      final response = await http.post(
        Uri.parse(
            'https://integ03-cmam.archimed.fr/PNT/Portal/Recherche/search.svc/Search'),
        headers: {"Content-Type": "application/json"},
        body: body,
      );

      //print(Response.);
      if (response.statusCode == 200) {
        var _apirespond = jsonDecode(response.body) as Map<String, dynamic>;

        Map<String, dynamic> search = _apirespond["d"] as Map<String, dynamic>;
        //print(search.containsKey('Results'));
        if (search != null) {
          List<Result> rslt1 = <Result>[];

          List<dynamic> rslt = [];

          List<dynamic> Results = search['Results'];

          PrimaryDoc pr = PrimaryDoc();

          for (dynamic i in Results) {
            Result result = new Result();
            Resource Res = new Resource();
            FieldList fi = new FieldList();
            rslt.add(i);
            fi.thumbSmall = i["FieldList"]["ThumbSmall"][0];
            fi.thumbLarge = i["FieldList"]["ThumbLarge"][0];
            Res.rscUid = i["Resource"]["RscUid"];
            Res.rscId = i["Resource"]["RscId"];
            Res.ttl = i["Resource"]["Ttl"];
            Res.id = i["Resource"]["Id"];
            Res.type = i["Resource"]["Type"];
            result.resource = Res;
            result.friendlyUrl = i["FriendlyUrl"];

            result.fieldList = fi;

            rslt1.add(result);
          }

          return rslt1;
        }
      }
    } catch (e) {
      print(e);
    }
    return [];
  }

  Result insertin(SongModel s) {
    final Result temp = Result();
    temp.fieldList = FieldList(thumbSmall: s.ThumbSmall.toString());
    temp.resource = Resource(crtr: s.Crtr.toString(), id: s.Id.toString());

    temp.primaryDocs = PrimaryDoc(link: s.Lien.toString());

    return temp;
  }

  Result insertinAB(AlbumModel A) {
    final Result temp = Result();
    temp.fieldList = FieldList(thumbSmall: A.thumbSmall.toString());
    temp.resource = Resource(ttl: A.ttl.toString(), id: A.Id.toString());

    return temp;
  }

  Result insertinAT(ArtisteModel A) {
    final Result temp = Result();
    temp.fieldList = FieldList(thumbSmall: A.ThumbSmall.toString());
    temp.resource = Resource(ttl: A.ttl.toString(), id: A.Id.toString());

    return temp;
  }

  Future<List<Result>?> loadHot() async {
    String body = '{"query":{"FacetFilter" :"{\\"'
        '_74\\"'
        ':\\"'
        'Nouveauté\\"'
        '}","ForceSearch":true,"InitialSearch":false,"Page":0,"PageRange":3,"QueryString":"*","ResultSize":-1,"ScenarioCode":"CATALOGUE","ScenarioDisplayMode":"","SearchContext":0,"SearchTerms":"","SortField":null,"InjectFields":true,"SearchLabel":""}}';

    try {
      final response = await http.post(
        Uri.parse(
            'https://integ03-cmam.archimed.fr/PNT/Portal/Recherche/search.svc/Search'),
        headers: {"Content-Type": "application/json"},
        body: body,
      );

      //print(Response.);
      if (response.statusCode == 200) {
        var _apirespond = jsonDecode(response.body) as Map<String, dynamic>;

        Map<String, dynamic> search = _apirespond["d"] as Map<String, dynamic>;

        List<Result> rslt1 = <Result>[];

        List<dynamic> rslt = [];

        List<dynamic> Results = search['Results'];

        for (dynamic i in Results) {
          Result result = new Result();
          Resource Res = new Resource();
          FieldList fi = new FieldList();
          if (i["PrimaryDocs"] != null &&
              i["PrimaryDocs"] is List<dynamic> &&
              i["PrimaryDocs"].isNotEmpty) {
            dynamic primaryDoc = i["PrimaryDocs"][0];
            if (primaryDoc["Link"] != null) {
              PrimaryDoc pr = new PrimaryDoc();
              pr.link = primaryDoc["Link"];
              result.primaryDocs = pr;
            }
          }
          fi.thumbSmall = i["FieldList"]["ThumbSmall"][0];
          rslt.add(i);
          String str = i["Resource"]["Crtr"];
          str = str
              .trim()
              .replaceAll(RegExp(r'[0-9\p{P}\p{S}]+', unicode: true), '');
          if (str.contains("مؤدية")) {
            str = str.trim().replaceAll("مؤدية", "");
          } else if (str.contains("مؤدي")) {
            str = str.trim().replaceAll("مؤدي", "");
          }
          str = str.trim().replaceAll(RegExp(r'\s+'), ' ');
          if (str.length > 2) {
            List<String> words = str
                .split(' '); // Split string into words using space as separator
            if (words.length >= 2) {
              // Check if there are at least two words in the string
              String temp =
                  words[0]; // Store first word in a temporary variable
              words[0] = words[1]; // Replace first word with second word
              words[1] =
                  temp; // Replace second word with first word from the temporary variable
              str = words.join(
                  ' '); // Join the words back together with a space separator
            }
          }

          Res.rscUid = i["Resource"]["RscUid"];
          Res.type = i["Resource"]["Type"];
          Res.crtr = str;
          String Title = i["Resource"]["Id"];
          if (Title.contains("title:")) {
            Res.id = Title.replaceAll("title:", "");
          }
          result.resource = Res;
          result.fieldList = fi;

          rslt1.add(result);
        }

        return rslt1;
      }
    } catch (e) {
      print(e);
    }
    return [];
  }

  Future<RxList<SongModel>> fRecent() async {
    final db = await MemoDbProvider().init();
    final maps = await db.query("RecentlyPlayed");

    final reversedMaps =
        maps.reversed.toList(); // Reverse the order of the maps

    return RxList.generate(reversedMaps.length, (i) {
      return SongModel(
        RscUid: reversedMaps[i]['RscUid'] as String,
        ThumbSmall: reversedMaps[i]['ThumbSmall'] as String,
        Id: reversedMaps[i]['Id'] as String,
        Crtr: reversedMaps[i]['Crtr'] as String,
        Lien: reversedMaps[i]['Lien'] as String,
      );
    });
  }

  Future<List<Result>?> loadpageResult() async {
    List<Result> rslt_titre = <Result>[];
    SearchOptionsDetails option = SearchOptionsDetails(
      InjectFields: true,
      ScenarioCode: "CATALOGUE",
      ResultSize: 25,
      Page: page,
      SortField: "",
      QueryString: "*:*",
      FacetFilter: "{\"_64\":\"Titre\"}",
    );

    SearchOptions options = SearchOptions(haveQuery: "True", query: option);

    try {
      final response = await http.post(
        Uri.parse(
            'https://integ03-cmam.archimed.fr/PNT/Portal/Recherche/search.svc/Search'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(options),
      );

      if (response.statusCode == 200) {
        var _apirespond = jsonDecode(response.body) as Map<String, dynamic>;

        Map<String, dynamic> search = _apirespond["d"] as Map<String, dynamic>;
        //print(search.containsKey('Results'));
        if (search != null) {
          List<dynamic> rslt = [];

          List<dynamic> Results = search['Results'];

          for (dynamic i in Results) {
            rslt.add(i);
            Result result = new Result();
            Resource Res = new Resource();
            FieldList fi = new FieldList();
            if (i["PrimaryDocs"] != null &&
                i["PrimaryDocs"] is List<dynamic> &&
                i["PrimaryDocs"].isNotEmpty) {
              dynamic primaryDoc = i["PrimaryDocs"][0];
              if (primaryDoc["Link"] != null) {
                PrimaryDoc pr = new PrimaryDoc();
                pr.link = primaryDoc["Link"];
                result.primaryDocs = pr;
              }
            }

            fi.thumbSmall = i["FieldList"]["ThumbSmall"][0];
            String str = i["Resource"]["Crtr"];
            str = str
                .trim()
                .replaceAll(RegExp(r'[0-9\p{P}\p{S}]+', unicode: true), '');
            if (str.contains("مؤدية")) {
              str = str.trim().replaceAll("مؤدية", "");
            } else if (str.contains("مؤدي")) {
              str = str.trim().replaceAll("مؤدي", "");
            }
            str = str.trim().replaceAll(RegExp(r'\s+'), ' ');
            if (str.length > 2) {
              List<String> words = str.split(
                  ' '); // Split string into words using space as separator
              if (words.length >= 2) {
                // Check if there are at least two words in the string
                String temp =
                    words[0]; // Store first word in a temporary variable
                words[0] = words[1]; // Replace first word with second word
                words[1] =
                    temp; // Replace second word with first word from the temporary variable
                str = words.join(
                    ' '); // Join the words back together with a space separator
              }
            }

            Res.rscUid = i["Resource"]["RscUid"];
            Res.type = i["Resource"]["Type"];
            Res.crtr = str;
            String Title = i["Resource"]["Id"];
            if (Title.contains("title:")) {
              Res.id = Title.replaceAll("title:", "");
            }
            result.resource = Res;
            result.fieldList = fi;

            rslt_titre.add(result);
          }

          return rslt_titre;
        }
      }
    } catch (e) {
      print(e);
    }

    return [];
  }

  Future<List<Result>?> loadMoreArtist(int pageArtist) async {
    String pagestr = pageArtist.toString();
    String body =
        '{"query":{"ForceSearch":true,"InitialSearch":true,"Page":$pagestr,"PageRange":3,"QueryGuid":"","QueryString":"*:*","ResultSize":-1,"ScenarioCode":"AUTHORITY","ScenarioDisplayMode":"","SearchContext":0,"SearchTerms":"","InjectFields":true,"SortField":null}}';

    try {
      final response = await http.post(
        Uri.parse(
            'https://integ03-cmam.archimed.fr/PNT/Portal/Recherche/search.svc/Search'),
        headers: {"Content-Type": "application/json"},
        body: body,
      );

      //print(Response.);
      if (response.statusCode == 200) {
        var _apirespond = jsonDecode(response.body) as Map<String, dynamic>;

        Map<String, dynamic> search = _apirespond["d"] as Map<String, dynamic>;
        //print(search.containsKey('Results'));
        if (search != null) {
          List<Result> rslt1 = <Result>[];

          List<dynamic> rslt = [];

          List<dynamic> Results = search['Results'];

          PrimaryDoc pr = PrimaryDoc();

          for (dynamic i in Results) {
            Result result = new Result();
            Resource Res = new Resource();
            FieldList fi = new FieldList();
            rslt.add(i);

            fi.thumbSmall = i["FieldList"]["ThumbSmall"][0];

            Res.rscUid = i["Resource"]["RscUid"];
            Res.ttl = i["Resource"]["Ttl"];
            Res.id = i["Resource"]["Id"];
            Res.type = i["Resource"]["Type"];

            result.resource = Res;
            result.friendlyUrl = i["FriendlyUrl"];
            //result.primaryDocs = pr;
            result.fieldList = fi;

            rslt1.add(result);
          }

          return rslt1;
        }
      }
    } catch (e) {
      print(e);
    }
    return [];
  }

  Future<List<Result>?> loadMoreTitle(int page) async {
    List<Result> rslt1 = <Result>[];

    // FacetFilter: "{\\'_64\\':\\'Titre\\'}",

    SearchOptionsDetails option = SearchOptionsDetails(
      ScenarioCode: "CATALOGUE",
      ResultSize: 10,
      Page: page,
      SortField: "DateStart_sort",
      QueryString: "*:*",
      FacetFilter: "{\"_64\":\"Titre\"}",
      InjectFields: true,
    );
//jsonEncode(options)
    SearchOptions options = SearchOptions(haveQuery: "True", query: option);

    try {
      final response = await http.post(
          Uri.parse(
              'https://integ03-cmam.archimed.fr/PNT/Portal/Recherche/search.svc/Search'),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(options));

      if (response.statusCode == 200) {
        var _apirespond = jsonDecode(response.body) as Map<String, dynamic>;

        Map<String, dynamic> search = _apirespond["d"] as Map<String, dynamic>;
        if (search != null) {
          List<dynamic> rslt = [];

          List<dynamic> Results = search['Results'];

          for (dynamic i in Results) {
            rslt.add(i);
            Result result = new Result();
            Resource Res = new Resource();
            FieldList fi = new FieldList();
            if (i["PrimaryDocs"] != null &&
                i["PrimaryDocs"] is List<dynamic> &&
                i["PrimaryDocs"].isNotEmpty) {
              dynamic primaryDoc = i["PrimaryDocs"][0];
              if (primaryDoc["Link"] != null) {
                PrimaryDoc pr = new PrimaryDoc();
                pr.link = primaryDoc["Link"];
                result.primaryDocs = pr;
              }
            }

            fi.thumbSmall = i["FieldList"]["ThumbSmall"][0];

            String str = i["Resource"]["Crtr"];
            str = str
                .trim()
                .replaceAll(RegExp(r'[0-9\p{P}\p{S}]+', unicode: true), '');
            /*if (str.contains("مؤدية")) {
              str = str.trim().replaceAll("مؤدية", "");
            } else if (str.contains("مؤدي")) {
              str = str.trim().replaceAll("مؤدي", "");
            }
            */
            str = str.trim().replaceAll(RegExp(r'\s+'), ' ');
            if (str.length > 2) {
              List<String> words = str.split(
                  ' '); // Split string into words using space as separator
              if (words.length >= 2) {
                // Check if there are at least two words in the string
                String temp =
                    words[0]; // Store first word in a temporary variable
                words[0] = words[1]; // Replace first word with second word
                words[1] =
                    temp; // Replace second word with first word from the temporary variable
                str = words.join(
                    ' '); // Join the words back together with a space separator
              }
            }
            Res.type = i["Resource"]["Type"];

            Res.rscUid = i["Resource"]["RscUid"];
            Res.crtr = str;
            String Title = i["Resource"]["Id"];
            if (Title.contains("title:")) {
              Res.id = Title.replaceAll("title:", "");
            }
            result.resource = Res;
            result.fieldList = fi;

            rslt1.add(result);
          }

          return rslt1;
        }
      }
    } catch (e) {
      print(e);
    }
    return [];
  }

// you might Like That function
  Future<List<Result>?> likethat() async {
    final List<String> items1 = [
      '{\\"'
          '_69\\"'
          ':\\"'
          'مزود\\"'
          '}',
      '{\\"'
          '_69\\"'
          ':\\"'
          'مالوف\\"'
          '}',
      '{\\"'
          '_69\\"'
          ':\\"'
          'موسيقى صوفية/دينية\\"'
          '}',
      '{\\"'
          '_68\\"'
          ':\\"'
          'موسيقى مغاربية\\"'
          '}',
      '{\\"'
          '_68\\"'
          ':\\"'
          'موسيقى مصرية\\"'
          '}',
    ];

    List<Result> rslt1 = <Result>[];
    List<Result> rsltfinal = <Result>[];

    for (var item in items1) {
      String body =
          '{"query":{"FacetFilter" :"$item","ForceSearch":true,"InitialSearch":false,"Page":0,"PageRange":3,"QueryString":"*","ResultSize":-1,"ScenarioCode":"CATALOGUE","ScenarioDisplayMode":"","SearchContext":0,"SearchTerms":"","SortField":null,"InjectFields":true,"SearchLabel":""}}';

      final response = await http.post(
          Uri.parse(
              'https://integ03-cmam.archimed.fr/PNT/Portal/Recherche/search.svc/Search'),
          headers: {"Content-Type": "application/json"},
          body: body);

      if (response.statusCode == 200) {
        var _apirespond = jsonDecode(response.body) as Map<String, dynamic>;

        Map<String, dynamic> search = _apirespond["d"] as Map<String, dynamic>;
        if (search != null) {
          List<dynamic> rslt = [];

          List<dynamic> Results = search['Results'];

          for (dynamic i in Results) {
            rslt.add(i);
            Result result = new Result();
            Resource Res = new Resource();
            FieldList fi = new FieldList();
            PrimaryDoc pr = PrimaryDoc();

            fi.thumbSmall = i["FieldList"]["ThumbSmall"][0];
            pr.link = i["PrimaryDocs"][0]["Link"];
            String str = i["Resource"]["Crtr"];
            str = str
                .trim()
                .replaceAll(RegExp(r'[0-9\p{P}\p{S}]+', unicode: true), '');
            /*if (str.contains("مؤدية")) {
              str = str.trim().replaceAll("مؤدية", "");
            } else if (str.contains("مؤدي")) {
              str = str.trim().replaceAll("مؤدي", "");
            }
            */
            str = str.trim().replaceAll(RegExp(r'\s+'), ' ');
            if (str.length > 2) {
              List<String> words = str.split(
                  ' '); // Split string into words using space as separator
              if (words.length >= 2) {
                // Check if there are at least two words in the string
                String temp =
                    words[0]; // Store first word in a temporary variable
                words[0] = words[1]; // Replace first word with second word
                words[1] =
                    temp; // Replace second word with first word from the temporary variable
                str = words.join(
                    ' '); // Join the words back together with a space separator
              }
            }
            Res.type = i["Resource"]["Type"];

            Res.rscUid = i["Resource"]["RscUid"];
            Res.crtr = str;
            String Title = i["Resource"]["Id"];
            if (Title.contains("title:")) {
              Res.id = Title.replaceAll("title:", "");
            }
            result.resource = Res;
            result.fieldList = fi;
            result.primaryDocs = pr;

            rslt1.add(result);
          }
        }
        if (rslt1.isNotEmpty) {
          Random random = Random();
          int randomIndex = random.nextInt(rslt1.length);
          Result randomResult = rslt1[randomIndex];
          rsltfinal.add(randomResult);
          rslt1.clear();
        }
      }
    }
    return rsltfinal;
  }

  logout() {
    getStorge.erase();
    Get.offAllNamed(Routes.LOGIN);
  }

  Go_Profil() {
    Routes.PROFIL;
  }
}
