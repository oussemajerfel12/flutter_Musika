// ignore_for_file: deprecated_member_use, no_leading_underscores_for_local_identifiers, prefer_const_declarations

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';

import 'package:url_launcher/url_launcher.dart';
import '../Model/LoginStauts.dart';
import '../Service/IRequestService.dart';
import '../View/HomeView.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../routes/app_page.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import '../Model/tokendec.dart';

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
    try {
      // Define the authorization URL provided by your OpenID provider
      final authorizationUrl = Uri.parse(
          "https://integ03-cmam.archimed.fr/?forcelogon=EKLECTIC&redirect_uri=com.example.musika1");

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
      path: '/PNT/Portal//musika/register.aspx',
    );

    if (await canLaunchUrl(link)) {
      await launchUrl(link);
    } else {
      throw 'Could not launch $link';
    }
  }

  Future<void> loginSSO() async {
    try {
      // Define the authorization URL provided by your OpenID provider
      final authorizationUrl =
          Uri.parse("https://integ03-cmam.archimed.fr/?forcelogon=EKLECTIC");
      final callbackUrl = Uri.parse('com.example.musika1://home');

      final callbackUrlScheme = callbackUrl.scheme;
      const redirect = "com.example.musika1://eklectic/callback";
      const Client_Id = "34755f23-cd61-11ed-9577-fa163e3dd8b3";
      const Client_secret = "5e255158b6b9da1a8005037ba7f85ddc";
      const authEndPoint =
          "https://payment.eklectic.tn/API/oauth/user/authorize";
      const tokenEndPoint = "https://payment.eklectic.tn/API/oauth/token";

      final url =
          Uri.https('payment.eklectic.tn', '/API/oauth/user/authorize', {
        'response_type': 'code id_token',
        'client_id': "34755f23-cd61-11ed-9577-fa163e3dd8b3",
        'redirect_uri': '$callbackUrlScheme:/',
        'scope': 'openid phone CMAM',
      });
//https://payment.eklectic.tn/API/oauth/user/authorize?response_type=code&client_id=34755f23-cd61-11ed-9577-fa163e3dd8b3&scope=openid+phone+CMAM&redirect_uri=com.example.musika1
      // Launch the authorization flow in a browser or WebView
      final result = await FlutterWebAuth.authenticate(
        url: url.toString(),
        callbackUrlScheme: callbackUrlScheme,
      );
      print(result);
      final test = Uri.parse(result).queryParameters['offre_id'];
      final idtoken = Uri.parse(result).queryParameters['id_token'];
      final token = Uri.parse(result).queryParameters['code'];
      // Extract the authorization code from the result
      // print(parseJwtHeader(idtoken));

      if (idtoken != null) {
        final jsonData = parseJwtPayLoad(idtoken);
        print(jsonData);

        if (jsonData != null) {
          final msisdn = jsonData['msisdn'].toString();
          getStorge.write("name", msisdn);
          Get.offAllNamed(Routes.Master);
        }
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
  }

  Future<void> testApi(String accessToken) async {
    bool _isBusy = true;
    var _userInfo = '';
    try {
      final http.Response httpResponse = await http.get(
        Uri.parse('https://demo.duendesoftware.com/api/test'),
        headers: <String, String>{'Authorization': 'Bearer $accessToken'},
      );

      _userInfo = httpResponse.statusCode == 200 ? httpResponse.body : '';
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
/*  final authorizationCode = Uri.parse(result).queryParameters['code'];
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
