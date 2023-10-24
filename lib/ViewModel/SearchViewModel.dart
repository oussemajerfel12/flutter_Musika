import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:musika/ViewModel/ProfilViewModel.dart';

import '../Model/CheckAvailabilityOptions.dart';

import '../Model/SearchOptions.dart';
import '../Model/SearchResult.dart';

import '../routes/app_page.dart';
import '../Service/IRequestService.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SearchViewModel extends GetxController {
  final getStorge = GetStorage();
  var _page = 0.obs;
  // Getter for page
  int get page => _page.value;

// Setter for page
  set page(int value) => _page.value = value;

  Future<List<Result>?> searchMusic(int page, String value) async {
    List<Result> rslt1 = <Result>[];
    String pagestr = page.toString();
    String body =
        '{"query":{"FacetFilter" :"{}","Page":$pagestr,"PageRange":"3","QueryString":"$value","ResultSize":"10","ScenarioCode":"CATALOGUE","ScenarioDisplayMode":"","SearchContext":0,"InjectFields":true,"SearchLabel":""}}';
    try {
      final response = await http.post(
        Uri.parse(
            'http://197.10.242.135/MUSIKA/Portal/Recherche/Search.svc/Search'),
        headers: {"Content-Type": "application/json"},
        body: body,
      );

      print(response.body);
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
            Res.ttl = i["Resource"]["Ttl"];
            fi.thumbSmall = i["FieldList"]["ThumbSmall"][0];
            fi.identifier = i["FieldList"]["Identifier"][0];
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

            rslt1.add(result);
          }
          // getStorge.write('ListTitle', rslt1);

          return rslt1;
        }
      }
    } catch (e) {
      print(e);
    }
    return [];
  }

  Future<List<Result>?> Filter(String value) async {
    List<Result> rslt1 = <Result>[];

    value = '"' + value + '"';

    String body =
        '{"query":{"FacetFilter":$value,"Page":0,"PageRange":3,"QueryString":"*:*","ResultSize":"10","ScenarioCode":"CATALOGUE","ScenarioDisplayMode":"","SearchContext":0,"InjectFields":true,"SearchLabel":""}}';

    print(body);
    try {
      final response = await http.post(
        Uri.parse(
            'http://197.10.242.135/MUSIKA/Portal/Recherche/Search.svc/Search'),
        headers: {"Content-Type": "application/json"},
        body: body,
      );

      print(response.body);
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

            PrimaryDoc pr = new PrimaryDoc();

            pr.link = i["PrimaryDocs"][0]["Link"];
            fi.identifier = i["FieldList"]["Identifier"][0];

            //print(i["FieldList"]["ThumbSmall"][0]);

            //print(i["FieldList"]["ThumbSmall"][0]);

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
            Res.ttl = i["Resource"]["Ttl"];
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
          // getStorge.write('ListTitle', rslt1);

          return rslt1;
        }
      }
    } catch (e) {
      print(e);
    }
    return [];
  }
}
