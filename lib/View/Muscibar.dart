// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:musika/Model/SongModel.dart';
import 'package:musika/View/ArtistViewAll.dart';
import 'package:musika/View/playSongView.dart';
import 'package:musika/ViewModel/AlbumViewModel.dart';
import 'package:musika/ViewModel/ArtisteViewModel.dart';
import 'package:musika/ViewModel/HomeViewModel.dart';
import 'package:musika/binding/HomeBinding.dart';

import '../Model/SearchResult.dart';

import '../ViewModel/PlayViewModel.dart';

import '../consts/Mygradient.dart';
import 'PlayView.dart';
import 'libraryView.dart';
import '../Provider/dbprovider.dart';

import '../consts/theme_data.dart';
import 'package:musika/ViewModel/PlayViewModel.dart';
import 'package:marquee/marquee.dart';

class MusicBar extends GetView<PlayViewModel> {
  final PlayViewModel controller = Get.put(PlayViewModel());
  late Result result;
  late List<Result> list1;

  @override
  Widget build(BuildContext context) {
    late SongModel? item = SongModel(
        RscUid: list1[controller.index.value].resource!.rscUid.toString(),
        ThumbSmall:
            list1[controller.index.value].fieldList!.thumbSmall.toString(),
        Id: list1[controller.index.value].resource!.id.toString(),
        Crtr: list1[controller.index.value].resource!.crtr.toString(),
        Lien: list1[controller.index.value].primaryDocs!.link.toString());
    return Obx(() {
      controller.handleSongEnd();

      return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PlaySongView(
                      Get.find<PlayViewModel>().index.value,
                      Get.find<PlayViewModel>().list1)),
            );
          },
          onPanEnd: (details) {
            if (details.velocity.pixelsPerSecond.dy < 10) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PlaySongView(
                        Get.find<PlayViewModel>().index.value,
                        Get.find<PlayViewModel>().list1)),
              );
            }
          },
          child: Container(
            decoration: BoxDecoration(gradient: MyGradient.getGradient2()),
            height: 110,
            child: Dismissible(
                key: Key(
                    'container_key'), // Clé unique pour le widget Dismissible
                direction: DismissDirection
                    .horizontal, // Direction de glissement pour fermer le container
                onDismissed: (direction) {
                  // Action à effectuer lors de la fermeture du container

                  controller.Stop();
                  Get.find<HomeViewModel>().Miniplayer.value = false;
                  Get.find<AlbumViewModel>().IsShuffledF.value = false;
                  Get.find<ArtisteViewModel>().IsShuffledF.value = false;
                },
                child: Container(
                  child: Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          child: Row(
                            children: [
                              Expanded(
                                child: IconButton(
                                  onPressed: () {
                                    controller.Stop();
                                    Get.find<HomeViewModel>().Miniplayer.value =
                                        false;
                                    Get.find<AlbumViewModel>()
                                        .IsShuffledF
                                        .value = false;
                                    Get.find<ArtisteViewModel>()
                                        .IsShuffledF
                                        .value = false;
                                  },
                                  icon: Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    size: 22,
                                  ),
                                  alignment: Alignment
                                      .centerRight, // Ajustez l'alignement selon vos besoins
                                  padding: EdgeInsets.only(
                                      right: 15.0,
                                      top:
                                          1), // Ajustez la valeur du padding selon vos besoins
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex:
                            5, // Ajout de la propriété flex pour rendre cette partie plus grande
                        child: Container(
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 16, right: 16),
                                child: CircleAvatar(
                                  backgroundColor:
                                      Color.fromRGBO(255, 255, 255, 0.57)
                                          .withOpacity(0.20),
                                  radius: 25,
                                  backgroundImage: NetworkImage(
                                    controller
                                        .list1[Get.find<PlayViewModel>()
                                            .index
                                            .value]
                                        .fieldList!
                                        .thumbSmall
                                        .toString(),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 32,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Get.find<PlayViewModel>()
                                                    .list1[Get.find<
                                                            PlayViewModel>()
                                                        .index
                                                        .value]
                                                    .resource!
                                                    .id
                                                    .toString()
                                                    .length >
                                                20
                                            ? Marquee(
                                                text: Get.find<PlayViewModel>()
                                                    .list1[Get.find<
                                                            PlayViewModel>()
                                                        .index
                                                        .value]
                                                    .resource!
                                                    .id
                                                    .toString(),
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                  fontSize: 15.5,
                                                ),
                                                scrollAxis: Axis.horizontal,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                blankSpace: 20.0,
                                                velocity: 30.0,
                                                pauseAfterRound: Duration.zero,
                                                startPadding: 10.0,
                                                accelerationDuration:
                                                    Duration(seconds: 0),
                                                accelerationCurve:
                                                    Curves.linear,
                                                decelerationDuration:
                                                    Duration(milliseconds: 100),
                                                decelerationCurve:
                                                    Curves.easeOut,
                                              )
                                            : Text(
                                                Get.find<PlayViewModel>()
                                                    .list1[Get.find<
                                                            PlayViewModel>()
                                                        .index
                                                        .value]
                                                    .resource!
                                                    .id
                                                    .toString(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                  fontSize: 15.5,
                                                ),
                                              ),
                                      ),
                                      Text(
                                        (Get.find<PlayViewModel>()
                                                    .list1[Get.find<
                                                            PlayViewModel>()
                                                        .index
                                                        .value]
                                                    .resource!
                                                    .crtr
                                                    .toString()
                                                    .length >
                                                20)
                                            ? '...${Get.find<PlayViewModel>().list1[Get.find<PlayViewModel>().index.value].resource!.crtr.toString().substring(0, 20)}'
                                            : Get.find<PlayViewModel>()
                                                .list1[Get.find<PlayViewModel>()
                                                    .index
                                                    .value]
                                                .resource!
                                                .crtr
                                                .toString(),
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                        maxLines: 1,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Wrap(
                                children: [
                                  Container(
                                    child: Row(
                                      children: [
                                        IconButton(
                                          icon: ImageIcon(
                                            size: 15,
                                            color: Styles.themeData(
                                                    controller.getStorge
                                                        .read("isDarkMode"),
                                                    context)
                                                .primaryColorLight,
                                            AssetImage(
                                                'lib/Resources/drawable/previous.png'),
                                          ),
                                          onPressed: () async {
                                            controller.playPreviousSong();
                                          },
                                        ),
                                        SizedBox(width: 10),
                                        Wrap(children: [
                                          GetBuilder<PlayViewModel>(
                                            builder: (controller) => Center(
                                              child: Column(children: <Widget>[
                                                GestureDetector(
                                                  onTap: () {
                                                    if (controller
                                                        .isPlayed.value) {
                                                      controller.pause();

                                                      controller.isPlayed
                                                          .value = false;

                                                      controller.update();
                                                    } else {
                                                      controller.resume();

                                                      controller.isPlayed
                                                          .value = true;

                                                      controller.update();
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
                                                      child: ImageIcon(
                                                        size: 30,
                                                        color: Styles.themeData(
                                                                controller
                                                                    .getStorge
                                                                    .read(
                                                                        "isDarkMode"),
                                                                context)
                                                            .primaryColorLight,
                                                        AssetImage(
                                                          controller.isPlayed
                                                                  .value
                                                              ? 'lib/Resources/drawable/pause.png'
                                                              : 'lib/Resources/drawable/reprend.png',
                                                        ),
                                                        key: ValueKey<bool>(
                                                            controller.isPlayed
                                                                .value),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ]),
                                            ),
                                          )
                                        ]),
                                        SizedBox(width: 10),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            IconButton(
                                              icon: ImageIcon(
                                                size: 15,
                                                color: Styles.themeData(
                                                        controller.getStorge
                                                            .read("isDarkMode"),
                                                        context)
                                                    .primaryColorLight,
                                                AssetImage(
                                                    'lib/Resources/drawable/next.png'),
                                              ),
                                              onPressed: () async {
                                                controller.playNextSong();
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: Row(
                            children: [
                              Expanded(
                                child: Stack(
                                  children: [
                                    Obx(() {
                                      final position = controller.position;
                                      final duration = controller.duration;

                                      return SliderTheme(
                                          data: SliderThemeData(
                                            // Couleur de la partie inactive du slider
                                            // Couleur de l'overlay affiché lors du glissement du slider
                                            thumbShape: RoundSliderThumbShape(
                                                enabledThumbRadius:
                                                    0.0), // Forme du bouton de contrôle du slider
                                            /*overlayShape: RoundSliderOverlayShape(
                                            overlayRadius:
                                                1.0), */ // Forme de l'overlay du slider

                                            trackHeight: 1.0,
                                          ),
                                          child: Slider(
                                            min: 0,
                                            max: duration.inMilliseconds
                                                .toDouble(),
                                            value: position.inMilliseconds
                                                .toDouble(),
                                            onChanged: (value) {
                                              final position = Duration(
                                                  milliseconds: value.round());
                                              controller.seekTo(position);
                                            },
                                            activeColor: Colors.white,
                                            inactiveColor: Colors.grey,
                                          ));
                                    }),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ));
    });
  }
}
