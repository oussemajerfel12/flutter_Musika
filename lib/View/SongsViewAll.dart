// ignore_for_file: deprecated_member_use, prefer_const_constructors, prefer_collection_literals, prefer_final_fields, prefer_const_literals_to_create_immutables, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:http/http.dart%20';
import 'package:musika/View/HomeView.dart';
import 'package:musika/View/playSongView.dart';

import '../Model/SearchResult.dart';

import '../Model/TranslationService.dart';
import '../ViewModel/HomeViewModel.dart';
import '../ViewModel/PlayViewModel.dart';
import '../consts/Mygradient.dart';
import '../consts/loading.dart';
import '../consts/theme_data.dart';
import 'PlayView.dart';
import 'package:marquee/marquee.dart';

class SongsViewAll extends GetView<HomeViewModel> {
  Result result;
  ScrollController _scrollController = ScrollController();
  bool debugPrintGestureArenaDiagnostics = false;
  SongsViewAll(this.result, {super.key});
  Set<Result> _uniqueResults = Set<Result>();

  @override
  Widget build(BuildContext context) {
    final gradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color.fromRGBO(62, 17, 84, 1),
        Color.fromRGBO(98, 15, 96, 1),
        Color.fromRGBO(191, 0, 147, 1),
      ],
      stops: [0, 0.44, 1],
    );
    final HomeViewModel c = Get.put(HomeViewModel());
    final PlayViewModel c1 = Get.put(PlayViewModel());
    Get.put(HomeViewModel());

    Result result = new Result();
    return Obx(() => FutureBuilder(
        future: Future.wait([
          controller.loadMoreTitle(controller.page),
        ]),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (!snapshot.hasData) {
            return Scaffold(
              body: loading(),
            );
          }
          if (snapshot.hasError) {
            // Handle any errors that occurred during data retrieval
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData && snapshot.data != null) {
            // Process and display the data when available
            List<Result>? newResults = snapshot.data![0];
            if (newResults!.isNotEmpty && newResults != null) {
              _uniqueResults.addAll(newResults);
            }
            List<Result> _TitreLoad = _uniqueResults.toList();

            return Scaffold(
                appBar: AppBar(
                  backgroundColor: Color.fromRGBO(62, 17, 84, 1),
                  elevation: 0,
                  leading: Container(
                    alignment: Alignment.bottomLeft,
                    child: IconButton(
                      icon: Image.asset(
                        'lib/Resources/drawable/backplayer_1.png',
                        color: Styles.themeData(
                                controller.getStorge.read("isDarkMode"),
                                context)
                            .primaryColorLight,
                        width: 80,
                      ),
                      onPressed: () {
                        _TitreLoad.clear();
                        controller.page = 0;
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
                body: Container(
                    decoration:
                        BoxDecoration(gradient: MyGradient.getGradient()),
                    child: Directionality(
                        textDirection: TranslationService().textDirection,
                        child: Column(children: [
                          Flexible(
                            child: ListView.builder(
                                primary: false,
                                shrinkWrap: true,
                                itemCount: _TitreLoad.length + 1,
                                itemBuilder: (BuildContext context, int index) {
                                  if (_TitreLoad != null) {
                                    if (index == _TitreLoad.length) {
                                      // This is the index after all items have been rendered
                                      if (newResults.length <= 0) {
                                        // No more results available
                                        return Text(
                                          'No More Result'.tr,
                                          style: Styles.themeData(
                                                  controller.getStorge
                                                      .read("isDarkMode"),
                                                  context)
                                              .textTheme
                                              .headline1,
                                          textAlign: TextAlign.center,
                                        );
                                      } else {
                                        // There are more results to load
                                        return GestureDetector(
                                          onTap: () {
                                            controller.page++;
                                          },
                                          child: Container(
                                            color: Colors.transparent,
                                            height: 40,
                                            child: Padding(
                                              padding:
                                                  EdgeInsets.only(top: 8.0),
                                              child: Text(
                                                'Load More'.tr,
                                                style: Styles.themeData(
                                                        controller.getStorge
                                                            .read("isDarkMode"),
                                                        context)
                                                    .textTheme
                                                    .headline1,
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                    }

                                    return Container(
                                      // height: 100,
                                      // ignore: sort_child_properties_last
                                      child: Center(
                                        child: GestureDetector(
                                          onTap: () {
                                            c1.isShuffled.value = false;
                                            if (c.Miniplayer.value == false) {
                                              Navigator.of(context)
                                                  .push(MaterialPageRoute(
                                                builder: (context) =>
                                                    PlaySongView(
                                                        index, _TitreLoad),
                                              ));
                                              c1.playSongg(_TitreLoad, index);
                                              c1.Play(_TitreLoad[index]
                                                  .primaryDocs!
                                                  .link
                                                  .toString()
                                                  .replaceAll('https', 'http'));
                                            } else {
                                              c1.Stop();
                                              c1.playSongg(_TitreLoad, index);

                                              c1.Play(_TitreLoad[index]
                                                  .primaryDocs!
                                                  .link
                                                  .toString()
                                                  .replaceAll('https', 'http'));
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
                                                    BorderRadius.circular(4),
                                                shape: BoxShape.rectangle,
                                                color: Color.fromRGBO(
                                                        255, 255, 255, 1)
                                                    .withOpacity(0.08),
                                              ),
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
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
                                                      backgroundImage: _TitreLoad[
                                                                      index]
                                                                  .fieldList
                                                                  ?.thumbSmall !=
                                                              null
                                                          ? NetworkImage(
                                                              _TitreLoad[index]
                                                                  .fieldList!
                                                                  .thumbSmall
                                                                  .toString())
                                                          : null, // Set the value to null if it's null or use a placeholder image instead
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
                                                        _TitreLoad[index]
                                                                    .resource!
                                                                    .id
                                                                    .toString()
                                                                    .length >
                                                                20
                                                            ? SizedBox(
                                                                height: 32,
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.6,
                                                                child: Marquee(
                                                                  text: _TitreLoad[
                                                                          index]
                                                                      .resource!
                                                                      .id
                                                                      .toString(),
                                                                  style:
                                                                      TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        15.5,
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
                                                                  textDirection:
                                                                      TextDirection
                                                                          .rtl,
                                                                ),
                                                              )
                                                            : Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        bottom:
                                                                            1),
                                                                child: Text(
                                                                  _TitreLoad[
                                                                          index]
                                                                      .resource!
                                                                      .id
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
                                                                  textAlign:
                                                                      TextAlign
                                                                          .start,
                                                                  maxLines: 1,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                              ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 1),
                                                          child: Text(
                                                            _TitreLoad[index]
                                                                .resource!
                                                                .crtr
                                                                .toString(),
                                                            style: TextStyle(
                                                              fontSize:
                                                                  15, // Ajustez la taille de police en dp
                                                              height: 23 /
                                                                  15, // Ajustez la hauteur de ligne en dp
                                                              fontFamily:
                                                                  'Poppins', // Nom de la police
                                                              fontWeight: FontWeight
                                                                  .bold, // Rendre le texte en gras
                                                              letterSpacing:
                                                                  0, // Ajustez l'espacement entre les lettres
                                                              color: Color
                                                                      .fromRGBO(
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
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),

                                      color: Colors.transparent,
                                    );
                                  }
                                }),
                          ),
                          Container(
                            height: 20,
                          ),
                          if (Get.find<HomeViewModel>().Miniplayer.value ==
                              true)
                            Container(
                              height: 110,
                            ),
                        ]))));

            // Rest of your UI code goes here
          } else {
            // Handle the case when the data is null
            return Scaffold(
              body: Text("there's no data "),
            );
          }
        }));
  }
}
