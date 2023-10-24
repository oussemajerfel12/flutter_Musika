import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../Model/SearchResult.dart';
import '../routes/app_page.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AlbumViewModel extends GetxController {
  final getStorge = GetStorage();
  var name = "";
  var isdark;

  RxBool IsAlbumF = false.obs;
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

  Future<List<Result>?> Artiste_Titre(String value) async {
    print(value);
    String body =
        '{"query":{"InitialSearch":true,"Page":0,"PageRange":3,"QueryString":"Parent_id_exact:\\"$value\\"","ResultSize":-1,"ScenarioCode":"DEFAULT","InjectFields":true,"SearchContext":0,"SearchLabel":"Recherche de documents"}}';

    try {
      final response = await http.post(
        Uri.parse(
            'http://197.10.242.135/PNT/Portal/Recherche/Search.svc/Search'),
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
            fi.identifier = i["FieldList"]["Identifier"][0];
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

  Future<List<Result>?> album_Artist(String value) async {
    String body = '{"query":{{"FacetFilter" :"{\\"'
        '_65\\"'
        ':\\"'
        'Album\\"'
        '}","ForceSearch":true,"InitialSearch":false,"InjectFields":true,"Page":0,"PageRange":3,"QueryString":"$value","ResultSize":10,"ScenarioCode":"CATALOGUE","ScenarioDisplayMode":"display-vignet","SearchGridFieldsShownOnResultsDTO":[],"SearchLabel":"","SearchTerms":"التونسية لويزة","SortField":null,"SortOrder":0}}';
    // print(body);
    try {
      final response = await http.post(
        Uri.parse(
            'http://197.10.242.135/PNT/Portal/Recherche/Search.svc/Search'),
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

            Res.rscUid = i["Resource"]["RscUid"];
            Res.ttl = i["Resource"]["Ttl"];
            Res.id = i["Resource"]["Id"];
            Res.type = i["Resource"]["Type"];
            result.resource = Res;
            result.friendlyUrl = i["FriendlyUrl"];
            fi.thumbSmall = i["FieldList"]["ThumbSmall"][0];
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
  }

/*"FacetFilter" :"{\\"'
        '_64\\"'
        ':\\"'
        'Album\\"'
        '}"*/
  Future<List<Result>?> album_Sugg(String value) async {
    String body =
        '{ "query": {"Id": "0","Index": 10,"NBResults": 70,"PageRange": 3,"InjectFields":true,"SearchQuery": {"CloudTerms": [],"FacetFilter" :"{\\"'
        '_65\\"'
        ':\\"'
        'Album\\"'
        '}","ForceSearch":true,"InitialSearch": false,"Page": 0,"PageRange": 3,"QueryString":"$value","ResultSize": 10,"ScenarioCode": "CATALOGUE","SearchTerms":""}}}';

    try {
      final response = await http.post(
        Uri.parse('http://197.10.242.135/PNT/Search.svc/GetRecord'),
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

          List<dynamic> Results = search['ReboundResults'];

          for (dynamic i in Results) {
            if (i.containsKey("Results") && i["Results"] is List<dynamic>) {
              List<dynamic> resultList = i["Results"];
              for (int index = 0; index < resultList.length; index++) {
                dynamic result1 = resultList[index];
                Result result = new Result();
                Resource Res = new Resource();

                Res.rscUid = result1["Resource"]["RscUid"];
                Res.ttl = result1["Resource"]["Ttl"];

                Res.type = result1["Resource"]["Type"];
                String Title = result1["Resource"]["Id"];
                if (Title.contains("title:")) {
                  Res.id = Title.replaceAll("title:", "");
                }
                result.friendlyUrl = result1["FriendlyUrl"];
                if (result1["FieldList"]["ThumbSmall"][0] != null) {
                  FieldList fi = new FieldList();
                  fi.thumbSmall = result1["FieldList"]["ThumbSmall"][0];
                  if (result1["FieldList"]["Identifier"][0] != null) {
                    fi.identifier = result1["FieldList"]["Identifier"][0];
                  }

                  result.fieldList = fi;
                }

                if (result1["PrimaryDocs"] != null &&
                    result1["PrimaryDocs"] is List<dynamic> &&
                    result1["PrimaryDocs"].isNotEmpty) {
                  dynamic primaryDoc = result1["PrimaryDocs"][0];
                  if (primaryDoc["Link"] != null) {
                    PrimaryDoc pr = new PrimaryDoc();
                    pr.link = primaryDoc["Link"];
                    result.primaryDocs = pr;
                  }
                }

                String str = result1["Resource"]["Crtr"];
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

                result.resource = Res;

                rslt1.add(result);

                // Vous pouvez accéder aux autres propriétés de chaque résultat ici
                // en utilisant la même structure que l'exemple ci-dessus.
              }
            }
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
            'http://197.10.242.135/PNT/Portal/Recherche/Search.svc/Search'),
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
