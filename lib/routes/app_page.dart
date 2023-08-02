import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musika/Model/SearchResult.dart';
import 'package:musika/Model/SongModel.dart';
import 'package:musika/View/MasterPage.dart';
import 'package:musika/View/SearchView.dart';
import 'package:musika/View/libraryView.dart';
import '../View/HomeView.dart';
import '../View/SongsViewAll.dart';
import '../binding/HomeBinding.dart';
import '../View/LoginView.dart';
import '../View/SplashView.dart';
import '../View/ProfileView.dart';
import '../View/PlayView.dart';
import '../binding/LibraryBinding.dart';
import '../binding/SongsAll.dart';
import '../binding/SplashBinding.dart';
import '../binding/ProfilBinding.dart';
import '../binding/PlayBinding.dart';
import '../binding/LoginBinding.dart';
import '../binding/SearchBinding.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;
  static final routes = [
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.PROFIL,
      page: () => ProfileView(),
      binding: ProfilBinding(),
    ),
    GetPage(
      name: _Paths.PLAY,
      // ignore: unnecessary_new
      page: () => PlayView(Result()),
      binding: PlayBinding(),
    ),
    GetPage(
      name: _Paths.Songs,
      // ignore: unnecessary_new
      page: () => SongsViewAll(new Result()),
      binding: SongsAll(),
    ),
    GetPage(
      name: _Paths.Search,
      page: () => SearchView(),
      binding: SearchBinding(),
    ),
    GetPage(
      name: _Paths.MASTER,
      page: () => MyHomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.Library,
      page: () => libraryView(0),
      binding: LibraryBinding(),
    )
  ];
}
