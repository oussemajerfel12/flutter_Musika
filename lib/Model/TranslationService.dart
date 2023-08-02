import 'dart:ui';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class TranslationService extends Translations {
  static final getStorge = GetStorage();

  TextDirection get textDirection =>
      Locale(getStorge.read('locale')).languageCode == 'en_US'
          ? TextDirection.ltr
          : TextDirection.rtl;

  static final Map<String, String> _en_US = {
    'Songs': 'Songs',
    'Song': 'Song',
    'please restart the app to refresh': 'please restart the app to refresh',
    'Theme': 'Theme',
    'Account info': 'Account info',
    'Francais': 'Francais',
    'ARABE': 'ARABE',
    'Changer la language': 'Changer la language',
    'LOGOUT': 'LOGOUT',
    'Recently Played': 'Recently Played',
    'View All': 'View All',
    'Hot Now !': 'Hot Now !',
    'Hot recommended': 'Hot recommended',
    'Artiste': 'Artiste',
    'Search...': 'Search...',
    'Albums': 'Albums',
    'PlayLists': 'PlayLists',
    'Favorite Songs': 'Favorite Songs',
    'Mezoued': 'Mezoued',
    'Malouf': 'Malouf',
    'Sufi': 'Sufi',
    'Rap': 'Rap',
    'Alternative': 'Alternative',
    'Maghreb': 'Maghreb',
    'Nouveautés': 'Nouveautés',
    'Classique': 'Classique',
    'Egypte': 'Egypte',
    'Load More': 'Load More',
    'No More Result': 'No More Result',
    "résultats": "résultats",
    "Profil": "Profil",
    "Library": "Library",
    "Search": "Search",
    "Home": "Home",
    "Suggestions": "Suggestions",
    "click here for more infos": "click here for more infos",
    "Player Media is not initialized please restart the player":
        "Player Media is not initialized please restart the player",
    'Delete all': 'Delete all',
    'Sufi / religious': 'Sufi / religious',
    'Popular traditions': 'Popular traditions',
    'Mizwid': 'Mizwid',
    'Instrumental': 'Instrumental',
    'Mālūf': 'Mālūf',
  };

  static final Map<String, String> _ar_SA = {
    'Songs': 'الأغاني',
    'Song': 'غناء',
    'please restart the app to refresh': 'يرجى إعادة تشغيل التطبيق للتحديث',
    'Theme': 'موضوع',
    'Account info': 'معلومات الحساب',
    'Francais': 'الفرنسية',
    'Arabe': 'العربية',
    'Changer la language': 'تغيير اللغة',
    'LOGOUT': 'تسجيل خروج',
    'Artiste': 'الفنانين',
    'Hot Now !': 'الأغاني',
    'Hot recommended': 'الأغاني',
    'View All': 'عرض الكل',
    'Recently Played': 'استمعت مؤخرا',
    'Search...': 'البحث ...',
    'Albums': 'الألبوم',
    'PlayLists': 'قائمة الأغاني',
    'Favorite Songs': 'الأغاني المفضلة',
    'Favorite Albums': ' الألبومات المفضلة ',
    'Favorite Artiste': 'الفنانين المفضلين',
    'Mezoued': 'مزود',
    'Malouf': 'مالوف',
    'Sufi': 'صوفي',
    'Rap': 'راب',
    'Alternative': 'Alternative',
    'Maghreb': 'مغاربي',
    'Nouveautés': 'مستجدات',
    'Classique': 'كلاسيكي',
    'Egypte': 'مصري',
    'Load More': 'تحميل المزيد',
    'No More Result': 'لا مزيد من النتائج',
    'résultats': 'نتائج',
    'Profil': 'الملف الشخصي',
    'Library': 'مكتبتي',
    'Search': 'البحث',
    "Home": "الصفحة الرئيسية",
    "Suggestions": "الاقتراحات",
    "click here for more infos": "انقر هنا لمزيد من المعلومات",
    "Player Media is not initialized please restart the player":
        "لم يتم بدء تشغيل اللاعب، يرجى إعادة تشغيله ",
    "Delete all": "محو الكل ",
    'Sufi / religious': 'موسيقى صوفية / دينية',
    'Popular tradition': 'تقاليد شعبية',
    'Mizwid': 'مزود',
    'Instrumental': 'موسيقى آلية',
    'Mālūf': 'مالوف',
  };

  static final Map<String, Map<String, String>> translations = {
    'en_US': _en_US,
    'ar_SA': _ar_SA,
  };

  static String get getLocale => getStorge.read('locale');

  static void changeLocale(String lang) {
    getStorge.write('locale', lang);
    Get.updateLocale(Locale(lang));
  }

  @override
  Map<String, Map<String, String>> get keys => translations;
}
