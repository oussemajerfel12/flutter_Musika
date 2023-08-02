// ignore_for_file: deprecated_member_use, await_only_futures, prefer_const_constructors

import 'dart:math';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:musika/Model/SongModel.dart';
import 'package:musika/ViewModel/HomeViewModel.dart';
import 'package:musika/binding/HomeBinding.dart';

import '../Model/SearchResult.dart';

import '../ViewModel/PlayViewModel.dart';

import 'libraryView.dart';
import '../Provider/dbprovider.dart';

import '../consts/theme_data.dart';

class PlayView extends GetView<PlayViewModel> {
  Result result;

  MemoDbProvider memoDb = MemoDbProvider();

  // ignore: unnecessary_cast
  late final item = SongModel(
    RscUid: result.resource!.rscUid.toString(),
    ThumbSmall: result.fieldList!.thumbSmall.toString(),
    Id: result.resource!.id.toString(),
    Crtr: result.resource!.crtr.toString(),
    Lien: result.primaryDocs!.link.toString(),
  );

  //SongModel  item =SongModel(RscUid: result1.fieldList!.thumbSmall.toString(), ThumbSmall: Result.fieldList!.thumbSmall.toString(), Id: Id, crtr: crtr, Lien: Lien);

  bool debugPrintGestureArenaDiagnostics = false;

  PlayView(this.result, {super.key});

  // ignore: unnecessary_this

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => PlayViewModel());
    Get.lazyPut(() => HomeViewModel());

    late SongModel? item = SongModel(
        RscUid: result.resource!.rscUid.toString(),
        ThumbSmall: result.fieldList!.thumbSmall.toString(),
        Id: result.resource!.id.toString(),
        Crtr: result.resource!.crtr.toString(),
        Lien: result.primaryDocs!.link.toString());

    return Scaffold(
      backgroundColor:
          Styles.themeData(controller.getStorge.read("isDarkMode"), context)
              .primaryColor,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(62, 17, 84, 1),
        title: Text(""),
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
      ),
      body: Center(
        child: Container(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // ignore: prefer_const_constructors
            SizedBox(
              height: 25,
            ),
            CircleAvatar(
                radius: 100,
                backgroundColor: Colors.black.withOpacity(0.1),
                backgroundImage: NetworkImage(
                  result.fieldList!.thumbSmall.toString(),
                )),
            SizedBox(
              height: 7,
            ),
            Text(
              result.resource!.id.toString(),
              style: Styles.themeData(
                      controller.getStorge.read("isDarkMode"), context)
                  .textTheme
                  .headline1,
            ),
            Text(
              result.resource!.crtr.toString(),
              style: Styles.themeData(
                      controller.getStorge.read("isDarkMode"), context)
                  .textTheme
                  .headline2,
            ),
            const Image(
              image: AssetImage('lib/Resources/drawable/playanimation.png'),
              width: 1000,
              alignment: Alignment.center,
            ),
            Wrap(children: [
              GetBuilder<PlayViewModel>(
                builder: (controller) => Center(
                  child: Column(children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        if (controller.isPlayed.value) {
                          controller.pause();
                          controller.isPlayed.value = false;

                          controller.update();
                        } else {
                          controller.resume();
                          controller.isPlayed.value = true;
                          MemoDbProvider().addItemRecent(item);
                          controller.update();
                        }
                      },
                      child: AnimatedSwitcher(
                        duration: Duration(milliseconds: 3),
                        switchInCurve: Curves.easeIn,
                        switchOutCurve: Curves.easeOut,
                        child: Icon(
                          controller.isPlayed.value
                              ? Icons.pause
                              : Icons.play_arrow,
                          key: ValueKey<bool>(controller.isPlayed.value),
                          size: 40,
                          color: Styles.themeData(
                                  controller.getStorge.read("isDarkMode"),
                                  context)
                              .primaryColorLight,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: new Icon(Icons.skip_next),
                      onPressed: () async {
                        // controller.nextSong();
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Obx(() {
                          final position = controller.position;
                          final duration = controller.duration;

                          return Slider(
                            min: 0,
                            max: duration!.inMilliseconds.toDouble(),
                            value: position.inMilliseconds.toDouble(),
                            onChanged: (value) {
                              final position =
                                  Duration(milliseconds: value.round());

                              controller.seekTo(position);
                            },
                            activeColor: Colors.white,
                            inactiveColor: Colors.grey,
                          );
                        }),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          child: Obx(() => Text(
                              "${(controller.position.inMinutes.remainder(60).toString().padLeft(2, '0'))}:${(controller.position.inSeconds.remainder(60)).toString().padLeft(2, '0')} ",
                              style: Styles.themeData(
                                      controller.getStorge.read("isDarkMode"),
                                      context)
                                  .textTheme
                                  .headline2)),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Text(
                            '${controller.duration.inMinutes.remainder(60).toString().padLeft(2, '0')}:${(controller.duration.inSeconds.remainder(60)).toString().padLeft(2, '0')}',
                            style: Styles.themeData(
                                    controller.getStorge.read("isDarkMode"),
                                    context)
                                .textTheme
                                .headline2,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: new Icon(Icons.favorite),
                      onPressed: () async {
                        await memoDb.addItem(item);
                      },
                    )
                  ]),
                ),
              )
            ]),
          ],
        )),
      ),
    );
  }
}
