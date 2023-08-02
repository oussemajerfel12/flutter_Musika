// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:musika/Service/IRequestService.dart';
import 'package:musika/Service/RequestService.dart';
import '../ViewModel/HomeViewModel.dart';
import '../ViewModel/ProfilViewModel.dart';
import 'package:audio_service/audio_service.dart';
import '../routes/app_page.dart';
import 'Model/TranslationService.dart';
import 'View/Muscibar.dart';
import 'package:audio_service/audio_service.dart';

void setupLocator() {
  GetIt.instance.registerSingleton<IRequestService>(RequestService());
}

void main() async {
  await GetStorage.init();
  final getStorge = GetStorage();
  setupLocator();

  if (getStorge.read('locale') == null) {
    getStorge.write('locale', 'en_US');
    Get.updateLocale(Locale('en_US'));
  }

  runApp(
    MaterialApp(
      home: GetMaterialApp(
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
        translations: TranslationService(),
        locale: GetStorage().read('locale') != null
            ? Locale(GetStorage().read('locale'))
            : Locale('en', 'US'),
        fallbackLocale: Locale('en', 'US'),
        debugShowCheckedModeBanner: false,
      ),
    ),
  );
}
