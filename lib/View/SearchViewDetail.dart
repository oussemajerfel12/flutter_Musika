// ignore_for_file: deprecated_member_use, sort_child_properties_last, prefer_const_constructors, unnecessary_null_comparison

import 'dart:math';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/default_transitions.dart';
import 'package:musika/Model/SongModel.dart';
import 'package:musika/View/HomeView.dart';
import 'package:musika/View/ProfileView.dart';
import 'package:musika/View/playSongView.dart';
import 'package:provider/provider.dart';

import '../Model/SearchResult.dart';

import '../Model/TranslationService.dart';
import '../ViewModel/HomeViewModel.dart';
import '../ViewModel/PlayViewModel.dart';
import '../ViewModel/SearchViewModel.dart';
import '../consts/Mygradient.dart';
import '../consts/loading.dart';
import '../consts/theme_data.dart';
import 'AlbumView.dart';
import 'PlayView.dart';
import 'package:marquee/marquee.dart';

class SearchViewDetail extends GetView<SearchViewModel> {
  final String text;
  final SearchController = TextEditingController(text: '');
  bool _isLoadingMore = false;

  SearchViewDetail({Key? key, required this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    bool debugPrintGestureArenaDiagnostics = false;
    ScrollController _scrollController = ScrollController();
    Get.put(SearchViewModel());
    final HomeViewModel c = Get.put(HomeViewModel());
    final PlayViewModel c1 = Get.put(PlayViewModel());
    Set<Result> _uniqueResults = Set<Result>();

    return Obx(() => FutureBuilder(
        future: Future.wait([
          controller.searchMusic(controller.page, text),
        ]),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (!snapshot.hasData) {
            return Scaffold(
              body: loading(),
            );
          }
          List<Result>? newResults = snapshot.data![0];

          if (newResults != null) {
            for (Result result in newResults) {
              if (!_uniqueResults.any((res) =>
                  res.resource!.rscUid.toString() ==
                  result.resource!.rscUid.toString())) {
                _uniqueResults.add(result);
              }
            }
          }

          List<Result> _TitreList = _uniqueResults.toList();

          return Scaffold(
              appBar: AppBar(
                title: const Text(""),
                elevation: 0,
                leading: IconButton(
                  icon: Image.asset(
                    'lib/Resources/drawable/backplayer_1.png',
                    color: Styles.themeData(
                            controller.getStorge.read("isDarkMode"), context)
                        .primaryColorLight,
                    width: 50,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                backgroundColor: Color.fromRGBO(62, 17, 84, 1),
                centerTitle: true,
              ),
              body: Container(
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(gradient: MyGradient.getGradient()),
                  child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Directionality(
                        textDirection: TranslationService().textDirection,
                        child: Column(children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(15, 8, 15, 20),
                            child: Container(
                              height: 55,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: Directionality(
                                textDirection:
                                    TranslationService().textDirection,
                                child: TextField(
                                  controller: SearchController,
                                  onSubmitted: (text) {
                                    controller.page = 0;
                                    if (text.isEmpty) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              SearchViewDetail(text: "*"),
                                        ),
                                      );
                                    } else {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              SearchViewDetail(
                                                  text: SearchController.text),
                                        ),
                                      );
                                    }
                                  },
                                  style: TextStyle(
                                    color: Color(0xFF000000),
                                    fontFamily: 'Poppins',
                                    fontSize: 18,
                                    height: 27 / 18,
                                    letterSpacing: 0,
                                  ),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: 'Search'.tr,
                                    hintStyle: TextStyle(
                                      color: Color(0xFF000000).withOpacity(1.0),
                                      fontWeight: FontWeight.normal,
                                      fontSize: 18,
                                      height: 1.8,
                                      letterSpacing: 0,
                                      fontStyle: FontStyle.normal,
                                    ),
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 25),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.white,
                                      ),
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.white,
                                      ),
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                              padding: EdgeInsets.only(
                                  left: 16, top: 15, bottom: 10, right: 16),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    // Ajustez la valeur de width selon vos besoins
                                    child: Text(
                                      "${_TitreList.length.toString()} ${'résultats'.tr}",
                                      style: Styles.themeData(
                                              controller.getStorge
                                                  .read("isDarkMode"),
                                              context)
                                          .textTheme
                                          .headline1,
                                    ),
                                  ),
                                ],
                              )),
                          ListView.builder(
                              primary: false,
                              shrinkWrap: true,
                              itemCount: _TitreList.length + 1,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (BuildContext context, int index) {
                                if (index == _TitreList.length) {
                                  // This is the index after all items have been rendered
                                  if (_TitreList.length < 10) {
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
                                        _isLoadingMore = true;
                                        controller.page++;
                                      },
                                      child: Container(
                                        color: Colors.transparent,
                                        height: 40,
                                        child: Padding(
                                          padding: EdgeInsets.only(top: 8.0),
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
                                        if (_TitreList[index]
                                                .resource!
                                                .type
                                                .toString() ==
                                            "Album") {
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                            builder: (context) =>
                                                AlbumView(_TitreList[index]),
                                          ));
                                        } else {
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
                                                .replaceAll('https', 'http'));
                                          } else {
                                            c1.Stop();
                                            c1.playSongg(_TitreList, index);

                                            c1.Play(_TitreList[index]
                                                .primaryDocs!
                                                .link
                                                .toString()
                                                .replaceAll('https', 'http'));
                                          }
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
                                            color:
                                                Color.fromRGBO(255, 255, 255, 1)
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
                                                      Color.fromRGBO(255, 255,
                                                              255, 0.57)
                                                          .withOpacity(0.20),
                                                  radius: 40,
                                                  backgroundImage: _TitreList[
                                                                  index]
                                                              .fieldList
                                                              ?.thumbSmall !=
                                                          null
                                                      ? NetworkImage(
                                                          _TitreList[index]
                                                              .fieldList!
                                                              .thumbSmall
                                                              .toString())
                                                      : null, // Set the value to null if it's null or use a placeholder image instead
                                                ),
                                              ),
                                              Container(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    _TitreList[index]
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
                                                              text: _TitreList[
                                                                      index]
                                                                  .resource!
                                                                  .id
                                                                  .toString(),
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 15.5,
                                                              ),
                                                              scrollAxis: Axis
                                                                  .horizontal,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              blankSpace: 20.0,
                                                              velocity: 30.0,
                                                              pauseAfterRound:
                                                                  Duration.zero,
                                                              startPadding:
                                                                  10.0,
                                                              accelerationDuration:
                                                                  Duration(
                                                                      seconds:
                                                                          0),
                                                              accelerationCurve:
                                                                  Curves.linear,
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
                                                            padding:
                                                                EdgeInsets.only(
                                                                    bottom: 1),
                                                            child: Text(
                                                              _TitreList[index]
                                                                  .resource!
                                                                  .id
                                                                  .toString(),
                                                              style: TextStyle(
                                                                fontSize: 15,
                                                                height: 23 / 15,
                                                                fontFamily:
                                                                    'Poppins',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                letterSpacing:
                                                                    0,
                                                                color: Color
                                                                        .fromRGBO(
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
                                                      padding: EdgeInsets.only(
                                                          top: 1),
                                                      child: Text(
                                                        _TitreList[index]
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
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                  color: Colors.transparent,
                                );
                              }),
                          Container(
                            height: 110,
                          ),
                        ]),
                      ))));
        }));
  }
}
