// ignore_for_file: deprecated_member_use

import 'dart:math';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/default_transitions.dart';
import 'package:musika/View/HomeView.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Model/TranslationService.dart';
import '../ViewModel/HomeViewModel.dart';
import '../ViewModel/ProfilViewModel.dart';
import '../consts/Mygradient.dart';
import '../consts/theme_data.dart';
import 'SearchView.dart';
import 'libraryView.dart';

class ProfileView extends GetView<ProfilViewModel> {
  @override
  Widget build(BuildContext context) {
    Get.put(ProfilViewModel());
    var isdark = controller.getStorge.read("isDarkMode");
    TextDirection tt = TranslationService().textDirection;

    return Obx(
      () => Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(gradient: MyGradient.getGradient()),
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.1 / 2.5,
                  alignment: Alignment.bottomLeft,
                ),
                Image(
                  image: AssetImage('lib/Resources/drawable/UXprofile_1.png'),
                  color: Styles.themeData(
                          controller.getStorge.read("isDarkMode"), context)
                      .primaryColorLight,
                  width: 150,
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.1 / 1.5,
                  child: Text(
                    controller.name,
                    style: Styles.themeData(
                            controller.getStorge.read("isDarkMode"), context)
                        .textTheme
                        .headline1,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                    height: MediaQuery.of(context).size.height * 0.1 / 1.5,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Changer la language".tr,
                            style: Styles.themeData(
                                    controller.getStorge.read("isDarkMode"),
                                    context)
                                .textTheme
                                .headline1),
                      ],
                    )),
                const SizedBox(
                  height: 10,
                ),
                Container(
                    height: MediaQuery.of(context).size.height * 0.1 / 1.5,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              //en_US
                              controller.changeLocale('en_US');
                            },
                            child: Text(
                              "Francais".tr,
                              style: Styles.themeData(
                                controller.getStorge.read("isDarkMode"),
                                context,
                              ).textTheme.headline1,
                              textAlign: TextAlign.center,
                            ),
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(
                                    color: Styles.themeData(
                                      controller.getStorge.read("isDarkMode"),
                                      context,
                                    ).primaryColorLight,
                                  ),
                                ),
                              ),
                              minimumSize: MaterialStateProperty.all<Size>(
                                Size(double.infinity, 55),
                              ),
                              backgroundColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                (states) => tt == TextDirection.rtl
                                    ? Colors.transparent
                                    : Colors.white.withOpacity(0.3),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              //ar_SA
                              controller.changeLocale('ar_SA');
                            },
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Arabe".tr,
                                    style: Styles.themeData(
                                      controller.getStorge.read("isDarkMode"),
                                      context,
                                    ).textTheme.headline1,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    width:
                                        100, // Ajustez la largeur du conteneur selon vos besoins
                                    color: Colors
                                        .transparent, // Couleur transparente pour ne pas bloquer le clic
                                  ),
                                ),
                              ],
                            ),
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(
                                    color: Styles.themeData(
                                      controller.getStorge.read("isDarkMode"),
                                      context,
                                    ).primaryColorLight,
                                  ),
                                ),
                              ),
                              minimumSize: MaterialStateProperty.all<Size>(
                                Size(double.infinity, 55),
                              ),
                              backgroundColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                (states) => tt == TextDirection.ltr
                                    ? Colors.transparent
                                    : Colors.white.withOpacity(0.3),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
                const SizedBox(
                  height: 25,
                ),

                //Code de dark and light mode deactiver
                /*
                Container(
                  height: MediaQuery.of(context).size.height * 0.29 / 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Theme'.tr,

                        // ignore: deprecated_member_use
                        style: Styles.themeData(
                                controller.getStorge.read("isDarkMode"),
                                context)
                            .textTheme
                            .headline1,
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.light_mode,
                              color: Styles.themeData(
                                      controller.getStorge.read("isDarkMode"),
                                      context)
                                  .primaryColorLight),
                          Flexible(
                              child: Switch(
                            value: controller.isdark.value,
                            onChanged: (value) => controller.toggleTheme(),
                          )),
                          SizedBox(width: 16),
                          Icon(Icons.dark_mode,
                              color: Styles.themeData(
                                      controller.getStorge.read("isDarkMode"),
                                      context)
                                  .primaryColorLight),
                        ],
                      ),
                    ],
                  ),
                ),*/

                Container(
                    height: MediaQuery.of(context).size.height * 0.2 / 3,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Account info".tr,
                            style: Styles.themeData(
                                    controller.getStorge.read("isDarkMode"),
                                    context)
                                .textTheme
                                .headline1),
                      ],
                    )),

                Container(
                  height: MediaQuery.of(context).size.height * 0.2 / 3,
                  width: MediaQuery.of(context).size.width,
                  child: GestureDetector(
                    onTap: () {
                      launch(
                          'https://integ03-cmam.archimed.fr/MUSIKA/account.aspx#/profile'); // Replace with the desired URL
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "click here for more infos".tr,
                          style: TextStyle(
                            fontSize: 16,
                            height: 23 / 15,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.2,
                            color: Color.fromRGBO(255, 255, 255, 1)
                                .withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 50,
                  width: 150,
                  child: TextButton(
                      onPressed: () {
                        controller.logout();
                      },
                      child: Text(
                        "LOGOUT".tr,
                        style: Styles.themeData(
                                controller.getStorge.read("isDarkMode"),
                                context)
                            .textTheme
                            .headline1,
                      ),
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(
                              color: Styles.themeData(
                                      controller.getStorge.read("isDarkMode"),
                                      context)
                                  .primaryColorLight),
                        ),
                      ))),
                ),
                if (Get.find<HomeViewModel>().Miniplayer.value == true)
                  Container(
                    height: 110,
                  ),
                Container(
                  height: 110,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
