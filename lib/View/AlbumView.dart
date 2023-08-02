// ignore_for_file: deprecated_member_use, sort_child_properties_last, prefer_const_constructors, prefer_is_empty

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:musika/Model/SongModel.dart';
import 'package:musika/View/playSongView.dart';
import 'package:musika/ViewModel/HomeViewModel.dart';
import 'package:musika/binding/HomeBinding.dart';

import '../Model/AlbumModel.dart';
import '../Model/SearchResult.dart';
import '../Model/ArtisteModel.dart';

import '../Model/TranslationService.dart';
import '../Provider/dbprovider.dart';
import '../ViewModel/AlbumViewModel.dart';
import '../ViewModel/ArtisteViewModel.dart';
import '../ViewModel/PlayViewModel.dart';
import '../consts/loading.dart';
import '../consts/Mygradient.dart';
import '../consts/theme_data.dart';
import 'package:share_plus/share_plus.dart';
import 'package:marquee/marquee.dart';

class AlbumView extends GetView<AlbumViewModel> {
  Result result;
  late AlbumModel item = AlbumModel(
    RscUid: result.resource!.rscUid.toString(),
    thumbSmall: result.fieldList!.thumbSmall.toString(),
    ttl: result.resource!.ttl.toString(),
    Id: result.resource!.id.toString(),
    identifiant: result.fieldList!.identifier.toString(),
  );

  bool debugPrintGestureArenaDiagnostics = false;
  TextDirection tt = TranslationService().textDirection;

  AlbumView(this.result, {super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AlbumViewModel());
    final HomeViewModel c = Get.put(HomeViewModel());
    final PlayViewModel c1 = Get.put(PlayViewModel());
    return FutureBuilder(
        future: Future.wait([
          controller.Artiste_Titre(item.identifiant.toString()),
          controller.album_Sugg(item.Id.toString()),
          MemoDbProvider().FindAlbum(item.RscUid.toString())
        ]),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (!snapshot.hasData) {
            return Scaffold(
              body: loading(),
            );
          }

          List<Result>? _Titrehot = snapshot.data![0];
          List<Result>? _Sugg = snapshot.data![1];
          int artf = snapshot.data![2];

          if (artf == 0) {
            controller.IsAlbumF.value = false;
          } else {
            controller.IsAlbumF.value = true;
          }

          return Scaffold(
              backgroundColor: Color.fromRGBO(62, 17, 84, 1),
              appBar: AppBar(
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
                          color: Styles.themeData(
                                  controller.getStorge.read("isDarkMode"),
                                  context)
                              .primaryColorLight,
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
                backgroundColor: Color.fromRGBO(62, 17, 84, 1),
                elevation: 0,
                centerTitle: true,
              ),
              body: Directionality(
                  textDirection: TranslationService().textDirection,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(2, 2, 2, 2),
                    decoration:
                        BoxDecoration(gradient: MyGradient.getGradient()),
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: Column(
                              children: [
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
                                                  width: 200.0,
                                                  height: 200.0,
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
                                                            item!.thumbSmall
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
                                                        if (_Titrehot!.length !=
                                                            0) {
                                                          c1.isShuffled.value =
                                                              false;
                                                          c1.isRepated.value =
                                                              false;
                                                          var index = 0;
                                                          if (controller
                                                                  .IsShuffledF
                                                                  .value ==
                                                              false) {
                                                            controller
                                                                .IsShuffledF
                                                                .value = true;

                                                            controller
                                                                .IsShuffledF
                                                                .value = true;
                                                            c.Miniplayer.value =
                                                                true;
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
                                                                        _Titrehot!),
                                                              ));

                                                              Get.find<
                                                                      PlayViewModel>()
                                                                  .playSongg(
                                                                      _Titrehot!,
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
                                                                      _Titrehot!,
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
                                                            controller
                                                                .IsShuffledF
                                                                .value = false;

                                                            Get.find<
                                                                    PlayViewModel>()
                                                                .Stop();
                                                            Get.find<
                                                                    HomeViewModel>()
                                                                .Miniplayer
                                                                .value = false;
                                                          }
                                                        } else {
                                                          Fluttertoast.showToast(
                                                              msg:
                                                                  ' No Music Avalibale ',
                                                              toastLength: Toast
                                                                  .LENGTH_SHORT,
                                                              gravity:
                                                                  ToastGravity
                                                                      .BOTTOM,
                                                              backgroundColor:
                                                                  Color
                                                                      .fromRGBO(
                                                                          191,
                                                                          0,
                                                                          147,
                                                                          1),
                                                              textColor:
                                                                  Colors.white);
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
                                                  Container(
                                                    width: 60,
                                                    height: 50,
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        if (controller.IsAlbumF
                                                                .value ==
                                                            false) {
                                                          controller.IsAlbumF
                                                              .value = true;

                                                          MemoDbProvider()
                                                              .addAlbum(item);
                                                        } else {
                                                          controller.IsAlbumF
                                                              .value = false;

                                                          MemoDbProvider()
                                                              .deleteAlbumF(item
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
                                                                        color: controller.IsAlbumF.value
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
                                                                            .IsAlbumF
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
                                    padding: EdgeInsets.only(
                                        left: 1, top: 1, right: 1),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Center(
                                          child: SizedBox(
                                            height: 32,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.88,
                                            child: Marquee(
                                              text: item!.ttl.toString(),
                                              style: Styles.themeData(
                                                      controller.getStorge
                                                          .read("isDarkMode"),
                                                      context)
                                                  .textTheme
                                                  .headline1,
                                              scrollAxis: Axis.horizontal,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              blankSpace: 20.0,
                                              velocity: 30.0,
                                              pauseAfterRound: Duration
                                                  .zero, // Ignorer le moment d'arrêt du texte
                                              startPadding: 10.0,
                                              accelerationDuration:
                                                  Duration(seconds: 0),
                                              accelerationCurve: Curves.linear,
                                              decelerationDuration:
                                                  Duration(milliseconds: 350),
                                              decelerationCurve: Curves.easeOut,
                                              textDirection: TextDirection.rtl,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          IntrinsicHeight(
                            child: Container(
                              height: 90,
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.only(
                                      left: tt == TextDirection.rtl ? 5 : 18,
                                      top: 45,
                                      bottom: 0,
                                      right: tt == TextDirection.rtl ? 19 : 5)
                                  .resolve(TextDirection.ltr),
                              child: Text('Songs'.tr,
                                  textAlign: TextAlign.start,
                                  style: Styles.themeData(
                                          controller.getStorge
                                              .read("isDarkMode"),
                                          context)
                                      .textTheme
                                      .headline1),
                            ),
                          ),

                          //liste des Songs commence ici
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
                                    //c.Miniplayer.value = false;
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
                                        left: 16, top: 8, bottom: 2, right: 16),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        shape: BoxShape.rectangle,
                                        color: Color.fromRGBO(255, 255, 255, 1)
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
                                                    BorderRadius.circular(250),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Color.fromRGBO(
                                                            255, 255, 255, 0.57)
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
                                                              255, 255, 255, 1)
                                                          .withOpacity(
                                                              1), // Couleur RGBA (255, 255, 255) avec une opacité de 1
                                                    ),
                                                    textAlign: TextAlign.start,
                                                  ),
                                                ),
                                                Container(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
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
                                    right: tt == TextDirection.rtl ? 19 : 5)
                                .resolve(TextDirection.ltr),
                            child: Text('Suggestions'.tr,
                                textAlign: TextAlign.start,
                                style: Styles.themeData(
                                        controller.getStorge.read("isDarkMode"),
                                        context)
                                    .textTheme
                                    .headline1),
                          ),

                          Flexible(
                            child: Container(
                              height: 250,
                              width: MediaQuery.of(context).size.width * 0.93,
                              child: ListView.builder(
                                shrinkWrap: false,
                                scrollDirection: Axis.horizontal,
                                itemCount: _Sugg?.length,
                                itemBuilder:
                                    (BuildContext context, int index) => Center(
                                        child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.45,
                                  height: 250,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          if (_Sugg[index]
                                                  .resource!
                                                  .type
                                                  .toString() ==
                                              "Album") {
                                            Navigator.of(context)
                                                .push(MaterialPageRoute(
                                              builder: (context) =>
                                                  AlbumView(_Sugg[index]),
                                            ));
                                          } else {
                                            if (c.Miniplayer.value == false) {
                                              Navigator.of(context)
                                                  .push(MaterialPageRoute(
                                                builder: (context) =>
                                                    PlaySongView(index, _Sugg),
                                              ));

                                              c1.Play(_Sugg[index]
                                                  .primaryDocs!
                                                  .link
                                                  .toString()
                                                  .replaceAll('https', 'http'));
                                              c1.playSongg(_Sugg, index);
                                            } else {
                                              c1.Stop();
                                              c1.playSongg(_Sugg, index);

                                              c1.Play(_Sugg[index]
                                                  .primaryDocs!
                                                  .link
                                                  .toString()
                                                  .replaceAll('https', 'http'));
                                            }
                                          }
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
                                                            controller.getStorge
                                                                .read(
                                                                    "isDarkMode"),
                                                            context)
                                                        .primaryColorLight
                                                        .withOpacity(0.1),
                                                    spreadRadius: 2,
                                                    blurRadius: 5,
                                                    offset: Offset(0, 3),
                                                  ),
                                                ],
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                    _Sugg![index]
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
                                                overflow: TextOverflow.ellipsis,
                                                _Sugg![index]
                                                    .resource!
                                                    .id
                                                    .toString(),
                                                style: Styles.themeData(
                                                        controller.getStorge
                                                            .read("isDarkMode"),
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
        });
  }
}
