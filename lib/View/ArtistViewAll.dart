// ignore_for_file: deprecated_member_use, curly_braces_in_flow_control_structures, dead_code, prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:musika/View/ArtisteDetail.dart';
import 'package:musika/View/HomeView.dart';
import 'package:musika/consts/Mygradient.dart';

import '../Model/SearchResult.dart';

import '../Model/TranslationService.dart';
import '../ViewModel/HomeViewModel.dart';
import '../consts/loading.dart';
import '../consts/theme_data.dart';
import 'PlayView.dart';

class ArtistViewAll extends GetView<HomeViewModel> {
  Result result;
  ScrollController _scrollController = ScrollController();
  bool debugPrintGestureArenaDiagnostics = false;
  ArtistViewAll(this.result, {super.key});
  Set<Result> _uniqueResults = Set<Result>();
  final gradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color.fromRGBO(62, 17, 84, 1),
      Color.fromRGBO(191, 0, 147, 1),
    ],
    stops: [0, 0.44, 1],
  );

  @override
  Widget build(BuildContext context) {
    Get.put(HomeViewModel());
    debugShowCheckedModeBanner:
    false;

    Result result = new Result();

    return Obx(() => FutureBuilder(
        future: Future.wait([
          controller.loadMoreArtist(controller.pageArtist),
        ]),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (!snapshot.hasData) {
            return Scaffold(
              body: loading(),
            );
          }
          // Process and display the data when available
          List<Result>? newResults = snapshot.data![0];
          if (newResults!.isNotEmpty && newResults != null) {
            _uniqueResults.addAll(newResults);
          }
          List<Result>? _ArtistList = _uniqueResults.toList();

          return Scaffold(
              backgroundColor: Styles.themeData(
                      controller.getStorge.read("isDarkMode"), context)
                  .primaryColor,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                centerTitle: false,
                titleSpacing: 0.0,
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromRGBO(62, 17, 84, 1),
                        Color.fromRGBO(98, 15, 96, 1),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
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
                    controller.pageArtist = 0;
                  },
                ),
              ),
              body: Container(
                  decoration: BoxDecoration(gradient: MyGradient.getGradient()),
                  child: Directionality(
                      textDirection: TranslationService().textDirection,
                      child: Column(
                        children: [
                          Flexible(
                              child: ListView.builder(
                                  controller:
                                      _scrollController, // add this line
                                  primary: false,
                                  shrinkWrap: true,
                                  itemCount: _ArtistList!.length + 1,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    if (index == _ArtistList.length) {
                                      // This is the index after all items have been rendered
                                      if (newResults.length > 0) {
                                        return GestureDetector(
                                          onTap: () {
                                            controller.pageArtist++;
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
                                      } else {
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
                                      }
                                    }
                                    return Container(
                                      child: Center(
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.of(context)
                                                .push(MaterialPageRoute(
                                              builder: (context) =>
                                                  ArtisteDetail(
                                                      _ArtistList[index]),
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
                                                    child: Container(
                                                      width: 80,
                                                      height: 80,
                                                      decoration: BoxDecoration(
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
                                                        image: DecorationImage(
                                                            image: NetworkImage(
                                                              _ArtistList![
                                                                      index]
                                                                  .fieldList!
                                                                  .thumbSmall
                                                                  .toString(),
                                                            ),
                                                            fit: BoxFit.fill,
                                                            alignment: Alignment
                                                                .center),
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
                                                          padding:
                                                              EdgeInsets.only(
                                                                  bottom: 1),
                                                          child: Text(
                                                            _ArtistList![index]
                                                                .resource!
                                                                .ttl
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
                                                                      1), // Couleur RGBA (255, 255, 255) avec une opacité de 1
                                                            ),
                                                            textAlign:
                                                                TextAlign.start,
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 1),
                                                          child: Text(
                                                            _ArtistList![index]
                                                                .resource!
                                                                .rscUid
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
                                    );
                                  })),
                          Container(
                            height: 20,
                          ),
                          if (Get.find<HomeViewModel>().Miniplayer.value ==
                              true)
                            Container(
                              height: 110,
                            ),
                        ],
                      ))));
        }));
  }
}
