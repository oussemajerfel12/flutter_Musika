// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:musika/Model/SongModel.dart';
import 'package:musika/View/HomeView.dart';
import 'package:musika/consts/loading.dart';

import '../Model/SearchResult.dart';

import '../Model/TranslationService.dart';
import '../ViewModel/HomeViewModel.dart';
import '../ViewModel/PlayViewModel.dart';
import '../consts/Mygradient.dart';
import '../consts/theme_data.dart';
import 'PlayView.dart';
import '../View/playSongView.dart';
import 'package:sqflite/sqflite.dart';
import '../Provider/dbprovider.dart';
import 'package:musika/ViewModel/libraryViewModel.dart';

class RecentSongView extends GetView<HomeViewModel> {
  bool debugPrintGestureArenaDiagnostics = false;
  ScrollController _scrollController = ScrollController();

  bool isListEmpty = true;
  Result? result;
  late SongModel songModel;
  RecentSongView(this.songModel, {super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(HomeViewModel());
    Get.put(libraryViewModel());

    final libraryViewModel controllerr = Get.find<libraryViewModel>();
    final HomeViewModel c = Get.put(HomeViewModel());
    final PlayViewModel c1 = Get.put(PlayViewModel());
    Get.put(HomeViewModel());

    bool debugPrintGestureArenaDiagnostics = false;
    controllerr.fetchItemR();

    return FutureBuilder(
        future: Future.wait([
          controllerr.fRecent(),
        ]),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (!snapshot.hasData) {
            return Scaffold(
              body: loading(),
            );
          }

          RxList<SongModel>? _TitreList = snapshot.data![0];
          List<SongModel> _Recent = snapshot.data![0];
          List<Result> recently = [];

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
                            controller.getStorge.read("isDarkMode"), context)
                        .primaryColorLight,
                    width: 80,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
            body: Container(
              decoration: BoxDecoration(gradient: MyGradient.getGradient()),
              child: Directionality(
                textDirection: TranslationService().textDirection,
                child: Column(children: [
                  Flexible(
                    child: Obx(
                      () => ListView.builder(
                          primary: false,
                          shrinkWrap: true,
                          itemCount: controllerr.itemsR.length + 1,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (BuildContext context, int index) {
                            if (index == controllerr.itemsR.length) {
                              // This is the index after all items have been rendered
                              if (controllerr.hasItems.value) {
                                return GestureDetector(
                                  onTap: () {
                                    controllerr.deleteItems();
                                    controllerr.fetchItemR();
                                  },
                                  child: Container(
                                    color: Colors.transparent,
                                    height: 40,
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 8.0),
                                      child: Text(
                                        'Delete all'.tr,
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
                                return Center(
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        left: 16,
                                        top: 200,
                                        bottom: 2,
                                        right: 16),
                                    alignment: Alignment.center,
                                    child: Text(
                                      'No More Result'.tr,
                                      style: Styles.themeData(
                                              controller.getStorge
                                                  .read("isDarkMode"),
                                              context)
                                          .textTheme
                                          .headline1,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                );
                              }
                            }
                            recently.add(c.insertin(controllerr.itemsR[index]));

                            return Container(
                              // ignore: sort_child_properties_last
                              child: Center(
                                child: GestureDetector(
                                  onTap: () {
                                    //c.Miniplayer.value = false;
                                    c1.isShuffled.value = false;
                                    if (c.Miniplayer.value == false) {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) =>
                                            PlaySongView(index, recently),
                                      ));

                                      c1.Play(_TitreList[index]
                                          .Lien
                                          .toString()
                                          .replaceAll('https', 'http'));
                                      c1.playSongg(recently, index);
                                    } else {
                                      c1.Stop();
                                      c1.playSongg(recently, index);

                                      c1.Play(_TitreList[index]
                                          .Lien
                                          .toString()
                                          .replaceAll('https', 'http'));
                                    }
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 16, top: 8, bottom: 2, right: 16),
                                    child: Column(
                                      children: [
                                        Container(
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
                                                  radius:
                                                      40, // Ajustez le rayon du cercle selon vos besoins
                                                  backgroundImage: NetworkImage(
                                                    _TitreList![index]
                                                        .ThumbSmall
                                                        .toString(),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 1),
                                                      child: Text(
                                                        _TitreList![index]
                                                            .Id
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
                                                                  1), // Couleur RGBA (255, 255, 255) avec une opacité de 1
                                                        ),
                                                        textAlign:
                                                            TextAlign.start,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 1),
                                                      child: Text(
                                                        _TitreList![index]
                                                            .Crtr
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
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  ),
                  Container(
                    height: 110,
                  )
                ]),
              ),
            ),
          );
        });
  }
}
