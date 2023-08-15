// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:musika/Model/ArtisteModel.dart';
import 'package:musika/Model/SongModel.dart';
import 'package:musika/View/ArtisteDetail.dart';
import 'package:musika/View/HomeView.dart';
import 'package:musika/ViewModel/ArtisteViewModel.dart';

import '../Model/AlbumModel.dart';
import '../Model/SearchResult.dart';

import '../Model/TranslationService.dart';
import '../ViewModel/HomeViewModel.dart';
import '../ViewModel/PlayViewModel.dart';
import '../consts/Mygradient.dart';
import '../consts/loading.dart';
import '../consts/theme_data.dart';
import 'AlbumView.dart';
import 'PlayView.dart';
import '../View/playSongView.dart';
import 'package:sqflite/sqflite.dart';
import '../Provider/dbprovider.dart';
import 'package:musika/ViewModel/libraryViewModel.dart';
import 'package:marquee/marquee.dart';

class libraryView extends GetView<libraryViewModel> {
  bool debugPrintGestureArenaDiagnostics = false;
  ScrollController _scrollController = ScrollController();

  late int tabSelected;

  libraryView(this.tabSelected);

  @override
  Widget build(BuildContext context) {
    final HomeViewModel c = Get.put(HomeViewModel());

    final PlayViewModel c1 = Get.put(PlayViewModel());
    Get.put(libraryViewModel());
    final libraryViewModel controller = Get.find<libraryViewModel>();
    final HomeViewModel controllerr = Get.find<HomeViewModel>();
    bool debugPrintGestureArenaDiagnostics = false;
    controller.fetchItems();
    controller.fetchItemsA();
    controller.fetchItemsAB();

    //controller.getCookies();

    return FutureBuilder(
        future: Future.wait([
          controller.loadPlayList(),
        ]),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (!snapshot.hasData) {
            return Scaffold(
              body: loading(),
            );
          }
          List<Label>? PlayList = snapshot.data![0];
          List<Result> album = [];
          List<Result> album1 = [];
          List<Result> album3 = [];

          //debugShowCheckedModeBanner: false,
          return DefaultTabController(
              initialIndex: tabSelected,
              length: 3,
              child: Container(
                  decoration: BoxDecoration(gradient: MyGradient.getGradient()),
                  child: Scaffold(
                    appBar: AppBar(
                      bottom: TabBar(
                        isScrollable: true,
                        labelPadding: EdgeInsets.symmetric(horizontal: 28),
                        indicatorColor: Color(0xFFF700B4).withOpacity(0.4),
                        tabs: [
                          Tab(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Songs'.tr,
                                style: Styles.themeData(
                                        controller.getStorge.read("isDarkMode"),
                                        context)
                                    .textTheme
                                    .headline2,
                              ),
                            ),
                          ),
                          Tab(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Albums'.tr,
                                style: Styles.themeData(
                                        controller.getStorge.read("isDarkMode"),
                                        context)
                                    .textTheme
                                    .headline2,
                              ),
                            ),
                          ),
                          Tab(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Artiste'.tr,
                                style: Styles.themeData(
                                        controller.getStorge.read("isDarkMode"),
                                        context)
                                    .textTheme
                                    .headline2,
                              ),
                            ),
                          ), /*
                          Tab(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'PlayLists'.tr,
                                style: Styles.themeData(
                                        controller.getStorge.read("isDarkMode"),
                                        context)
                                    .textTheme
                                    .headline2,
                              ),
                            ),
                          ),*/
                        ],
                      ),
                      backgroundColor: Styles.themeData(
                              controller.getStorge.read("isDarkMode"), context)
                          .primaryColor,
                    ),
                    body: Container(
                      decoration:
                          BoxDecoration(gradient: MyGradient.getGradient()),
                      child: TabBarView(
                        children: [
                          //SONGS
                          SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                IntrinsicHeight(
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        left: 16,
                                        top: 40,
                                        bottom: 10,
                                        right: 16),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            'Favorite Songs'.tr,
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
                                Flexible(
                                    child: Obx(
                                  () => ListView.builder(
                                      primary: false,
                                      shrinkWrap: true,
                                      itemCount: controller.items.length,
                                      scrollDirection: Axis.vertical,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        album3.add(controllerr
                                            .insertin(controller.items[index]));
                                        return Container(
                                          // height: 100,
                                          // ignore: sort_child_properties_last
                                          child: Center(
                                            child: GestureDetector(
                                              onTap: () {
                                                //c.Miniplayer.value = false;
                                                c1.isShuffled.value = false;
                                                if (c.Miniplayer.value ==
                                                    false) {
                                                  Navigator.of(context)
                                                      .push(MaterialPageRoute(
                                                    builder: (context) =>
                                                        PlaySongView(
                                                            index, album3),
                                                  ));
                                                  c1.playSongg(album3, index);
                                                  c1.Play(album3[index]
                                                      .primaryDocs!
                                                      .link
                                                      .toString()
                                                      .replaceAll(
                                                          'https', 'http'));
                                                } else {
                                                  c1.Stop();
                                                  c1.playSongg(album3, index);

                                                  c1.Play(album3[index]
                                                      .primaryDocs!
                                                      .link
                                                      .toString()
                                                      .replaceAll(
                                                          'https', 'http'));
                                                }
                                              },
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    left: 16,
                                                    top: 8,
                                                    bottom: 2,
                                                    right: 16),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                    shape: BoxShape.rectangle,
                                                    color: Color.fromRGBO(
                                                            255, 255, 255, 1)
                                                        .withOpacity(0.08),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 10,
                                                                  top: 5,
                                                                  bottom: 5,
                                                                  right: 10),
                                                          child: CircleAvatar(
                                                            backgroundColor:
                                                                Color.fromRGBO(
                                                                        255,
                                                                        255,
                                                                        255,
                                                                        0.57)
                                                                    .withOpacity(
                                                                        0.20),
                                                            radius:
                                                                40, // Ajustez le rayon du cercle selon vos besoins
                                                            backgroundImage:
                                                                NetworkImage(
                                                              controller
                                                                  .items[index]
                                                                  .ThumbSmall
                                                                  .toString(),
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              controller.items[index]
                                                                          .Id
                                                                          .toString()
                                                                          .length >
                                                                      20
                                                                  ? SizedBox(
                                                                      height:
                                                                          30,
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width *
                                                                          0.46,
                                                                      child:
                                                                          Marquee(
                                                                        text: controller
                                                                            .items[index]
                                                                            .Id
                                                                            .toString(),
                                                                        style:
                                                                            TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          color:
                                                                              Colors.white,
                                                                          fontSize:
                                                                              15.5,
                                                                        ),
                                                                        scrollAxis:
                                                                            Axis.horizontal,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        blankSpace:
                                                                            20.0,
                                                                        velocity:
                                                                            30.0,
                                                                        pauseAfterRound:
                                                                            Duration.zero,
                                                                        startPadding:
                                                                            10.0,
                                                                        accelerationDuration:
                                                                            Duration(seconds: 0),
                                                                        accelerationCurve:
                                                                            Curves.linear,
                                                                        decelerationDuration:
                                                                            Duration(milliseconds: 100),
                                                                        decelerationCurve:
                                                                            Curves.easeOut,
                                                                        textDirection:
                                                                            TextDirection.rtl,
                                                                      ),
                                                                    )
                                                                  : Padding(
                                                                      padding: EdgeInsets.only(
                                                                          bottom:
                                                                              1),
                                                                      child:
                                                                          Text(
                                                                        controller
                                                                            .items[index]
                                                                            .Id
                                                                            .toString(),
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              15,
                                                                          height:
                                                                              23 / 15,
                                                                          fontFamily:
                                                                              'Poppins',
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          letterSpacing:
                                                                              0,
                                                                          color:
                                                                              Color.fromRGBO(255, 255, 255, 1).withOpacity(1),
                                                                        ),
                                                                        textAlign:
                                                                            TextAlign.start,
                                                                        maxLines:
                                                                            1,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                      ),
                                                                    ),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        top: 1),
                                                                child: Text(
                                                                  controller
                                                                      .items[
                                                                          index]
                                                                      .Crtr
                                                                      .toString(),
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        15, // Ajustez la taille de police en dp
                                                                    height: 23 /
                                                                        15, // Ajustez la hauteur de ligne en dp
                                                                    fontFamily:
                                                                        'Poppins', // Nom de la police
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold, // Rendre le texte en gras
                                                                    letterSpacing:
                                                                        0, // Ajustez l'espacement entre les lettres
                                                                    color: Color.fromRGBO(
                                                                            255,
                                                                            255,
                                                                            255,
                                                                            1)
                                                                        .withOpacity(
                                                                            0.58), // Couleur RGBA (255, 255, 255) avec une opacité de 1
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ]),
                                                      Row(children: [
                                                        Column(children: [
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 5,
                                                                    top: 5,
                                                                    bottom: 5,
                                                                    right: 5),
                                                            child: IconButton(
                                                              icon: Image.asset(
                                                                'lib/Resources/drawable/trash-01.png',
                                                                width: 16,
                                                                height: 17,
                                                              ),
                                                              onPressed:
                                                                  () async {
                                                                controller
                                                                    .deleteItem(
                                                                  controller
                                                                      .items[
                                                                          index]
                                                                      .RscUid
                                                                      .toString(),
                                                                );
                                                              },
                                                            ),
                                                          )
                                                        ])
                                                      ])
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),

                                          color: Colors.transparent,
                                        );
                                      }),
                                )),
                                if (Get.find<HomeViewModel>()
                                        .Miniplayer
                                        .value ==
                                    true)
                                  Container(
                                    height: 110,
                                  ),
                                Container(
                                  height: 70,
                                )
                              ],
                            ),
                          ),
                          //ALBUMS

                          SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                IntrinsicHeight(
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        left: 16,
                                        top: 40,
                                        bottom: 10,
                                        right: 16),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            'Favorite Albums'.tr,
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
                                Flexible(
                                  child: Obx(
                                    () => ListView.builder(
                                        primary: false,
                                        shrinkWrap: true,
                                        itemCount: controller.itemsAlbum.length,
                                        scrollDirection: Axis.vertical,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          album.add(controllerr.insertinAB(
                                              controller.itemsAlbum[index]));
                                          return Container(
                                            color: Colors.transparent,
                                            child: Center(
                                              child: GestureDetector(
                                                onTap: () {
                                                  Navigator.of(context)
                                                      .push(MaterialPageRoute(
                                                    builder: (context) =>
                                                        AlbumView(album[index]),
                                                  ));
                                                },
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 16,
                                                      top: 8,
                                                      bottom: 2,
                                                      right: 16),
                                                  child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4),
                                                        shape:
                                                            BoxShape.rectangle,
                                                        color: Color.fromRGBO(
                                                                255,
                                                                255,
                                                                255,
                                                                1)
                                                            .withOpacity(0.08),
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 10,
                                                                    top: 5,
                                                                    bottom: 5,
                                                                    right: 10),
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    color: Colors
                                                                        .white
                                                                        .withOpacity(
                                                                            0.2), // Shadow color
                                                                    // Shadow offset
                                                                    // Shadow blur radius
                                                                  ),
                                                                ],
                                                              ),
                                                              child: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                                child: Image
                                                                    .network(
                                                                  controller
                                                                      .itemsAlbum[
                                                                          index]
                                                                      .thumbSmall
                                                                      .toString(),
                                                                  width: 80,
                                                                  height: 80,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                SizedBox(
                                                                  height: 32,
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.6,
                                                                  child:
                                                                      Marquee(
                                                                    text: controller
                                                                        .itemsAlbum[
                                                                            index]
                                                                        .ttl
                                                                        .toString(),
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          15,
                                                                      height:
                                                                          23 /
                                                                              15,
                                                                      fontFamily:
                                                                          'Poppins',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      letterSpacing:
                                                                          0,
                                                                      color: Color.fromRGBO(
                                                                              255,
                                                                              255,
                                                                              255,
                                                                              1)
                                                                          .withOpacity(
                                                                              1),
                                                                    ),
                                                                    scrollAxis:
                                                                        Axis.horizontal,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    blankSpace:
                                                                        20.0,
                                                                    velocity:
                                                                        30.0,
                                                                    pauseAfterRound:
                                                                        Duration
                                                                            .zero,
                                                                    startPadding:
                                                                        10.0,
                                                                    accelerationDuration:
                                                                        Duration(
                                                                            seconds:
                                                                                0),
                                                                    accelerationCurve:
                                                                        Curves
                                                                            .linear,
                                                                    decelerationDuration:
                                                                        Duration(
                                                                            milliseconds:
                                                                                100),
                                                                    decelerationCurve:
                                                                        Curves
                                                                            .easeOut,
                                                                    textDirection:
                                                                        TextDirection
                                                                            .rtl,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                    height: 8),
                                                              ],
                                                            ),
                                                          ),
                                                          IconButton(
                                                            icon: Image.asset(
                                                              'lib/Resources/drawable/trash-01.png',
                                                              width: 16,
                                                              height: 17,
                                                            ),
                                                            onPressed:
                                                                () async {
                                                              controller
                                                                  .deleteItemab(
                                                                controller
                                                                    .itemsAlbum[
                                                                        index]
                                                                    .RscUid
                                                                    .toString(),
                                                              );
                                                            },
                                                          ),
                                                        ],
                                                      )),
                                                ),
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                                ),
                                if (Get.find<HomeViewModel>()
                                        .Miniplayer
                                        .value ==
                                    true)
                                  Container(
                                    height: 110,
                                  ),
                                Container(
                                  height: 70,
                                )
                              ],
                            ),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                IntrinsicHeight(
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        left: 16,
                                        top: 40,
                                        bottom: 10,
                                        right: 16),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            'Favorite Artiste'.tr,
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
                                Flexible(
                                  child: Obx(
                                    () => ListView.builder(
                                        primary: false,
                                        shrinkWrap: true,
                                        itemCount:
                                            controller.itemsArtiste.length,
                                        scrollDirection: Axis.vertical,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          album1.add(controllerr.insertinAT(
                                              controller.itemsArtiste[index]));
                                          return Container(
                                            color: Colors.transparent,
                                            child: Center(
                                              child: GestureDetector(
                                                onTap: () {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              ArtisteDetail(
                                                                  album1[
                                                                      index])));
                                                },
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 16,
                                                      top: 8,
                                                      bottom: 2,
                                                      right: 16),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4),
                                                      shape: BoxShape.rectangle,
                                                      color: Color.fromRGBO(
                                                              255, 255, 255, 1)
                                                          .withOpacity(0.08),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Row(children: [
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 10,
                                                                    top: 5,
                                                                    bottom: 5,
                                                                    right: 10),
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    color: Colors
                                                                        .white
                                                                        .withOpacity(
                                                                            0.2), // Shadow color
                                                                    // Shadow offset
                                                                    // Shadow blur radius
                                                                  ),
                                                                ],
                                                              ),
                                                              child: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                                child: Image
                                                                    .network(
                                                                  controller
                                                                      .itemsArtiste[
                                                                          index]
                                                                      .ThumbSmall
                                                                      .toString(),
                                                                  width: 80,
                                                                  height: 80,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Padding(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                          bottom:
                                                                              1),
                                                                  child: Text(
                                                                    controller
                                                                        .itemsArtiste[
                                                                            index]
                                                                        .ttl
                                                                        .toString(),
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          15, // Ajustez la taille de police en dp
                                                                      height: 23 /
                                                                          15, // Ajustez la hauteur de ligne en dp
                                                                      fontFamily:
                                                                          'Poppins', // Nom de la police
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold, // Rendre le texte en gras
                                                                      letterSpacing:
                                                                          0, // Ajustez l'espacement entre les lettres
                                                                      color: Color.fromRGBO(
                                                                              255,
                                                                              255,
                                                                              255,
                                                                              1)
                                                                          .withOpacity(
                                                                              1), // Couleur RGBA (255, 255, 255) avec une opacité de 1
                                                                    ),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .start,
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .only(
                                                                              top: 1),
                                                                  child: Text(
                                                                    controller
                                                                        .itemsArtiste[
                                                                            index]
                                                                        .RscUid
                                                                        .toString(),
                                                                    style: TextStyle(
                                                                        fontSize: 15, // Ajustez la taille de police en dp
                                                                        height: 23 / 15, // Ajustez la hauteur de ligne en dp
                                                                        fontFamily: 'Poppins', // Nom de la police
                                                                        fontWeight: FontWeight.bold, // Rendre le texte en gras
                                                                        letterSpacing: 0, // Ajustez l'espacement entre les lettres
                                                                        color: Color.fromRGBO(255, 255, 255, 1).withOpacity(0.58)
                                                                        // Couleur RGBA (255, 255, 255) avec une opacité de 1
                                                                        ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ]),
                                                        Row(children: [
                                                          Column(children: [
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 10,
                                                                      top: 5,
                                                                      bottom: 5,
                                                                      right:
                                                                          10),
                                                              child: IconButton(
                                                                icon:
                                                                    Image.asset(
                                                                  'lib/Resources/drawable/trash-01.png',
                                                                  width: 18,
                                                                  height: 19,
                                                                ),
                                                                onPressed:
                                                                    () async {
                                                                  controller
                                                                      .deleteItema(
                                                                    controller
                                                                        .itemsArtiste[
                                                                            index]
                                                                        .RscUid
                                                                        .toString(),
                                                                  );
                                                                },
                                                              ),
                                                            )
                                                          ])
                                                        ])
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                                ),
                                if (Get.find<HomeViewModel>()
                                        .Miniplayer
                                        .value ==
                                    true)
                                  Container(
                                    height: 110,
                                  ),
                                Container(
                                  height: 70,
                                )
                              ],
                            ),
                          ),
/*
                          SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                IntrinsicHeight(
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        left: 16,
                                        top: 40,
                                        bottom: 10,
                                        right: 16),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            'Fields'.tr,
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
                                Flexible(
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.2489,
                                    width: MediaQuery.of(context).size.width *
                                        0.95,
                                    child: ListView.builder(
                                      shrinkWrap: false,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: PlayList!.length,
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
                                                  onTap: () {},
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
                                                        ),
                                                        child: ImageIcon(
                                                          AssetImage(
                                                            'lib/Resources/drawable/playlist.png',
                                                          ),
                                                          size: 100,
                                                          color: Styles.themeData(
                                                                  controller
                                                                      .getStorge
                                                                      .read(
                                                                          "isDarkMode"),
                                                                  context)
                                                              .primaryColorLight,
                                                        ),
                                                      ),
                                                      Container(
                                                        height: 15,
                                                      ),
                                                      Container(
                                                        height: 25,
                                                        child: Text(
                                                          PlayList![index]
                                                              .displayLabel
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
                                Container(
                                  height: 5,
                                ),
                                Column(
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    IntrinsicHeight(
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            left: 16,
                                            top: 40,
                                            bottom: 10,
                                            right: 16),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                'PlayList'.tr,
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
                                    Flexible(
                                        child: Obx(
                                      () => ListView.builder(
                                          primary: false,
                                          shrinkWrap: true,
                                          itemCount: controller.items.length,
                                          scrollDirection: Axis.vertical,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            album3.add(controllerr.insertin(
                                                controller.items[index]));
                                            return Container(
                                              // height: 100,
                                              // ignore: sort_child_properties_last
                                              child: Center(
                                                child: GestureDetector(
                                                  onTap: () {
                                                    //c.Miniplayer.value = false;
                                                    c1.isShuffled.value = false;
                                                    if (c.Miniplayer.value ==
                                                        false) {
                                                      Navigator.of(context)
                                                          .push(
                                                              MaterialPageRoute(
                                                        builder: (context) =>
                                                            PlaySongView(
                                                                index, album3),
                                                      ));

                                                      c1.Play(album3[index]
                                                          .primaryDocs!
                                                          .link
                                                          .toString()
                                                          .replaceAll(
                                                              'https', 'http'));
                                                      c1.playSongg(
                                                          album3, index);
                                                    } else {
                                                      c1.Stop();
                                                      c1.playSongg(
                                                          album3, index);

                                                      c1.Play(album3[index]
                                                          .primaryDocs!
                                                          .link
                                                          .toString()
                                                          .replaceAll(
                                                              'https', 'http'));
                                                    }
                                                  },
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 16,
                                                        top: 8,
                                                        bottom: 2,
                                                        right: 16),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4),
                                                        shape:
                                                            BoxShape.rectangle,
                                                        color: Color.fromRGBO(
                                                                255,
                                                                255,
                                                                255,
                                                                1)
                                                            .withOpacity(0.08),
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Row(children: [
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 10,
                                                                      top: 5,
                                                                      bottom: 5,
                                                                      right:
                                                                          10),
                                                              child:
                                                                  CircleAvatar(
                                                                backgroundColor: Color
                                                                        .fromRGBO(
                                                                            255,
                                                                            255,
                                                                            255,
                                                                            0.57)
                                                                    .withOpacity(
                                                                        0.20),
                                                                radius:
                                                                    40, // Ajustez le rayon du cercle selon vos besoins
                                                                backgroundImage:
                                                                    NetworkImage(
                                                                  controller
                                                                      .items[
                                                                          index]
                                                                      .ThumbSmall
                                                                      .toString(),
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  controller.items[index]
                                                                              .Id
                                                                              .toString()
                                                                              .length >
                                                                          20
                                                                      ? SizedBox(
                                                                          height:
                                                                              30,
                                                                          width:
                                                                              MediaQuery.of(context).size.width * 0.46,
                                                                          child:
                                                                              Marquee(
                                                                            text:
                                                                                controller.items[index].Id.toString(),
                                                                            style:
                                                                                TextStyle(
                                                                              fontWeight: FontWeight.bold,
                                                                              color: Colors.white,
                                                                              fontSize: 15.5,
                                                                            ),
                                                                            scrollAxis:
                                                                                Axis.horizontal,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            blankSpace:
                                                                                20.0,
                                                                            velocity:
                                                                                30.0,
                                                                            pauseAfterRound:
                                                                                Duration.zero,
                                                                            startPadding:
                                                                                10.0,
                                                                            accelerationDuration:
                                                                                Duration(seconds: 0),
                                                                            accelerationCurve:
                                                                                Curves.linear,
                                                                            decelerationDuration:
                                                                                Duration(milliseconds: 100),
                                                                            decelerationCurve:
                                                                                Curves.easeOut,
                                                                            textDirection:
                                                                                TextDirection.rtl,
                                                                          ),
                                                                        )
                                                                      : Padding(
                                                                          padding:
                                                                              EdgeInsets.only(bottom: 1),
                                                                          child:
                                                                              Text(
                                                                            controller.items[index].Id.toString(),
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: 15,
                                                                              height: 23 / 15,
                                                                              fontFamily: 'Poppins',
                                                                              fontWeight: FontWeight.bold,
                                                                              letterSpacing: 0,
                                                                              color: Color.fromRGBO(255, 255, 255, 1).withOpacity(1),
                                                                            ),
                                                                            textAlign:
                                                                                TextAlign.start,
                                                                            maxLines:
                                                                                1,
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                          ),
                                                                        ),
                                                                  Padding(
                                                                    padding: EdgeInsets
                                                                        .only(
                                                                            top:
                                                                                1),
                                                                    child: Text(
                                                                      controller
                                                                          .items[
                                                                              index]
                                                                          .Crtr
                                                                          .toString(),
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            15, // Ajustez la taille de police en dp
                                                                        height: 23 /
                                                                            15, // Ajustez la hauteur de ligne en dp
                                                                        fontFamily:
                                                                            'Poppins', // Nom de la police
                                                                        fontWeight:
                                                                            FontWeight.bold, // Rendre le texte en gras
                                                                        letterSpacing:
                                                                            0, // Ajustez l'espacement entre les lettres
                                                                        color: Color.fromRGBO(
                                                                                255,
                                                                                255,
                                                                                255,
                                                                                1)
                                                                            .withOpacity(0.58), // Couleur RGBA (255, 255, 255) avec une opacité de 1
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ]),
                                                          Row(children: [
                                                            Column(children: [
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left: 5,
                                                                        top: 5,
                                                                        bottom:
                                                                            5,
                                                                        right:
                                                                            5),
                                                                child:
                                                                    IconButton(
                                                                  icon: Image
                                                                      .asset(
                                                                    'lib/Resources/drawable/trash-01.png',
                                                                    width: 16,
                                                                    height: 17,
                                                                  ),
                                                                  onPressed:
                                                                      () async {
                                                                    controller
                                                                        .deleteItem(
                                                                      controller
                                                                          .items[
                                                                              index]
                                                                          .RscUid
                                                                          .toString(),
                                                                    );
                                                                  },
                                                                ),
                                                              )
                                                            ])
                                                          ])
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),

                                              color: Colors.transparent,
                                            );
                                          }),
                                    )),
                                    if (Get.find<HomeViewModel>()
                                            .Miniplayer
                                            .value ==
                                        true)
                                      Container(
                                        height: 110,
                                      ),
                                    Container(
                                      height: 70,
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),*/
                        ],
                      ),
                    ),
                  )));
        });
  }
}
