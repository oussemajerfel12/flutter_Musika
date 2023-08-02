import 'dart:ui';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../Model/TranslationService.dart';
import '../routes/app_page.dart';

class ProfilViewModel extends GetxController {
  final getStorge = GetStorage();
  var name = "";
  var isdark;

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

  //String get getLocale => getStorge.read('locale') ?? TranslationService.locale;

  void changeLocale(String lang) {
    getStorge.write('locale', lang);
    Get.updateLocale(Locale(lang));
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
}
