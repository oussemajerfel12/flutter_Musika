// ignore_for_file: deprecated_member_use, await_only_futures, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:math';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:musika/Model/SongModel.dart';
import 'package:musika/ViewModel/HomeViewModel.dart';

import 'package:musika/consts/Mygradient.dart';

import '../Model/SearchResult.dart';

import '../ViewModel/PlayViewModel.dart';

import '../consts/loading.dart';

import '../Provider/dbprovider.dart';

import '../consts/theme_data.dart';

class PlaySongView extends GetView<PlayViewModel> {
  int index;
  List<Result> list;
  //RxBool isFavorite = false.obs;
  MemoDbProvider memoDb = MemoDbProvider();

  //SongModel  item =SongModel(RscUid: result1.fieldList!.thumbSmall.toString(), ThumbSmall: Result.fieldList!.thumbSmall.toString(), Id: Id, crtr: crtr, Lien: Lien);

  bool debugPrintGestureArenaDiagnostics = false;

  PlaySongView(this.index, this.list, {super.key});

  // ignore: unnecessary_this
  void handleSongEnd() {
    if (controller.position.inMilliseconds.toDouble() ==
            controller.duration.inMilliseconds.toDouble() &&
        controller.position.inMilliseconds.toDouble() != 0) {
      if (controller.isShuffled.value == true) {
        Future.delayed(const Duration(milliseconds: 2000), () {
          controller.isRepated.value = false;

          final random = Random();
          controller.index.value = random.nextInt(controller.list1.length);

          String url = controller
              .list1[controller.index.value].primaryDocs!.link
              .toString()
              .replaceAll('https', 'http');
          controller.Stop();

          controller.Play(url);
        });
      }
    }
  }

  // ignore: unnecessary_this
  void handleSongEndNext() {
    if (controller.position.inMilliseconds >=
            controller.duration.inMilliseconds &&
        controller.position.inMilliseconds != 0) {
      Future.delayed(const Duration(milliseconds: 2000), () {
        if (controller.index.value < controller.list1.length - 1) {
          controller.index.value++;
          String url = controller
              .list1[controller.index.value].primaryDocs!.link
              .toString()
              .replaceAll('https', 'http');
          controller.Stop();
          controller.Play(url);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    SongModel item = SongModel(
        RscUid: list[controller.index.value].resource!.rscUid.toString(),
        ThumbSmall:
            list[controller.index.value].fieldList!.thumbSmall.toString(),
        Id: list[controller.index.value].resource!.id.toString(),
        Crtr: list[controller.index.value].resource!.crtr.toString(),
        Lien: list[controller.index.value].primaryDocs!.link.toString());
    Get.lazyPut(() => PlayViewModel());
    Get.lazyPut(() => HomeViewModel());
    // RxBool isFavorite = false.obs;
    //final isFavorite = isFavoriteValue.obs;

    final box = GetStorage();
    return Obx(() {
      return FutureBuilder(
          future: Future.wait([
            MemoDbProvider().findFavMusic(
                list[controller.index.value].resource!.rscUid.toString()),
            MemoDbProvider().addItemRecent(item)
          ]),
          builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (!snapshot.hasData) {
              return Scaffold(
                body: loading(),
              );
            }
            int songf = snapshot.data![0];

            if (songf == 0) {
              controller.IsFavoriteS.value = false;
            } else {
              controller.IsFavoriteS.value = true;
            }
            if (controller.isShuffled.value == true) {
              handleSongEnd();
            }

            return Scaffold(
              appBar: AppBar(
                elevation: 0,
                title: Text(""),
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF6E0D67),
                        Color(0xFF620F60),
                        Color(0xFF3E1154),
                      ],
                      stops: [0, 0.44, 1],
                      transform: GradientRotation(360 * 3.1415927 / 180),
                    ),
                  ),
                ),
                leading: IconButton(
                    icon: Image.asset(
                      'lib/Resources/drawable/collapsed_icon.png',
                      color: Styles.themeData(
                              controller.getStorge.read("isDarkMode"), context)
                          .primaryColorLight,
                      width: 50,
                    ),
                    onPressed: () {
                      Get.find<HomeViewModel>().Miniplayer.value = true;

                      Navigator.pop(context);
                    }),
                //backgroundColor: Color.fromRGBO(62, 17, 84, 1),
                centerTitle: true,
              ),
              body: Center(
                child: Container(
                    height: MediaQuery.of(context).size.height,
                    decoration:
                        BoxDecoration(gradient: MyGradient.getGradient()),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // ignore: prefer_const_constructors
                        SizedBox(
                          height: 10,
                        ),
                        CircleAvatar(
                            radius: 150,
                            backgroundColor: Color.fromRGBO(255, 255, 255, 0.57)
                                .withOpacity(0.20),
                            backgroundImage: NetworkImage(
                              controller.list1[controller.index.value]
                                  .fieldList!.thumbSmall
                                  .toString(),
                            )),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.15 / 3,
                        ),
                        Text(
                          controller.index.value == index
                              ? list[index].resource!.id.toString()
                              : list[controller.index.value]
                                  .resource!
                                  .id
                                  .toString(),
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            height: 1.5,
                            fontFamily: 'Poppins',
                            letterSpacing: 0,
                            // Additional text style properties...
                          ),
                        ),
                        Text(
                          controller.index.value == index
                              ? list[index].resource!.crtr.toString()
                              : controller
                                  .list1[controller.index.value].resource!.crtr
                                  .toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontWeight: FontWeight.normal,
                            fontSize: 18,
                            height: 1.5,
                            fontFamily: 'Poppins',
                            letterSpacing: 0,
                            // Additional text style properties...
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),

                        Wrap(children: [
                          GetBuilder<PlayViewModel>(
                            builder: (controller) => Stack(
                              alignment: Alignment.center,
                              children: [
                                Obx(() {
                                  final position = controller.position;
                                  final duration = controller.duration;
                                  return SliderTheme(
                                    data: SliderThemeData(
                                      thumbShape: RoundSliderThumbShape(
                                          enabledThumbRadius: 4.0),
                                      trackHeight: 2.0,
                                    ),
                                    child: Slider(
                                      min: 0,
                                      max: duration.inMilliseconds.toDouble(),
                                      value: position.inMilliseconds.toDouble(),
                                      onChanged: (value) {
                                        final position = Duration(
                                            milliseconds: value.round());
                                        controller.seekTo(position);
                                      },
                                      activeColor: Color(0xFFF700B4),
                                      inactiveColor:
                                          Color(0xFFFFFFFF).withOpacity(0.2),
                                    ),
                                  );
                                }),
                                Positioned(
                                  bottom: -4,
                                  left: 24,
                                  child: Obx(() => Text(
                                        "${(controller.position.inMinutes.remainder(60).toString().padLeft(2, '0'))}:${(controller.position.inSeconds.remainder(60)).toString().padLeft(2, '0')} ",
                                        style: Styles.themeData(
                                                controller.getStorge
                                                    .read("isDarkMode"),
                                                context)
                                            .textTheme
                                            .headline3,
                                      )),
                                ),
                                Obx(() {
                                  return Positioned(
                                    bottom: -4,
                                    right: 22,
                                    child: Text(
                                      '${controller.duration.inMinutes.remainder(60).toString().padLeft(2, '0')}:${(controller.duration.inSeconds.remainder(60)).toString().padLeft(2, '0')}',
                                      style: Styles.themeData(
                                              controller.getStorge
                                                  .read("isDarkMode"),
                                              context)
                                          .textTheme
                                          .headline3,
                                    ),
                                  );
                                }),
                                Container(
                                  height: 55,
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.3 / 3),
                          Container(
                            padding: EdgeInsets.fromLTRB(40, 0, 8, 8),
                            width: MediaQuery.of(context).size.width,
                            child: GetBuilder<PlayViewModel>(
                              builder: (controller) => Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      height: 30,
                                      child: GestureDetector(
                                        onTap: () {
                                          if (controller.isShuffled.value ==
                                              false) {
                                            controller.isShuffled.value = true;
                                            controller.isRepated.value = false;
                                            print(controller.isShuffled.value);
                                          } else {
                                            controller.isShuffled.value = false;
                                            print(controller.isShuffled.value);
                                          }
                                        },
                                        child: AnimatedSwitcher(
                                          duration: Duration(milliseconds: 3),
                                          switchInCurve: Curves.easeIn,
                                          switchOutCurve: Curves.easeOut,
                                          child: Container(
                                            width: 30,
                                            height: 25,
                                            child: Obx(() => ImageIcon(
                                                  size: 0,
                                                  color: controller
                                                          .isShuffled.value
                                                      ? Color.fromRGBO(
                                                          247, 0, 180, 1)
                                                      : Styles.themeData(
                                                              controller
                                                                  .getStorge
                                                                  .read(
                                                                      "isDarkMode"),
                                                              context)
                                                          .primaryColorLight,
                                                  AssetImage(
                                                    'lib/Resources/drawable/shuffle_1.png',
                                                  ),
                                                  key: ValueKey<bool>(controller
                                                      .isShuffled.value),
                                                )),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 40,
                                      padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                      child: IconButton(
                                        icon: Image.asset(
                                          'lib/Resources/drawable/previous.png',
                                          color: Styles.themeData(
                                                  controller.getStorge
                                                      .read("isDarkMode"),
                                                  context)
                                              .primaryColorLight,
                                        ),
                                        onPressed: () async {
                                          controller.playPreviousSong();
                                        },
                                      ),
                                    ),
                                    Container(
                                      height: 40,
                                      padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                      child: GestureDetector(
                                        onTap: () {
                                          if (controller.isPlayed.value) {
                                            controller.pause();
                                            controller.isPlayed.value = false;

                                            controller.update();
                                          } else {
                                            controller.resume();
                                            controller.isPlayed.value = true;
                                            // MemoDbProvider().addItemRecent(item);
                                            controller.update();
                                          }
                                        },
                                        child: AnimatedSwitcher(
                                          duration: Duration(milliseconds: 3),
                                          switchInCurve: Curves.easeIn,
                                          switchOutCurve: Curves.easeOut,
                                          child: Container(
                                            width: 40,
                                            height: 40,
                                            child: ImageIcon(
                                              size: 40,
                                              color: Styles.themeData(
                                                      controller.getStorge
                                                          .read("isDarkMode"),
                                                      context)
                                                  .primaryColorLight,
                                              AssetImage(
                                                controller.isPlayed.value
                                                    ? 'lib/Resources/drawable/pause.png'
                                                    : 'lib/Resources/drawable/reprend.png',
                                              ),
                                              key: ValueKey<bool>(
                                                  controller.isPlayed.value),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 40,
                                      padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                      child: IconButton(
                                        icon: Image.asset(
                                          'lib/Resources/drawable/next.png',
                                          color: Styles.themeData(
                                                  controller.getStorge
                                                      .read("isDarkMode"),
                                                  context)
                                              .primaryColorLight,
                                        ),
                                        onPressed: () async {
                                          controller.playNextSong();
                                        },
                                      ),
                                    ),
                                    Container(
                                      height: 40,
                                      padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                      child: GestureDetector(
                                        onTap: () {
                                          if (controller.isRepated.value ==
                                              false) {
                                            controller.isRepated.value = true;
                                            controller.isShuffled.value = false;
                                          } else {
                                            controller.isRepated.value = false;
                                          }
                                        },
                                        child: AnimatedSwitcher(
                                          duration: Duration(milliseconds: 3),
                                          switchInCurve: Curves.easeIn,
                                          switchOutCurve: Curves.easeOut,
                                          child: Container(
                                            width: 35,
                                            height: 35,
                                            child: Obx(() => ImageIcon(
                                                  size: 40,
                                                  color: Get.find<
                                                              PlayViewModel>()
                                                          .isRepated
                                                          .value
                                                      ? Color.fromRGBO(
                                                          247, 0, 180, 1)
                                                      : Styles.themeData(
                                                              controller
                                                                  .getStorge
                                                                  .read(
                                                                      "isDarkMode"),
                                                              context)
                                                          .primaryColorLight,
                                                  AssetImage(
                                                    'lib/Resources/drawable/repeat_01.png',
                                                  ),
                                                  key: ValueKey<bool>(controller
                                                      .isRepated.value),
                                                )),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            child: GetBuilder<PlayViewModel>(
                              builder: (controller) => Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      child: GestureDetector(
                                        onTap: () {},
                                        child: AnimatedSwitcher(
                                          duration: Duration(milliseconds: 3),
                                          switchInCurve: Curves.easeIn,
                                          switchOutCurve: Curves.easeOut,
                                          child: Visibility(
                                            visible: false,
                                            child: Container(
                                              width: 30,
                                              height: 30,
                                              child: Obx(() => ImageIcon(
                                                    size: 40,
                                                    color: Styles.themeData(
                                                            controller.getStorge
                                                                .read(
                                                                    "isDarkMode"),
                                                            context)
                                                        .primaryColorLight,
                                                    AssetImage(
                                                      'lib/Resources/drawable/playlist_01.png',
                                                    ),
                                                    key: ValueKey<bool>(
                                                        controller
                                                            .IsFavoriteS.value),
                                                  )),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.67,
                                    ),
                                    Container(
                                      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                      child: GestureDetector(
                                        onTap: () {
                                          if (controller.IsFavoriteS.value ==
                                              false) {
                                            MemoDbProvider().addItem(item);
                                            controller.IsFavoriteS.value = true;
                                          } else {
                                            MemoDbProvider().deleteSong(
                                                item.RscUid.toString());
                                            controller.IsFavoriteS.value =
                                                false;
                                          }
                                        },
                                        child: AnimatedSwitcher(
                                          duration: Duration(milliseconds: 3),
                                          switchInCurve: Curves.easeIn,
                                          switchOutCurve: Curves.easeOut,
                                          child: Container(
                                            width: 30,
                                            height: 30,
                                            child: Obx(() => ImageIcon(
                                                  size: 40,
                                                  color: controller
                                                          .IsFavoriteS.value
                                                      ? Color.fromRGBO(
                                                          247, 0, 180, 1)
                                                      : Styles.themeData(
                                                              controller
                                                                  .getStorge
                                                                  .read(
                                                                      "isDarkMode"),
                                                              context)
                                                          .primaryColorLight,
                                                  AssetImage(
                                                    'lib/Resources/drawable/heart_01.png',
                                                  ),
                                                  key: ValueKey<bool>(controller
                                                      .IsFavoriteS.value),
                                                )),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ]),
                      ],
                    )),
              ),
            );
          });
    });
  }
}
