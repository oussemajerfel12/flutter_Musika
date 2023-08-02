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
          List<Result>? PlayList = snapshot.data![0];

          List<Result> album = [];
          List<Result> album1 = [];

          //debugShowCheckedModeBanner: false,
          return DefaultTabController(
              initialIndex: tabSelected,
              length: 4,
              child: Container(
                  decoration: BoxDecoration(gradient: MyGradient.getGradient()),
                  child: Scaffold(
                    appBar: AppBar(
                      bottom: TabBar(
                        isScrollable: true,
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
                          ),
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
                          ),
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
                                  child: ListView.builder(
                                      primary: false,
                                      shrinkWrap: true,
                                      itemCount: controller.items.length,
                                      scrollDirection: Axis.vertical,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Container(
                                          // height: 100,
                                          // ignore: sort_child_properties_last
                                          child: Center(
                                            child: GestureDetector(
                                              onTap: () {
                                                //c.Miniplayer.value = false;
                                                if (c.Miniplayer.value ==
                                                    false) {
                                                  Navigator.of(context)
                                                      .push(MaterialPageRoute(
                                                    builder: (context) =>
                                                        PlaySongView(
                                                            index, album),
                                                  ));

                                                  c1.Play(album[index]
                                                      .primaryDocs!
                                                      .link
                                                      .toString()
                                                      .replaceAll(
                                                          'https', 'http'));
                                                  c1.playSongg(album, index);
                                                } else {
                                                  c1.Stop();
                                                  c1.playSongg(album, index);

                                                  c1.Play(album[index]
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
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        bottom:
                                                                            1),
                                                                child: Text(
                                                                  controller
                                                                      .items[
                                                                          index]
                                                                      .Id
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
                                                                    left: 10,
                                                                    top: 5,
                                                                    bottom: 5,
                                                                    right: 10),
                                                            child: IconButton(
                                                                icon: Icon(
                                                                    Icons
                                                                        .delete_outline_outlined,
                                                                    color: Styles.themeData(
                                                                            controller.getStorge.read(
                                                                                "isDarkMode"),
                                                                            context)
                                                                        .primaryColorLight),
                                                                onPressed:
                                                                    () async {
                                                                  controller.deleteItem(controller
                                                                      .items[
                                                                          index]
                                                                      .RscUid
                                                                      .toString());
                                                                }),
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
                                ),
                              ],
                            ),
                          ),
                          //ALBUMS

                          new SingleChildScrollView(
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
                                  child: ListView.builder(
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
                                                            child: CircleAvatar(
                                                              backgroundColor:
                                                                  Color.fromRGBO(
                                                                          255,
                                                                          255,
                                                                          255,
                                                                          0.57)
                                                                      .withOpacity(
                                                                          0.20),
                                                              radius: 40,
                                                              backgroundImage:
                                                                  NetworkImage(
                                                                controller
                                                                    .itemsAlbum[
                                                                        index]
                                                                    .thumbSmall
                                                                    .toString(),
                                                              ),
                                                            )),
                                                        SizedBox(width: 16),
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
                                                                    .width,
                                                                child: Marquee(
                                                                  text: controller
                                                                      .itemsAlbum[
                                                                          index]
                                                                      .ttl
                                                                      .toString(),
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        20, // Ajustez la taille de police en dp
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
                                                                  scrollAxis: Axis
                                                                      .horizontal,
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
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  height: 8),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(width: 16),
                                                        IconButton(
                                                          icon: Icon(Icons
                                                              .delete_outline_outlined),
                                                          color: Styles.themeData(
                                                                  controller
                                                                      .getStorge
                                                                      .read(
                                                                          "isDarkMode"),
                                                                  context)
                                                              .primaryColorLight,
                                                          onPressed: () async {
                                                            controller.deleteItemab(
                                                                controller
                                                                    .itemsAlbum[
                                                                        index]
                                                                    .RscUid
                                                                    .toString());
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
                              ],
                            ),
                          ),
                          new SingleChildScrollView(
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
                                  child: ListView.builder(
                                      primary: false,
                                      shrinkWrap: true,
                                      itemCount: controller.itemsArtiste.length,
                                      scrollDirection: Axis.vertical,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        album1.add(controllerr.insertinAT(
                                            controller.itemsArtiste[index]));
                                        return Container(
                                          height: 100,
                                          // ignore: sort_child_properties_last
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
                                                            child: Image.asset(
                                                              'lib/Resources/drawable/Micro.png',
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
                                                                    left: 10,
                                                                    top: 5,
                                                                    bottom: 5,
                                                                    right: 10),
                                                            child: IconButton(
                                                                icon: Icon(
                                                                    Icons
                                                                        .delete_outline_outlined,
                                                                    color: Styles.themeData(
                                                                            controller.getStorge.read(
                                                                                "isDarkMode"),
                                                                            context)
                                                                        .primaryColorLight),
                                                                onPressed:
                                                                    () async {
                                                                  controller.deleteItem(controller
                                                                      .itemsArtiste[
                                                                          index]
                                                                      .RscUid
                                                                      .toString());
                                                                }),
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
                                ),
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
                                    child: Obx(() => ListView.builder(
                                          primary: false,
                                          shrinkWrap: true,
                                          itemCount: PlayList!.length,
                                          scrollDirection: Axis.vertical,
                                          itemBuilder: (BuildContext context,
                                                  int index) =>
                                              Card(
                                            color: Styles.themeData(
                                                    controller.getStorge
                                                        .read("isDarkMode"),
                                                    context)
                                                .primaryColor,
                                            child: Center(
                                              child: GestureDetector(
                                                onTap: () {
                                                  /*
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) => PlaySongView(
                                            controller.items[index]),
                                      ));*/
                                                },
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.95,
                                                  color: Styles.themeData(
                                                          controller.getStorge
                                                              .read(
                                                                  "isDarkMode"),
                                                          context)
                                                      .primaryColorDark
                                                      .withOpacity(0.15),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Align(
                                                        //alignment: Alignment.centerLeft,
                                                        child: Row(children: [
                                                          SizedBox(width: 20),
                                                          // ignore: prefer_const_constructors
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 1,
                                                                    top: 3),
                                                            child: Container(
                                                              width: 80,
                                                              height: 90,
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15),
                                                                shape: BoxShape
                                                                    .rectangle,
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    color: Styles.themeData(
                                                                            controller.getStorge.read(
                                                                                "isDarkMode"),
                                                                            context)
                                                                        .primaryColorLight
                                                                        .withOpacity(
                                                                            0.1),
                                                                    spreadRadius:
                                                                        0,
                                                                    blurRadius:
                                                                        0,
                                                                    offset: Offset
                                                                        .zero,
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.30,
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .end,
                                                              children: [
                                                                Text('hi'),
                                                                /*PlayList[
                                                                          index]
                                                                      .displayLabel
                                                                      .toString(),
                                                                  style: Styles.themeData(
                                                                          controller
                                                                              .getStorge
                                                                              .read("isDarkMode"),
                                                                          context)
                                                                      .textTheme
                                                                      .headline2,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .end,
                                                                  softWrap:
                                                                      true,
                                                                  maxLines: 1,
                                                                ),*/
                                                              ],
                                                            ),
                                                          ),
                                                        ]),
                                                      ),
                                                      Align(
                                                          alignment: Alignment
                                                              .bottomRight,
                                                          child: Container(
                                                              //height: 120.0,
                                                              width: 120.0,
                                                              child: Column(
                                                                  children: [
                                                                    IconButton(
                                                                        icon: Icon(
                                                                            Icons
                                                                                .delete_outline_outlined,
                                                                            color: Styles.themeData(controller.getStorge.read("isDarkMode"), context)
                                                                                .primaryColorLight),
                                                                        onPressed:
                                                                            () async {
                                                                          controller.deleteItem(controller
                                                                              .items[index]
                                                                              .RscUid
                                                                              .toString());
                                                                        }),
                                                                  ]))),
                                                    ],
                                                    //hi
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )));
        });
  }
}
