// ignore_for_file: deprecated_member_use, no_leading_underscores_for_local_identifiers, prefer_const_declarations

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Model/LoginStauts.dart';
import '../Service/IRequestService.dart';
import '../View/HomeView.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../Model/tokendec1.dart';
import '../routes/app_page.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import '../Model/tokendec.dart';
import 'package:crypto/crypto.dart';

class LoginViewModel extends GetxController {
  final getStorge = GetStorage();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  IRequestService requestService = GetIt.instance<IRequestService>();

  /*Future<void> loginSSO() async {
      final linki = Uri.parse(
          "http://197.10.242.135/eklectic/callback??&code=1b29e502-68e5-11ee-a9a6-fa163eef2e72&id_token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjMxODUzOTM3IiwibXNpc2RuIjoiNTEwNDA0NzEiLCJkYXRlX2RlYmZyZWUiOiIyMDIzLTA2LTE0IDEyOjM2OjA0IiwiZGF0ZV9maW5mcmVlIjoiMjAyMy0wNi0xNSAxMjozNjowNCIsInN1YnNjcmlwdGlvbl9kYXRlIjoiMjAyMy0wOC0yNSAxMToxODozNSIsInVuc3Vic2NyaXB0aW9uX2RhdGUiOiIyMDIzLTA4LTIzIDA4OjAyOjE1IiwiZmlyc3RfYnJvYWRjYXN0YmlsbGluZyI6IjIwMjMtMDYtMTcgMDA6MTI6NDEiLCJsYXN0X2Jyb2FkY2FzdGJpbGxpbmciOiIyMDIzLTEwLTEyIDAyOjUxOjUyIiwiZmlyc3Rfc3VjY2Vzc2JpbGxpbmciOm51bGwsImxhc3Rfc3VjY2Vzc2JpbGxpbmciOm51bGwsInN1Y2Nlc3NfYmlsbGluZyI6IjAiLCJzaW1jaHVybiI6IjciLCJkYXRlX3NpbWNodXJuIjoiMjAyMy0wOC0yMyAwODowMjoxNSIsImRhdGVfcmV2c2ltY2h1cm4iOm51bGwsImNyZWF0ZV9hdCI6IjIwMjMtMDYtMTQgMTI6MzY6MDQiLCJsYXN0X3N0YXR1c191cGRhdGUiOiIyMDIzLTA2LTE0IDEyOjM2OjA0Iiwic2VydmljZV9pZCI6IjU1Iiwib2ZmcmVfaWQiOiIxMTIiLCJzdGF0dXMiOiIxIiwiYWNxdWlzaXRpb24iOiIwIiwic3RhdGUiOiJJTkFDVElWRSIsImV4cGlyZV9kYXRlIjoiMjAyMy0wNi0xNVQxMjozNjowNCswMTowMCJ9.lHZGvIlgRwMn_3yIklEHpIKpJVoPz0xTfYEnp4Az5Es&sta");
      print(linki);

    try {
      // Define the authorization URL provided by your OpenID provider
      final authorizationUrl = Uri.parse(
          "https://integ03-cmam.archimed.fr/?forcelogon=EKLECTIC&redirect_uri=com.CMAM.musika1");

      final callbackUrl =
          Uri.parse('https://integ03-cmam.archimed.fr/eklectic/callback');
      final callbackUrlScheme = callbackUrl.scheme;

      // Launch the authorization flow in a browser or WebView
      final result = await FlutterWebAuth.authenticate(
        url: authorizationUrl.toString(),
        callbackUrlScheme: callbackUrlScheme,
      );

      // Extract the authorization code from the result
      final authorizationCode = Uri.parse(result).queryParameters['code'];

      // Return to the app by opening the callback URL
      if (await canLaunch(callbackUrl.toString())) {
        await launch(callbackUrl.toString());
      } else {
        print('Failed to launch app');
        // Show an error message or take appropriate action
      }
    } on PlatformException catch (e) {
      if (e.code == 'CANCELED') {
        // Handle the case where the user canceled the login process
        print('User canceled the login');
        // Show an error message or take appropriate action
      } else {
        // Handle other platform exceptions
        print('Error during authentication: $e');
        // Show an error message or take appropriate action
      }
    } catch (e) {
      // Handle any other exceptions that may occur during the authentication flow
      print('Error during authentication: $e');
      // Show an error message or take appropriate action
    }
  }*/

  Future<void> openLink() async {
    Uri link = Uri(
      scheme: 'https',
      host: 'integ03-cmam.archimed.fr',
      path: '/MUSIKA/Portal//musika/register.aspx',
    );

    if (await canLaunchUrl(link)) {
      await launchUrl(link);
    } else {
      throw 'Could not launch $link';
    }
  }

  String generateRandomString(int length) {
    const String charset =
        "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789&=";
    final Random random = Random();
    String result = '';

    for (int i = 0; i < length; i++) {
      final randomIndex = random.nextInt(charset.length);
      result += charset[randomIndex];
    }

    return result;
  }

  Future<void> makePostRequest() async {
    Dio _dio = Dio();
    final callbackUrl = Uri.parse('com.example.musika1://home');
    final callbackUrlScheme = callbackUrl.scheme;

    final url = Uri.https('payment.eklectic.tn', '/API/oauth/user/authorize', {
      'response_type': 'code id_token',
      'client_id': "34755f23-cd61-11ed-9577-fa163e3dd8b3",
      'redirect_uri': '$callbackUrlScheme:/',
      'scope': 'openid phone CMAM',
    });

    try {
      final response = await _dio.post(url.toString());
      print(response);
      if (response.statusCode == 200) {
        // Request was successful, handle the response
        print(response.data);
      } else {
        // Handle the error
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      // Handle any exceptions that may occur
      print('Error: $e');
    }
  }

  Future<void> loginSSO1(BuildContext context) async {
    InAppWebView(
      initialUrlRequest: URLRequest(
          url: Uri.parse('https://gateway.eklectic.tn/LP/55/Mouzika/')),
      initialOptions: InAppWebViewGroupOptions(
        crossPlatform: InAppWebViewOptions(),
      ),
      onWebViewCreated: (InAppWebViewController controller) {
        // This callback will be triggered when the WebView is created.
        // You can use the controller to communicate with the WebView.
      },
    );
  }

  void launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> fetchData() async {
    final response =
        await http.get(Uri.parse('http://192.168.3.130:3000/get-data'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      // Process and use the data in your Flutter app
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> loginSSO(BuildContext context) async {
    try {
      final randomString =
          generateRandomString(64); // 64 est la longueur de la chaîne
      final nonce = generateRandomString(30); // 30 est la longueur du nonce
      final finalString = '$randomString';
      //&nonce=$nonce
      final authorizationUrl =
          Uri.parse("http://197.10.242.135/?forcelogon=EKLECTIC");
      final callbackUrl = Uri.parse('com.example.musika1://home');
      final callbackUrlScheme = callbackUrl.scheme;

      final url =
          Uri.https('payment.eklectic.tn', '/API/oauth/user/authorize', {
        'response_mode': 'query',
        'response_type': 'code id_token',
        'client_id': "34755f23-cd61-11ed-9577-fa163e3dd8b3",
        'redirect_uri': '$callbackUrlScheme:/',
        'scope': 'openid phone CMAM',
        'state': '$finalString',
      });
      final result = await FlutterWebAuth.authenticate(
        url: url.toString(),
        callbackUrlScheme: callbackUrlScheme,
      );

      final uri = Uri.parse(result);
      final hasQuery = uri.userInfo;
      final idToken = uri.queryParameters['id_token'];
      final code = uri.queryParameters['code'];

      //launchURL("http://197.10.242.135/eklectic/callback");
      if (idToken != null) {
        final jsonData = parseJwtPayLoad(idToken);

        if (jsonData != null) {
          final msisdn = jsonData['msisdn'].toString();
          getStorge.write("name", msisdn);
          Get.offAllNamed(Routes.Master);
        }
      }
    } on PlatformException catch (e) {
      if (e.code == 'CANCELED') {
        print('User canceled the login');
      } else {
        print('Error during authentication: $e');
        // Handle other platform exceptions, e.g., show an error message.
      }
    } catch (e) {
      print('Error during authentication: $e');
      // Handle any other exceptions that may occur during the authentication flow.
    }
  }

  Future<void> testApi(String accessToken) async {
    bool _isBusy = true;
    var _userInfo = '';
    final apiEndpoint = 'https://payment.eklectic.tn/API/oauth/user/info';
    final headers = {
      'Authorization':
          'Bearer $accessToken', // Include the id_token in the request headers
    };
    try {
      final response = await http.get(Uri.parse(apiEndpoint), headers: headers);

      if (response.statusCode == 200) {
        final user = json.decode(response.body);
        // You can access user details like user['subscriptionType'], user['msisdn'], etc.
        // Update your UI or perform actions accordingly.
      } else {
        // Handle the API request error
        print(
            'Failed to fetch user details. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during API request: $e');
      // Show an error message or take appropriate action
    } finally {
      _isBusy = false;
    }
  }

  Future<LoginStatus?> login(String username, password) async {
    LoginStatus? _apiResponse = LoginStatus(d: 'd', errors: [], success: false);

    Uri linkLogin = Uri(
      scheme: 'https',
      host: 'integ03-cmam.archimed.fr',
      path: 'logon.svc/logon',
    );

    LoginStatus? result = await requestService.authentication(
      username,
      password,
      linkLogin,
    );

    if (result != null) {
      /*  if (result.success) {*/
      _apiResponse = result;

      getStorge.write("name", _apiResponse.d);

      Get.offAllNamed(Routes.Master);
      /*  } else {
        Fluttertoast.showToast(
          msg: "Incorrect credentials",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0,
          backgroundColor: Colors.red,
        );
      }*/
    } else {
      Fluttertoast.showToast(
        msg: "Incorrect credentials",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        fontSize: 16.0,
        backgroundColor: Colors.red,
      );
      print('result is null');
    }

    return _apiResponse;
  }
/* 

 const redirect = "com.CMAM.musika1://eklectic/callback";
      const Client_Id = "34755f23-cd61-11ed-9577-fa163e3dd8b3";
      const Client_secret = "5e255158b6b9da1a8005037ba7f85ddc";
      const authEndPoint =
          "https://payment.eklectic.tn/API/oauth/user/authorize";
      const tokenEndPoint = "https://payment.eklectic.tn/API/oauth/token";
 final authorizationCode = Uri.parse(result).queryParameters['code'];
      print("qqqqqqqqqqqqqqqqqqqqqq" + '$authorizationCode');
      var map = new Map<String, dynamic>();
      map['grant_type'] = 'client_credentials';
      map['client_id'] = Client_Id;
      map['client_secret'] = Client_secret;

      http.Response response = await http.post(
        Uri.parse(tokenEndPoint),
        body: map,
      );

      var _apirespond = jsonDecode(response.body) as Map<String, dynamic>;

      print(_apirespond["access_token"].toString());
      print(testApi(_apirespond["access_token"].toString()));

      if (await canLaunch(callbackUrl.toString())) {
        await launch(callbackUrl.toString());
      } else {
        print('Failed to launch app');
        // Show an error message or take appropriate action
      }*/
/*  Future<LoginStatus> login1(String username, password) async {
    // ignore: no_leading_underscores_for_local_identifiers
    LoginStatus _apiResponse = LoginStatus(d: 'd', errors: [], success: false);
    try {
      var response = await post(
          Uri.parse(
              'https://integ03-cmam.archimed.fr/MUSIKA/Portal/Recherche/logon.svc/logon'),
          body: {'username': 'Selim', 'password': '1121997Sz'});

      if (response.statusCode == 200) {
        var headers = response.headers;
        print(headers);

        // Access the 'set-cookie' header
        var setCookieHeader = headers['set-cookie'];
        print(setCookieHeader);

        if (setCookieHeader != null) {
          var cookies = _extractCookiesFromHeader(setCookieHeader);

          getStorge.write("cookie", cookies);

          // Access individual cookies
        }
        // Access individual cookies

        var _apiResponse = jsonDecode(response.body.toString());

        print(_apiResponse["d"]);

        getStorge.write("id", 1);
        getStorge.write("name", _apiResponse["d"]);
        Get.offAllNamed(Routes.Master);
      } else {
        print('failed');
      }
    } catch (e) {
      print(e.toString());
    }
    return _apiResponse;
  }*/

  List<String> _extractCookiesFromHeader(String header) {
    var cookies = <String>[];
    var cookieHeaderParts = header.split(',');

    for (var cookieHeaderPart in cookieHeaderParts) {
      var cookieKeyValue = cookieHeaderPart.split(';')[0].trim();
      cookies.add(cookieKeyValue);
    }

    return cookies;
  }
}
