import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../Model/SearchResult.dart';
import '../routes/app_page.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ArtisteViewModel extends GetxController {
  final getStorge = GetStorage();
  var name = "";
  var isdark;

  RxBool IsArtisteF = false.obs;
  RxBool IsShuffledF = false.obs;

  @override
  void onInit() {
    super.onInit();
    name = getStorge.read("name");
    if (getStorge.read("isDarkMode") == null) {
      isdark = getStorge.read("isDarkMode");
    } else {
      isdark = true.obs;
    }
    update();
  }

  void toggleTheme() {
    /*if (isdark.value == true) {
      isdark = false.obs;
    } else {
      isdark = true.obs;
    }*/
    isdark.value = !isdark.value;

    getStorge.write('isDarkMode', isdark.value);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  logout() {
    getStorge.erase();
    Get.offAllNamed(Routes.LOGIN);
  }

  Future<List<Result>?> album_Artist(String value) async {
    print(value);
    String body = '{"query":{{"FacetFilter" :"{\\"'
        '_65\\"'
        ':\\"'
        'Album\\"'
        '}","ForceSearch":true,"InitialSearch":false,"InjectFields":true,"Page":0,"PageRange":3,"QueryString":$value,"ResultSize":10,"ScenarioCode":"CATALOGUE","ScenarioDisplayMode":"display-vignet","SearchGridFieldsShownOnResultsDTO":[],"SearchLabel":"","SearchTerms":"التونسية لويزة","SortField":null,"SortOrder":0}}';

    try {
      final response = await http.post(
        Uri.parse(
            'http://197.10.242.135/MUSIKA/Portal/Recherche/Search.svc/Search'),
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

          for (dynamic i in Results) {
            Result result = new Result();
            Resource Res = new Resource();
            FieldList fi = new FieldList();
            rslt.add(i);

            Res.rscUid = i["Resource"]["RscUid"];
            Res.ttl = i["Resource"]["Ttl"];
            Res.id = i["Resource"]["Id"];
            Res.type = i["Resource"]["Type"];
            result.resource = Res;
            result.friendlyUrl = i["FriendlyUrl"];
            fi.thumbSmall = i["FieldList"]["ThumbSmall"][0];
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

  Future<List<Result>?> Artiste_Titre(String value) async {
    String body = '{"query":{"FacetFilter" :"{\\"'
        '_65\\"'
        ':\\"'
        'Titre\\"'
        '}","ForceSearch":true,"InitialSearch":true,"InjectFields":true,"Page":0,"PageRange":3,"QueryString": "$value","ResultSize":50,"ScenarioCode":"CATALOGUE","ScenarioDisplayMode":"display-vignet","SearchGridFieldsShownOnResultsDTO":[],"SearchTerms":"$value","SearchLabel":"","SortField":null,"SortOrder":0}}';
    print(body);
    try {
      final response = await http.post(
        Uri.parse(
            'http://197.10.242.135/MUSIKA/Portal/Recherche/Search.svc/Search'),
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
            PrimaryDoc pr = PrimaryDoc();

            rslt.add(i);
            String Title = i["Resource"]["Id"];
            if (Title.contains("title:")) {
              Res.id = Title.replaceAll("title:", "");
            }
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
            Res.crtr = str;
            Res.rscUid = i["Resource"]["RscUid"];
            Res.ttl = i["Resource"]["Ttl"];
            Res.type = i["Resource"]["Type"];

            result.resource = Res;
            result.friendlyUrl = i["FriendlyUrl"];
            fi.thumbSmall = i["FieldList"]["ThumbSmall"][0];
            pr.link = i["PrimaryDocs"][0]["Link"];
            result.fieldList = fi;

            result.primaryDocs = pr;

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

  Future<List<Result>?> Artiste_Album(String value) async {
    print(value);
    String body = '{"query":{"FacetFilter" :"{\\"'
        '_65\\"'
        ':\\"'
        'Album\\"'
        '}","ForceSearch":true,"InitialSearch":true,"InjectFields":true,"Page":0,"PageRange":3,"QueryString": "$value","ResultSize":10,"ScenarioCode":"CATALOGUE","ScenarioDisplayMode":"display-vignet","SearchGridFieldsShownOnResultsDTO":[],"SearchTerms":"$value","SearchLabel":"","SortField":null,"SortOrder":0}}';
    print(body);
    try {
      final response = await http.post(
        Uri.parse(
            'http://197.10.242.135/MUSIKA/Portal/Recherche/Search.svc/Search'),
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
            String Title = i["Resource"]["Id"];
            if (Title.contains("title:")) {
              Res.id = Title.replaceAll("title:", "");
            }
            Res.rscUid = i["Resource"]["RscUid"];
            Res.ttl = i["Resource"]["Ttl"];
            Res.type = i["Resource"]["Type"];

            result.resource = Res;
            result.friendlyUrl = i["FriendlyUrl"];
            fi.thumbSmall = i["FieldList"]["ThumbSmall"][0];
            fi.identifier = i["FieldList"]["Identifier"][0];
            result.fieldList = fi;

            //result.primaryDocs = pr;

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
}
