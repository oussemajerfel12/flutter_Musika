// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/scheduler/ticker.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/list_notifier.dart';
import 'package:musika/Model/SearchResult.dart';
import 'package:musika/View/HomeView.dart';
import 'package:musika/View/Muscibar.dart';
import 'package:musika/View/PlayView.dart';
import 'package:musika/View/ProfileView.dart';
import 'package:musika/View/SearchView.dart';
import 'package:musika/View/videoView.dart';
import 'package:musika/ViewModel/PlayViewModel.dart';
import '../Model/TranslationService.dart';
import '../View/libraryView.dart';
import '../ViewModel/HomeViewModel.dart';
import '../consts/no_internet.dart';
import '../routes/app_page.dart';

class MyHomePage extends GetView<HomeViewModel> {
  final HomeViewModel _controller = Get.put(HomeViewModel());
  GlobalKey<NavigatorState> pageOneTabNavKey = GlobalKey<NavigatorState>();
  GlobalKey<NavigatorState> pagetwoTabNavKey = GlobalKey<NavigatorState>();
  GlobalKey<NavigatorState> pagethreeTabNavKey = GlobalKey<NavigatorState>();
  GlobalKey<NavigatorState> pagefourTabNavKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    MaterialApp(
      // ...
      routes: {
        '/': (context) => MyHomePage(),
        '/home': (context) => HomeView(),
        // Define other routes
      },
    );

    return Obx(() => Scaffold(
            body: Stack(
          children: [
            CupertinoTabScaffold(
              tabBar: CupertinoTabBar(
                backgroundColor: Colors.black.withOpacity(0.5),
                height: 69,
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Obx(
                      () => Padding(
                        padding: EdgeInsets.only(
                            top: 8), // Add desired top padding value
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Image.asset(
                                'lib/Resources/drawable/home_01.png',
                                color: _controller.selectedIndex.value == 0
                                    ? Color.fromARGB(255, 251, 248, 245)
                                    : Color.fromARGB(255, 251, 248, 245)
                                        .withOpacity(0.4),
                                width: 28,
                              ),
                            ),
                            Flexible(
                              child: Text(
                                'Home'.tr,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.normal,
                                  letterSpacing: 0,
                                  color: _controller.selectedIndex.value == 0
                                      ? Color.fromARGB(255, 251, 248, 245)
                                      : Color.fromARGB(255, 251, 248, 245)
                                          .withOpacity(0.4),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  BottomNavigationBarItem(
                    icon: Obx(
                      () => Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'lib/Resources/drawable/UXsearch_1.png',
                              color: _controller.selectedIndex.value == 1
                                  ? Color.fromARGB(255, 251, 248, 245)
                                  : Color.fromARGB(255, 251, 248, 245)
                                      .withOpacity(0.4),
                              width: 28,
                            ),
                            Text(
                              'Search'.tr,
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.normal,
                                letterSpacing: 0,
                                color: _controller.selectedIndex.value == 1
                                    ? Color.fromARGB(255, 251, 248, 245)
                                    : Color.fromARGB(255, 251, 248, 245)
                                        .withOpacity(0.4),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  BottomNavigationBarItem(
                    icon: Obx(
                      () => Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'lib/Resources/drawable/UXlibrary.png',
                              color: _controller.selectedIndex.value == 2
                                  ? Color.fromARGB(255, 251, 248, 245)
                                  : Color.fromARGB(255, 251, 248, 245)
                                      .withOpacity(0.4),
                              width: 28,
                            ),
                            Text(
                              'Library'.tr,
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.normal,
                                letterSpacing: 0,
                                color: _controller.selectedIndex.value == 2
                                    ? Color.fromARGB(255, 251, 248, 245)
                                    : Color.fromARGB(255, 251, 248, 245)
                                        .withOpacity(0.4),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  BottomNavigationBarItem(
                    icon: Obx(
                      () => Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'lib/Resources/drawable/UXprofile.png',
                              color: _controller.selectedIndex.value == 3
                                  ? Color.fromARGB(255, 251, 248, 245)
                                  : Color.fromARGB(255, 251, 248, 245)
                                      .withOpacity(0.4),
                              width: 28,
                            ),
                            Text(
                              "Profil".tr,
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.normal,
                                letterSpacing: 0,
                                color: _controller.selectedIndex.value == 3
                                    ? Color.fromARGB(255, 251, 248, 245)
                                    : Color.fromARGB(255, 251, 248, 245)
                                        .withOpacity(0.4),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  /*  BottomNavigationBarItem(
                    icon: Obx(
                      () => Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'lib/Resources/drawable/UXprofile.png',
                              color: _controller.selectedIndex.value == 3
                                  ? Color.fromARGB(255, 251, 248, 245)
                                  : Color.fromARGB(255, 251, 248, 245)
                                      .withOpacity(0.4),
                              width: 28,
                            ),
                            Text(
                              "Video Player".tr,
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.normal,
                                letterSpacing: 0,
                                color: _controller.selectedIndex.value == 3
                                    ? Color.fromARGB(255, 251, 248, 245)
                                    : Color.fromARGB(255, 251, 248, 245)
                                        .withOpacity(0.4),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),*/
                ],
                currentIndex: _controller.selectedIndex.value,
                onTap: (int index) {
                  _controller.updateSelectedIndex(index);

                  if (index == 0) {
                    if (Get.find<PlayViewModel>().isPlayed.value == true) {
                      Get.find<HomeViewModel>().Miniplayer.value = true;
                      pageOneTabNavKey.currentState!.popUntil((r) => r.isFirst);
                    } else {
                      pageOneTabNavKey.currentState!.popUntil((r) => r.isFirst);
                    }
                  }
                  if (index == 1) {
                    if (Get.find<PlayViewModel>().isPlayed.value == true) {
                      Get.find<HomeViewModel>().Miniplayer.value = true;
                      pagetwoTabNavKey.currentState!.popUntil((r) => r.isFirst);
                    } else {
                      pagetwoTabNavKey.currentState!.popUntil((r) => r.isFirst);
                    }
                  }
                  if (index == 2) {
                    if (Get.find<PlayViewModel>().isPlayed.value == true) {
                      Get.find<HomeViewModel>().Miniplayer.value = true;
                      pagethreeTabNavKey.currentState!
                          .popUntil((r) => r.isFirst);
                    } else {
                      pagethreeTabNavKey.currentState!
                          .popUntil((r) => r.isFirst);
                    }
                  }
                  if (index == 3) {
                    if (Get.find<PlayViewModel>().isPlayed.value == true) {
                      Get.find<HomeViewModel>().Miniplayer.value = true;
                      pagefourTabNavKey.currentState!
                          .popUntil((r) => r.isFirst);
                    } else {
                      pagefourTabNavKey.currentState!
                          .popUntil((r) => r.isFirst);
                    }
                  }
                },
              ),
              tabBuilder: (BuildContext context, int index) {
                switch (index) {
                  case 0:
                    return CupertinoTabView(
                        navigatorKey: pageOneTabNavKey,
                        builder: (BuildContext context) {
                          return CupertinoPageScaffold(
                            child: Center(
                                child: Directionality(
                              textDirection: TranslationService().textDirection,
                              child: HomeView(),
                            )),
                          );
                        });
                  case 1:
                    return CupertinoTabView(
                        navigatorKey: pagetwoTabNavKey,
                        builder: (BuildContext context) {
                          return CupertinoPageScaffold(
                            child: Center(
                                child: Directionality(
                              textDirection: TranslationService().textDirection,
                              child: SearchView(),
                            )),
                          );
                        });
                  case 2:
                    return CupertinoTabView(
                        navigatorKey: pagethreeTabNavKey,
                        builder: (BuildContext context) {
                          return CupertinoPageScaffold(
                            child: Center(
                                child: Directionality(
                              textDirection: TranslationService().textDirection,
                              child: libraryView(0),
                            )),
                          );
                        });
                  case 3:
                    return CupertinoTabView(
                        navigatorKey: pagefourTabNavKey,
                        builder: (BuildContext context) {
                          return CupertinoPageScaffold(
                            child: Center(
                                child: Directionality(
                              textDirection: TranslationService().textDirection,
                              child: ProfileView(),
                            )),
                          );
                        });

                  default:
                    return CupertinoTabView(builder: (BuildContext context) {
                      return CupertinoPageScaffold(
                        child: Center(
                            child: Directionality(
                          textDirection: TranslationService().textDirection,
                          child: ProfileView(),
                        )),
                      );
                    });
                }
              },
            ),
            if (Get.find<HomeViewModel>().Miniplayer.value == true)
              Positioned(left: 0, bottom: 69, right: 0, child: MusicBar()),
          ],
        )));
  }
}
