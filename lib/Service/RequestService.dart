import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:musika/Model/CheckAvailabilityResult.dart';

import 'package:musika/Model/CheckAvailabilityOptions.dart';

import '../Model/LoginStauts.dart';
import '../Model/SearchResult.dart';
import '../Model/SearchOptions.dart';
import '../Service/IRequestService.dart';
import 'package:http/http.dart ' as http;

class RequestService extends IRequestService {
  final getStorge = GetStorage();
  @override
  Future<SearchResult> Search(SearchOptions options) async {
    SearchResult status = SearchResult();
    //if (options.query!.scenarioCode == '') {}
    status = Search(options) as SearchResult;
    return status;
  }

  @override
  Future<CheckAvailabilityResult> CheckAvailability(
      CheckAvailabilityOptions options) async {
    CheckAvailabilityResult status = CheckAvailabilityResult(
        errors: null, message: null, success: null, D: null);
    status = CheckAvailability(options) as CheckAvailabilityResult;
    return status;
  }

  @override
  Future<LoginStatus> authentication(
      String userAccount, String password, Uri baseUrl,
      {Function(Exception)? error}) async {
    LoginStatus status =
        LoginStatus(errors: [], message: null, success: false, d: "");

    try {
      Map<String, Object> requestBody = {
        'username': userAccount,
        'password': password,
      };

      http.Response response = await http.post(
        baseUrl,
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: Uri(queryParameters: requestBody).query,
      );

      String cookiestring = response.headers['set-cookie'].toString();

      List<String> cookieParts = cookiestring.split(';');

      List<String> cookieParts1 = cookiestring.split(',');

      String? syrSessGuid;

      String? InstanceST;

      for (String part in cookieParts) {
        if (part.trim().startsWith('_syrSessGuid=')) {
          syrSessGuid = part.trim().substring("_syrSessGuid".length);
        }
      }

      for (String part in cookieParts1) {
        if (part.trim().startsWith('InstanceST=')) {
          InstanceST =
              part.trim().substring('InstanceST='.length).split(";")[0].trim();

          break;
        }
      }

      getStorge.write("syrSessGuid", syrSessGuid);

      getStorge.write("InstanceST", InstanceST);

      getStorge.read('InstanceST');

      getStorge.read('syrSessGuid');

      var responseData = jsonDecode(response.body);

      bool success = responseData['success'];

      if (success) {
        status.d = responseData["d"];

        status.success = responseData["success"];

        status = responseData;

        var stat = LoginStatus(
            errors: responseData["error"],
            success: success,
            d: responseData["d"]);

        return stat;
      } else {
        print('Request failed with Body: ${response.body}.');
      }
    } catch (ex) {
      if (error != null) {
        print(ex);
      }
    }

    return status;
  }
}
