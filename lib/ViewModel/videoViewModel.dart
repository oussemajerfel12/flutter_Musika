import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:musika/Model/SearchResult.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:audioplayers/audioplayers.dart';

import 'package:better_player/better_player.dart';

class videoViewModel extends GetxController {
  late BetterPlayerController betterPlayerController;
  final getStorge = GetStorage();
  late final Rx<Duration> _position1 = Duration.zero.obs;
  late Rx<Duration> _duration1 = Duration.zero.obs;
  RxBool isPlayed = false.obs;
  RxBool isShuffled = false.obs;
  RxBool isRepated = false.obs;
  RxBool IsFavoriteS = false.obs;

  Duration get position1 => _position1.value;
  Duration get duration1 =>
      betterPlayerController.videoPlayerController!.value.duration!;

  @override
  void onInit() {
    super.onInit();

    BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
    );

    betterPlayerController = BetterPlayerController(
      BetterPlayerConfiguration(),
      betterPlayerDataSource: betterPlayerDataSource,
    );

    betterPlayerController.addEventsListener((event) {
      if (event.betterPlayerEventType == BetterPlayerEventType.initialized) {
        betterPlayerController.play(); // Start video playback
      }

      if (event.betterPlayerEventType == BetterPlayerEventType.progress) {
        _position1.value =
            betterPlayerController.videoPlayerController!.value.position;
      }
    });
  }

  void pause() {
    betterPlayerController.videoPlayerController!.pause();
    isPlayed.value = false;
  }

  void resume() {
    isPlayed.value = true;

    betterPlayerController.videoPlayerController!.play();
  }

  void Stop() {
    betterPlayerController.dispose();

    isPlayed.value = false;
  }

  void seekTo(Duration position) {
    betterPlayerController.seekTo(position);
  }
}
