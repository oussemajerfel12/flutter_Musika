// ignore_for_file: prefer_const_constructors, sort_child_properties_last, unnecessary_new

import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:musika/Model/SongModel.dart';
import 'package:musika/Provider/dbprovider.dart';
import 'package:musika/View/playSongView.dart';
import 'package:musika/ViewModel/HomeViewModel.dart';
import 'package:musika/binding/HomeBinding.dart';

import '../Model/SearchResult.dart';
import '../Model/ArtisteModel.dart';

import '../Model/TranslationService.dart';
import '../ViewModel/ArtisteViewModel.dart';
import '../ViewModel/PlayViewModel.dart';
import '../consts/Mygradient.dart';
import '../consts/loading.dart';
import '../consts/no_internet.dart';
import '../consts/theme_data.dart';
import 'package:share_plus/share_plus.dart';

import 'AlbumView.dart';
import 'package:marquee/marquee.dart';

class ArtisteDetail extends GetView<ArtisteViewModel> {
  Result result;
  late final item = ArtisteModel(
      RscUid: result.resource!.rscUid.toString(),
      ttl: result.resource!.ttl.toString(),
      Id: result.resource!.id.toString(),
      ThumbSmall: result.fieldList!.thumbSmall.toString());

  bool debugPrintGestureArenaDiagnostics = false;
  TextDirection tt = TranslationService().textDirection;
  ArtisteDetail(this.result, {super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ArtisteViewModel());
    final HomeViewModel c = Get.put(HomeViewModel());
    final PlayViewModel c1 = Get.put(PlayViewModel());
    return FutureBuilder(
        future: Future.wait([
          controller.Artiste_Titre(item.ttl.toString()),
          controller.Artiste_Album(item.ttl.toString()),
          MemoDbProvider().FindArtiste(item.RscUid.toString())
        ]),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (!snapshot.hasData) {
            return Scaffold(
              body: loading(),
            );
          }

          List<Result>? _Titrehot = snapshot.data![0];
          List<Result>? _Album = snapshot.data![1];
          int artf = snapshot.data![2];
          if (_Titrehot!.length > 0) {
            if (artf == 0) {
              controller.IsArtisteF.value = false;
            } else {
              controller.IsArtisteF.value = true;
            }
            return Scaffold(
                //appbar
                appBar: AppBar(
                  backgroundColor: Color.fromRGBO(62, 17, 84, 1),
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
                      controller.IsShuffledF.value = false;
                    },
                  ),
                  actions: [
                    Row(children: [
                      Container(),
                      SizedBox(width: 300),
                      Container(
                        child: IconButton(
                          icon: Image.asset(
                            'lib/Resources/drawable/share_1.png',
                            width: 50,
                          ),
                          onPressed: () async {
                            Share.share(
                              //result.resource!.rscUid.toString(),
                              result.friendlyUrl.toString(),
                            );
                          },
                        ),
                      ),
                    ]),
                  ],
                  centerTitle: true,
                ),
                body: Directionality(
                    textDirection: TranslationService().textDirection,
                    child: Container(
                      padding: EdgeInsets.all(2),
                      decoration:
                          BoxDecoration(gradient: MyGradient.getGradient()),
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              child: Column(children: [
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 20,
                                              top: 20,
                                              bottom: 10,
                                              right: 20),
                                          child: Container(
                                            child: Column(children: [
                                              Container(
                                                  width: 190.0,
                                                  height: 190.0,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Styles.themeData(
                                                                controller
                                                                    .getStorge
                                                                    .read(
                                                                        "isDarkMode"),
                                                                context)
                                                            .primaryColorLight
                                                            .withOpacity(0.1),
                                                      ),
                                                    ],
                                                    image: DecorationImage(
                                                        image: NetworkImage(
                                                            item!.ThumbSmall
                                                                .toString()),
                                                        fit: BoxFit.fill),
                                                  )),
                                            ]),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(
                                              left: 10, top: 30, right: 10),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        c1.isShuffled.value =
                                                            false;
                                                        if (controller
                                                                .IsShuffledF
                                                                .value ==
                                                            false) {
                                                          var index = 0;
                                                          controller.IsShuffledF
                                                              .value = true;

                                                          if (c.Miniplayer
                                                                  .value ==
                                                              false) {
                                                            Navigator.of(
                                                                    context)
                                                                .push(
                                                                    MaterialPageRoute(
                                                              builder: (context) =>
                                                                  PlaySongView(
                                                                      index,
                                                                      _Titrehot),
                                                            ));

                                                            Get.find<
                                                                    PlayViewModel>()
                                                                .playSongg(
                                                                    _Titrehot,
                                                                    index);

                                                            Get.find<
                                                                    PlayViewModel>()
                                                                .Play(_Titrehot[
                                                                        index]
                                                                    .primaryDocs!
                                                                    .link
                                                                    .toString()
                                                                    .replaceAll(
                                                                        'https',
                                                                        'http'));
                                                          } else {
                                                            Get.find<
                                                                    PlayViewModel>()
                                                                .Stop();
                                                            Get.find<
                                                                    PlayViewModel>()
                                                                .playSongg(
                                                                    _Titrehot,
                                                                    index);
                                                            Get.find<
                                                                    PlayViewModel>()
                                                                .Play(_Titrehot[
                                                                        index]
                                                                    .primaryDocs!
                                                                    .link
                                                                    .toString()
                                                                    .replaceAll(
                                                                        'https',
                                                                        'http'));

                                                            Get.find<
                                                                    PlayViewModel>()
                                                                .update();
                                                          }
                                                        } else {
                                                          controller.IsShuffledF
                                                              .value = false;

                                                          Get.find<
                                                                  PlayViewModel>()
                                                              .Stop();
                                                          Get.find<
                                                                  HomeViewModel>()
                                                              .Miniplayer
                                                              .value = false;
                                                        }
                                                      },
                                                      child: AnimatedSwitcher(
                                                        duration: Duration(
                                                            milliseconds: 3),
                                                        switchInCurve:
                                                            Curves.easeIn,
                                                        switchOutCurve:
                                                            Curves.easeOut,
                                                        child: Container(
                                                          width: 35,
                                                          height: 35,
                                                          child:
                                                              Obx(
                                                                  () =>
                                                                      ImageIcon(
                                                                        size:
                                                                            20,
                                                                        color: controller.IsShuffledF.value
                                                                            ? Color.fromRGBO(
                                                                                247,
                                                                                0,
                                                                                180,
                                                                                1)
                                                                            : Styles.themeData(controller.getStorge.read("isDarkMode"), context).primaryColorLight,
                                                                        AssetImage(
                                                                          'lib/Resources/drawable/play_01.png',
                                                                        ),
                                                                        key: ValueKey<bool>(controller
                                                                            .IsShuffledF
                                                                            .value),
                                                                      )),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 10),
                                              Row(
                                                children: [
                                                  SizedBox(height: 10),
                                                  Container(
                                                    width: 60,
                                                    height: 50,
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        if (controller
                                                                .IsArtisteF
                                                                .value ==
                                                            false) {
                                                          controller.IsArtisteF
                                                              .value = true;

                                                          MemoDbProvider()
                                                              .addartiste(item);
                                                        } else {
                                                          controller.IsArtisteF
                                                              .value = false;

                                                          MemoDbProvider()
                                                              .deleteArtisteF(item
                                                                      .RscUid
                                                                  .toString());
                                                        }
                                                      },
                                                      child: AnimatedSwitcher(
                                                        duration: Duration(
                                                            milliseconds: 3),
                                                        switchInCurve:
                                                            Curves.easeIn,
                                                        switchOutCurve:
                                                            Curves.easeOut,
                                                        child: Container(
                                                          width: 35,
                                                          height: 35,
                                                          child:
                                                              Obx(
                                                                  () =>
                                                                      ImageIcon(
                                                                        size:
                                                                            20,
                                                                        color: controller.IsArtisteF.value
                                                                            ? Color.fromRGBO(
                                                                                247,
                                                                                0,
                                                                                180,
                                                                                1)
                                                                            : Styles.themeData(controller.getStorge.read("isDarkMode"), context).primaryColorLight,
                                                                        AssetImage(
                                                                          'lib/Resources/drawable/heart_01.png',
                                                                        ),
                                                                        key: ValueKey<bool>(controller
                                                                            .IsArtisteF
                                                                            .value),
                                                                      )),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 10),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Align(
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 62),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          child: Text(
                                            item.ttl.toString(),
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
                              ]),
                            ),
                            IntrinsicHeight(
                              child: Container(
                                padding: EdgeInsets.only(
                                        left: tt == TextDirection.rtl ? 5 : 18,
                                        top: 45,
                                        bottom: 0,
                                        right: tt == TextDirection.rtl ? 19 : 5)
                                    .resolve(TextDirection.ltr),
                                height: 80,
                                width: MediaQuery.of(context).size.width,
                                child: Text(
                                  'Songs'.tr,
                                  textAlign: tt == TextDirection.rtl
                                      ? TextAlign.right
                                      : TextAlign.start,
                                  style: Styles.themeData(
                                          controller.getStorge
                                              .read("isDarkMode"),
                                          context)
                                      .textTheme
                                      .headline1,
                                ),
                              ),
                            ),
                            Flexible(
                              child: Container(
                                height: 165,
                                width: MediaQuery.of(context).size.width,
                                child: ListView.builder(
                                  shrinkWrap: false,
                                  scrollDirection: Axis.vertical,
                                  itemCount: _Titrehot?.length,
                                  itemBuilder:
                                      (BuildContext context, int index) =>
                                          GestureDetector(
                                    onTap: () {
                                      c1.isRepated.value = false;
                                      c1.isShuffled.value = false;
                                      if (c.Miniplayer.value == false) {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) =>
                                              PlaySongView(index, _Titrehot),
                                        ));
                                        Get.find<PlayViewModel>()
                                            .playSongg(_Titrehot, index);
                                        Get.find<PlayViewModel>().Play(
                                            _Titrehot[index]
                                                .primaryDocs!
                                                .link
                                                .toString()
                                                .replaceAll('https', 'http'));
                                      } else {
                                        Get.find<PlayViewModel>().Stop();
                                        Get.find<PlayViewModel>()
                                            .playSongg(_Titrehot, index);
                                        Get.find<PlayViewModel>().update();
                                        Get.find<PlayViewModel>().Play(
                                            _Titrehot[index]
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
                                                  255, 255, 255, 0.57)
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
                                                      BorderRadius.circular(
                                                          250),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Color.fromRGBO(255,
                                                              255, 255, 0.57)
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
                                                      _Titrehot![index]
                                                          .resource!
                                                          .id
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
                                                            _Titrehot![index]
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
                                                            textAlign:
                                                                TextAlign.start,
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
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 90,
                              padding: EdgeInsets.only(
                                left: tt == TextDirection.rtl ? 5 : 18,
                                top: 45,
                                bottom: 0,
                                right: tt == TextDirection.rtl ? 19 : 5,
                              ).resolve(TextDirection.ltr),
                              child: Text(
                                'Albums'.tr,
                                textAlign: tt == TextDirection.rtl
                                    ? TextAlign.right
                                    : TextAlign.start,
                                style: Styles.themeData(
                                        controller.getStorge.read("isDarkMode"),
                                        context)
                                    .textTheme
                                    .headline1,
                              ),
                            ),
                            Flexible(
                              child: Container(
                                height: 250,
                                width: MediaQuery.of(context).size.width * 0.93,
                                child: ListView.builder(
                                  shrinkWrap: false,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: _Album?.length,
                                  itemBuilder:
                                      (BuildContext context, int index) =>
                                          Center(
                                              child: Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.45,
                                    height: 250,
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
                                                  AlbumView(_Album[index]),
                                            ));
                                          },
                                          child: Column(
                                            children: [
                                              Container(
                                                width: 150,
                                                height: 150,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Styles.themeData(
                                                              controller
                                                                  .getStorge
                                                                  .read(
                                                                      "isDarkMode"),
                                                              context)
                                                          .primaryColorLight
                                                          .withOpacity(0.1),
                                                    ),
                                                  ],
                                                  image: DecorationImage(
                                                    image: NetworkImage(
                                                      _Album![index]
                                                          .fieldList!
                                                          .thumbSmall
                                                          .toString(),
                                                    ),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 15,
                                                width: 20,
                                              ),
                                              Container(
                                                height: 60,
                                                width: 150,
                                                child: Text(
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  _Album![index]
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
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                                ),
                              ),
                            ),
                            Container(
                              height: 140,
                            )
                          ],
                        ),
                      ),
                    )));
          } else {
            return Scaffold(body: no_internet());
          }
        });
  }
}
