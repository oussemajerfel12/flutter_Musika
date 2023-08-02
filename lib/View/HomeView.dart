// ignore_for_file: deprecated_member_use, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:musika/Model/SongModel.dart';
import 'package:musika/View/ArtistViewAll.dart';
import 'package:musika/View/ArtisteDetail.dart';
import 'package:musika/View/LoginView.dart';
import 'package:musika/View/Muscibar.dart';
import 'package:musika/View/ProfileView.dart';
import 'package:musika/View/SearchView.dart';
import 'package:musika/View/SongsViewAll.dart';
import 'package:musika/View/libraryView.dart';
import 'package:musika/ViewModel/PlayViewModel.dart';
import 'package:musika/ViewModel/ProfilViewModel.dart';
import 'package:musika/consts/loading.dart';
import 'package:musika/consts/theme_data.dart';
import 'package:provider/provider.dart';
import '../Model/TranslationService.dart';
import '../Provider/dbprovider.dart';
import '../ViewModel/HomeViewModel.dart';
import '../Model/SearchOptions.dart';
import '../Model/SearchResult.dart';
import '../consts/no_internet.dart';
import '../routes/app_page.dart';
import '../View/PlayView.dart';
import 'RecentSongView.dart';
import '../View/playSongView.dart';
import '../consts/Mygradient.dart';

class HomeView extends GetView<HomeViewModel> {
  @override
  Widget build(BuildContext context) {
    Future<void> _refreshHomePage() async {
      await controller.loadHot();
      // await controller.loadpageResult();
      // await controller.loadPageArtist();
      await controller.fRecent(); // Example of refresh logic
      // Perform any other necessary refresh operations
    }

    final HomeViewModel c = Get.put(HomeViewModel());
    final PlayViewModel c1 = Get.put(PlayViewModel());

    Result result = new Result();

    List<Result> recently = [];
    TextDirection tt = TranslationService().textDirection;
    SongModel songModel = new SongModel();

    return FutureBuilder(
        future: Future.wait([
          controller.loadHot(),
          controller.loadpageResult(),
          controller.loadPageArtist(),
          controller.fRecent(),
          //controller.likethat(),
        ]),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (!snapshot.hasData) {
            return Scaffold(body: loading());
          }
          List<Result>? _Titrehot = snapshot.data![0];
          List<Result>? _TitreList = snapshot.data![1];
          List<Result>? _ArtistList = snapshot.data![2];
          RxList<SongModel> _Recent = snapshot.data![3];
          //List<Result>? Likethat = snapshot.data![4];
          List<Result> resultItems = [];
          if (_Titrehot!.length > 0) {
            return Obx(() => Scaffold(
                  appBar: null,
                  body: Container(
                    decoration:
                        BoxDecoration(gradient: MyGradient.getGradient()),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Container(
                            height: MediaQuery.of(context).size.width * 0.10,
                          ),
                          //Section Hot Now
                          IntrinsicHeight(
                            child: Container(
                              padding: EdgeInsets.only(
                                  left: tt == TextDirection.rtl ? 0 : 14,
                                  top: 10,
                                  bottom: 0,
                                  right: tt == TextDirection.rtl ? 8 : 0),
                              height: MediaQuery.of(context).size.height * 0.1,
                              width: MediaQuery.of(context).size.width * 0.98,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Hot recommended'.tr,
                                      textAlign: TextAlign.left,
                                      style: Styles.themeData(
                                              controller.getStorge
                                                  .read("isDarkMode"),
                                              context)
                                          .textTheme
                                          .headline1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          //liste debute ici du Hot Now
                          Flexible(
                            child: Container(
                              height:
                                  MediaQuery.of(context).size.height * 0.2489,
                              width: MediaQuery.of(context).size.width * 0.95,
                              child: ListView.builder(
                                shrinkWrap: false,
                                scrollDirection: Axis.horizontal,
                                itemCount: _Titrehot?.length,
                                itemBuilder:
                                    (BuildContext context, int index) =>
                                        Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Color.fromRGBO(70, 17, 87, 255),
                                        Color.fromRGBO(88, 16, 93, 255),
                                      ], // Replace with your desired gradient colors
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    ),
                                  ),
                                  child: Center(
                                    child: Container(
                                      width: 132,
                                      height: 350,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              c1.isShuffled.value = false;
                                              c1.isRepated.value = false;
                                              if (c.Miniplayer.value == false) {
                                                Navigator.of(context)
                                                    .push(MaterialPageRoute(
                                                  builder: (context) =>
                                                      PlaySongView(
                                                          index, _Titrehot),
                                                ));
                                                c1.playSongg(_Titrehot, index);
                                                c1.Play(_Titrehot[index]
                                                    .primaryDocs!
                                                    .link
                                                    .toString()
                                                    .replaceAll(
                                                        'https', 'http'));
                                              } else {
                                                c1.Stop();
                                                c1.playSongg(_Titrehot, index);

                                                c1.update();
                                                if (Platform.isIOS == true) {
                                                  c1.Play(_Titrehot[index]
                                                      .primaryDocs!
                                                      .link
                                                      .toString());
                                                } else {
                                                  c1.Play(_Titrehot[index]
                                                      .primaryDocs!
                                                      .link
                                                      .toString()
                                                      .replaceAll(
                                                          'https', 'http'));
                                                }
                                              }
                                            },
                                            child: Column(
                                              children: [
                                                Container(
                                                  width: 120,
                                                  height: 120,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Color.fromRGBO(
                                                                255,
                                                                255,
                                                                255,
                                                                0.57)
                                                            .withOpacity(0.20),
                                                      ),
                                                    ],
                                                    image: DecorationImage(
                                                        image: NetworkImage(
                                                          _Titrehot![index]
                                                              .fieldList!
                                                              .thumbSmall
                                                              .toString(),
                                                        ),
                                                        fit: BoxFit.fill,
                                                        alignment:
                                                            Alignment.center),
                                                  ),
                                                ),
                                                Container(
                                                  height: 15,
                                                ),
                                                Container(
                                                  height: 25,
                                                  child: Text(
                                                    _Titrehot[index]
                                                        .resource!
                                                        .id
                                                        .toString(),
                                                    style: Styles.themeData(
                                                            controller.getStorge
                                                                .read(
                                                                    "isDarkMode"),
                                                            context)
                                                        .textTheme
                                                        .headline2,
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                                Text(
                                                  _Titrehot[index]
                                                      .resource!
                                                      .crtr
                                                      .toString(),
                                                  style: Styles.themeData(
                                                          controller.getStorge
                                                              .read(
                                                                  "isDarkMode"),
                                                          context)
                                                      .textTheme
                                                      .headline3,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          //Section Songs

                          IntrinsicHeight(
                            child: Container(
                              padding: EdgeInsets.only(
                                  left: tt == TextDirection.rtl ? 0 : 14,
                                  top: 10,
                                  bottom: 0,
                                  right: tt == TextDirection.rtl ? 8 : 5),
                              height: MediaQuery.of(context).size.height * 0.1,
                              width: MediaQuery.of(context).size.width * 0.98,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text('Songs'.tr,
                                        textAlign: TextAlign.left,
                                        style: Styles.themeData(
                                                controller.getStorge
                                                    .read("isDarkMode"),
                                                context)
                                            .textTheme
                                            .headline1),
                                  ),
                                  Container(
                                    alignment: Alignment.centerRight,
                                    child: TextButton(
                                      style: OutlinedButton.styleFrom(
                                          backgroundColor: Colors.transparent,
                                          alignment: Alignment.centerRight),
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SongsViewAll(result)));
                                      },
                                      child: Text('View All'.tr,
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Color.fromARGB(
                                                  255, 253, 253, 253))),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Flexible(
                            child: Container(
                              height:
                                  MediaQuery.of(context).size.height * 0.2489,
                              width: MediaQuery.of(context).size.width * 0.95,
                              child: ListView.builder(
                                shrinkWrap: false,
                                scrollDirection: Axis.horizontal,
                                itemCount: _TitreList!.length,
                                itemBuilder:
                                    (BuildContext context, int index) =>
                                        Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Color.fromRGBO(97, 15, 96, 255),
                                        Color.fromRGBO(146, 7, 122, 255),
                                      ], // Replace with your desired gradient colors
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    ),
                                  ),
                                  child: Center(
                                    child: Container(
                                      width: 132,
                                      height: 350,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              //c.Miniplayer.value = false;
                                              c1.isRepated.value = false;
                                              c1.isShuffled.value = false;
                                              if (c.Miniplayer.value == false) {
                                                Navigator.of(context)
                                                    .push(MaterialPageRoute(
                                                  builder: (context) =>
                                                      PlaySongView(
                                                          index, _TitreList),
                                                ));
                                                c1.playSongg(_TitreList, index);
                                                c1.Play(_TitreList[index]
                                                    .primaryDocs!
                                                    .link
                                                    .toString()
                                                    .replaceAll(
                                                        'https', 'http'));
                                              } else {
                                                c1.Stop();
                                                c1.playSongg(_TitreList, index);

                                                c1.update();
                                                if (Platform.isIOS == true) {
                                                  c1.Play(_TitreList[index]
                                                      .primaryDocs!
                                                      .link
                                                      .toString());
                                                } else {
                                                  c1.Play(_TitreList[index]
                                                      .primaryDocs!
                                                      .link
                                                      .toString()
                                                      .replaceAll(
                                                          'https', 'http'));
                                                }
                                              }
                                            },
                                            child: Column(
                                              children: [
                                                Container(
                                                  width: 120,
                                                  height: 120,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Color.fromRGBO(
                                                                255,
                                                                255,
                                                                255,
                                                                0.57)
                                                            .withOpacity(0.20),
                                                      ),
                                                    ],
                                                    image: DecorationImage(
                                                        image: NetworkImage(
                                                          _TitreList![index]
                                                              .fieldList!
                                                              .thumbSmall
                                                              .toString(),
                                                        ),
                                                        fit: BoxFit.fill,
                                                        alignment:
                                                            Alignment.center),
                                                  ),
                                                ),
                                                Container(
                                                  height: 15,
                                                ),
                                                Container(
                                                  height: 25,
                                                  child: Text(
                                                    _TitreList[index]
                                                        .resource!
                                                        .id
                                                        .toString(),
                                                    style: Styles.themeData(
                                                            controller.getStorge
                                                                .read(
                                                                    "isDarkMode"),
                                                            context)
                                                        .textTheme
                                                        .headline2,
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                                Text(
                                                  _TitreList[index]
                                                      .resource!
                                                      .crtr
                                                      .toString(),
                                                  style: Styles.themeData(
                                                          controller.getStorge
                                                              .read(
                                                                  "isDarkMode"),
                                                          context)
                                                      .textTheme
                                                      .headline3,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          //Section Artiste

                          IntrinsicHeight(
                            child: Container(
                              padding: EdgeInsets.only(
                                  left: tt == TextDirection.rtl ? 0 : 14,
                                  top: 10,
                                  bottom: 0,
                                  right: tt == TextDirection.rtl ? 8 : 5),
                              height: MediaQuery.of(context).size.height * 0.1,
                              width: MediaQuery.of(context).size.width * 0.98,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text('Artiste'.tr,
                                        textAlign: TextAlign.left,
                                        style: Styles.themeData(
                                                controller.getStorge
                                                    .read("isDarkMode"),
                                                context)
                                            .textTheme
                                            .headline1),
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: TextButton(
                                      style: OutlinedButton.styleFrom(
                                          backgroundColor: Colors.transparent,
                                          alignment: Alignment.centerRight),
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ArtistViewAll(result)));
                                      },
                                      child: Text('View All'.tr,
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Color.fromARGB(
                                                  255, 248, 246, 245))),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Flexible(
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.22,
                              width: MediaQuery.of(context).size.width * 0.95,
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: _ArtistList?.length,
                                itemBuilder:
                                    (BuildContext context, int index) =>
                                        Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Color.fromRGBO(172, 3, 136, 255),
                                        Color.fromRGBO(167, 4, 134, 255),
                                      ], // Replace with your desired gradient colors
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    ),
                                  ),
                                  child: Center(
                                    child: Container(
                                      width: 132,
                                      height: 350,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.of(context)
                                                  .push(MaterialPageRoute(
                                                builder: (context) =>
                                                    ArtisteDetail(
                                                        _ArtistList[index]),
                                              ));
                                            },
                                            child: Column(
                                              children: [
                                                Container(
                                                  width: 120,
                                                  height: 120,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Color.fromRGBO(
                                                                255,
                                                                255,
                                                                255,
                                                                1)
                                                            .withOpacity(0.20),
                                                      ),
                                                    ],
                                                    image: DecorationImage(
                                                        image: NetworkImage(
                                                          _ArtistList![index]
                                                              .fieldList!
                                                              .thumbSmall
                                                              .toString(),
                                                        ),
                                                        fit: BoxFit.scaleDown,
                                                        alignment:
                                                            Alignment.center),
                                                  ),
                                                ),
                                                Container(
                                                  height: 15,
                                                ),
                                                Text(
                                                  _ArtistList![index]
                                                      .resource!
                                                      .ttl
                                                      .toString(),
                                                  style: Styles.themeData(
                                                          controller.getStorge
                                                              .read(
                                                                  "isDarkMode"),
                                                          context)
                                                      .textTheme
                                                      .headline2,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
/*
                          //Section Hot Now
                          IntrinsicHeight(
                            child: Container(
                              padding: EdgeInsets.only(
                                  left: tt == TextDirection.rtl ? 0 : 14,
                                  top: 10,
                                  bottom: 0,
                                  right: tt == TextDirection.rtl ? 8 : 0),
                              height: MediaQuery.of(context).size.height * 0.1,
                              width: MediaQuery.of(context).size.width * 0.98,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'You Might Like That'.tr,
                                      textAlign: TextAlign.left,
                                      style: Styles.themeData(
                                              controller.getStorge
                                                  .read("isDarkMode"),
                                              context)
                                          .textTheme
                                          .headline1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          //liste debute ici du Like That
                          Flexible(
                            child: Container(
                              height:
                                  MediaQuery.of(context).size.height * 0.2489,
                              width: MediaQuery.of(context).size.width * 0.95,
                              child: ListView.builder(
                                shrinkWrap: false,
                                scrollDirection: Axis.horizontal,
                                itemCount: Likethat?.length,
                                itemBuilder:
                                    (BuildContext context, int index) =>
                                        Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Color.fromRGBO(70, 17, 87, 255),
                                        Color.fromRGBO(88, 16, 93, 255),
                                      ], // Replace with your desired gradient colors
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    ),
                                  ),
                                  child: Center(
                                    child: Container(
                                      width: 132,
                                      height: 350,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              c1.isShuffled.value = false;
                                              if (c.Miniplayer.value == false) {
                                                Navigator.of(context)
                                                    .push(MaterialPageRoute(
                                                  builder: (context) =>
                                                      PlaySongView(
                                                          index, Likethat!),
                                                ));
                                                c1.playSongg(Likethat!, index);
                                                c1.Play(Likethat[index]
                                                    .primaryDocs!
                                                    .link
                                                    .toString()
                                                    .replaceAll(
                                                        'https', 'http'));
                                              } else {
                                                c1.Stop();
                                                c1.playSongg(Likethat, index);

                                                c1.update();
                                                if (Platform.isIOS == true) {
                                                  c1.Play(Likethat[index]
                                                      .primaryDocs!
                                                      .link
                                                      .toString());
                                                } else {
                                                  c1.Play(Likethat[index]
                                                      .primaryDocs!
                                                      .link
                                                      .toString()
                                                      .replaceAll(
                                                          'https', 'http'));
                                                }
                                              }
                                            },
                                            child: Column(
                                              children: [
                                                Container(
                                                  width: 120,
                                                  height: 120,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Color.fromRGBO(
                                                                255,
                                                                255,
                                                                255,
                                                                0.57)
                                                            .withOpacity(0.20),
                                                      ),
                                                    ],
                                                    image: DecorationImage(
                                                        image: NetworkImage(
                                                          Likethat![index]
                                                              .fieldList!
                                                              .thumbSmall
                                                              .toString(),
                                                        ),
                                                        fit: BoxFit.fill,
                                                        alignment:
                                                            Alignment.center),
                                                  ),
                                                ),
                                                Container(
                                                  height: 15,
                                                ),
                                                Container(
                                                  height: 25,
                                                  child: Text(
                                                    Likethat[index]
                                                        .resource!
                                                        .id
                                                        .toString(),
                                                    style: Styles.themeData(
                                                            controller.getStorge
                                                                .read(
                                                                    "isDarkMode"),
                                                            context)
                                                        .textTheme
                                                        .headline2,
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                                Text(
                                                  Likethat[index]
                                                      .resource!
                                                      .crtr
                                                      .toString(),
                                                  style: Styles.themeData(
                                                          controller.getStorge
                                                              .read(
                                                                  "isDarkMode"),
                                                          context)
                                                      .textTheme
                                                      .headline3,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
*/
                          //section recently played

                          IntrinsicHeight(
                            child: Container(
                              padding: EdgeInsets.only(
                                  left: tt == TextDirection.rtl ? 0 : 14,
                                  top: 10,
                                  bottom: 0,
                                  right: tt == TextDirection.rtl ? 8 : 5),
                              height: MediaQuery.of(context).size.height * 0.1,
                              width: MediaQuery.of(context).size.width * 0.98,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text('Recently Played'.tr,
                                        textAlign: TextAlign.left,
                                        style: Styles.themeData(
                                                controller.getStorge
                                                    .read("isDarkMode"),
                                                context)
                                            .textTheme
                                            .headline1),
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: TextButton(
                                      style: OutlinedButton.styleFrom(
                                          backgroundColor: Colors.transparent,
                                          alignment: Alignment.centerRight),
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    RecentSongView(songModel)));
                                      },
                                      child: Text('View All'.tr,
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Color.fromARGB(
                                                  255, 253, 253, 253))),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          Flexible(
                            child: Container(
                              height: MediaQuery.of(context).size.width * 0.60,
                              width: MediaQuery.of(context).size.width * 0.95,
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount:
                                      (_Recent != null && _Recent.isNotEmpty)
                                          ? min(5, _Recent.length)
                                          : 0,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    recently.add(
                                        controller.insertin(_Recent[index]));
                                    return Obx(() => Container(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              Color.fromRGBO(169, 4, 135, 255),
                                              Color.fromRGBO(177, 2, 139, 255),
                                            ], // Replace with your desired gradient colors
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                          ),
                                        ),
                                        child: Center(
                                          child: Container(
                                            width: 132,
                                            height: 350,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    c1.isShuffled.value = false;
                                                    c1.isRepated.value = false;
                                                    if (c.Miniplayer.value ==
                                                        false) {
                                                      Navigator.of(context)
                                                          .push(
                                                              MaterialPageRoute(
                                                        builder: (context) =>
                                                            PlaySongView(index,
                                                                recently),
                                                      ));
                                                      c1.Stop();
                                                      c1.playSongg(
                                                          recently, index);
                                                      c1.Play(recently[index]
                                                          .primaryDocs!
                                                          .link
                                                          .toString()
                                                          .replaceAll(
                                                              'https', 'http'));
                                                    } else {
                                                      c1.Stop();
                                                      c1.playSongg(
                                                          recently, index);

                                                      c1.Play(recently[index]
                                                          .primaryDocs!
                                                          .link
                                                          .toString()
                                                          .replaceAll(
                                                              'https', 'http'));
                                                    }
                                                  },
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        width: 120,
                                                        height: 120,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(12),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Color
                                                                      .fromRGBO(
                                                                          255,
                                                                          255,
                                                                          255,
                                                                          0.57)
                                                                  .withOpacity(
                                                                      0.20),
                                                            ),
                                                          ],
                                                          image:
                                                              DecorationImage(
                                                                  image:
                                                                      NetworkImage(
                                                                    _Recent[index]
                                                                        .ThumbSmall
                                                                        .toString(),
                                                                  ),
                                                                  fit: BoxFit
                                                                      .fill,
                                                                  alignment:
                                                                      Alignment
                                                                          .center),
                                                        ),
                                                      ),
                                                      Container(
                                                        height: 15,
                                                      ),
                                                      Container(
                                                        height: 25,
                                                        child: Text(
                                                          _Recent[index]
                                                              .Id
                                                              .toString(),
                                                          style: Styles.themeData(
                                                                  controller
                                                                      .getStorge
                                                                      .read(
                                                                          "isDarkMode"),
                                                                  context)
                                                              .textTheme
                                                              .headline2,
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ),
                                                      Container(
                                                        height: 25,
                                                        child: Text(
                                                          _Recent[index]
                                                              .Crtr
                                                              .toString(),
                                                          style: Styles.themeData(
                                                                  controller
                                                                      .getStorge
                                                                      .read(
                                                                          "isDarkMode"),
                                                                  context)
                                                              .textTheme
                                                              .headline3,
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )));
                                  }),
                            ),
                          ),
                          if (Get.find<HomeViewModel>().Miniplayer.value ==
                              true)
                            Container(
                              height: 90,
                            ),
                          Container(
                            height: 80,
                          )
                        ],
                      ),
                    ),
                  ),
                ));
          } else {
            return Scaffold(body: no_internet());
          }
        });
  }
}
