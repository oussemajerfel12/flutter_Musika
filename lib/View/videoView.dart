import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../ViewModel/videoViewModel.dart';
import '../consts/Mygradient.dart';
import '../consts/theme_data.dart';

class videoView extends GetView<videoViewModel> {
  final box = GetStorage();
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => videoViewModel());
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
          /*leading: IconButton(
              icon: Image.asset(
                'lib/Resources/drawable/collapsed_icon.png',
                color: Styles.themeData(
                        controller.getStorge.read("isDarkMode"), context)
                    .primaryColorLight,
                width: 50,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),*/
          //backgroundColor: Color.fromRGBO(62, 17, 84, 1),
          centerTitle: true,
        ),
        body: Center(
            child: Container(
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(gradient: MyGradient.getGradient()),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AspectRatio(
                        aspectRatio: 16 / 9,
                        child: BetterPlayer(
                          controller: controller.betterPlayerController,
                        ),
                      ),
                      Wrap(children: [
                        GetBuilder<videoViewModel>(
                          builder: (controller) => Stack(
                            alignment: Alignment.center,
                            children: [
                              Obx(() {
                                final position = controller.position1;
                                final duration = controller.duration1;
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
                                      final position =
                                          Duration(milliseconds: value.round());
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
                                      "${(controller.position1.inMinutes.remainder(60).toString().padLeft(2, '0'))}:${(controller.position1.inSeconds.remainder(60)).toString().padLeft(2, '0')} ",
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
                                    '${controller.duration1.inMinutes.remainder(60).toString().padLeft(2, '0')}:${(controller.duration1.inSeconds.remainder(60)).toString().padLeft(2, '0')}',
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
                          child: GetBuilder<videoViewModel>(
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
                                                            controller.getStorge
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
                                      onPressed: () async {},
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
                                      onPressed: () async {},
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
                                                            videoViewModel>()
                                                        .isRepated
                                                        .value
                                                    ? Color.fromRGBO(
                                                        247, 0, 180, 1)
                                                    : Styles.themeData(
                                                            controller.getStorge
                                                                .read(
                                                                    "isDarkMode"),
                                                            context)
                                                        .primaryColorLight,
                                                AssetImage(
                                                  'lib/Resources/drawable/repeat_01.png',
                                                ),
                                                key: ValueKey<bool>(
                                                    controller.isRepated.value),
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
                          child: GetBuilder<videoViewModel>(
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
                                                  key: ValueKey<bool>(controller
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
                                          //MemoDbProvider().addItem(item);
                                          controller.IsFavoriteS.value = true;
                                        } else {
                                          //  MemoDbProvider().deleteSong(
                                          // item.RscUid.toString());
                                          controller.IsFavoriteS.value = false;
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
                                                            controller.getStorge
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
                    ]))));
  }
}
