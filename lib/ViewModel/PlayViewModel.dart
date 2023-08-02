// ignore_for_file: depend_on_referenced_packages, no_leading_underscores_for_local_identifiers, unnecessary_new, unnecessary_null_comparison

import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:musika/Model/SearchResult.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:audioplayers/audioplayers.dart';

import 'package:better_player/better_player.dart';

class PlayViewModel extends GetxController {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final getStorge = GetStorage();
  AudioPlayer audioplayer = AudioPlayer();
  late BetterPlayerController _betterPlayerController;
  late BetterPlayerDataSource _betterPlayerDataSource;
  BetterPlayerController get betterPlayerController => _betterPlayerController;
  late AudioCache audioCache;
  late Rx<Duration> _position = Duration.zero.obs;
  late Rx<Duration> _duration = Duration.zero.obs;
  RxBool isPlayed = false.obs;
  RxBool isShuffled = false.obs;
  RxBool isRepated = false.obs;
  RxBool IsFavoriteS = false.obs;

  Timer? _timer;

  var currentSong = Result().obs;

  RxList<Result> list1 = RxList();

  final RxInt index = 0.obs;

  Duration get position => _position.value;
  Duration get duration => _duration.value;

  RxString _url = RxString("");
  String get url => _url.value;
  RxDouble containerHeight = RxDouble(50);

  void playSongg(List<Result> _list1, int _index) {
    list1.clear();
    index.value = _index;

    for (int i = 0; i < _list1.length; i++) {
      list1.add(_list1[i]);
    }
  }

  void playSong1(List<Result> _list1, int _index) {
    index.value = _index;

    for (int i = 0; i < _list1.length; i++) {
      list1.add(_list1[i]);
    }
  }

  void playNextSong() {
    if (list1.isNotEmpty) {
      if (list1[index.value].resource!.type.toString() == "Titre") {
        isRepated.value = false;
        if (isShuffled.value == false) {
          do {
            if (index.value < list1.length - 1) {
              index.value++;
            } else {
              index.value = 0;
            }
          } while (index.value < list1.length &&
              list1[index.value].resource!.type.toString() == "Album");
        } else {
          final random = Random();
          index.value = random.nextInt(list1.length);
        }
        if (index.value < list1.length) {
          String url = list1[index.value]
              .primaryDocs!
              .link
              .toString()
              .replaceAll('https', 'http');
          Stop();
          Play(url);
        }
      } else if (list1[index.value].resource!.type.toString() == "Album") {
        do {
          if (index.value < list1.length - 1) {
            index.value++;
          } else {
            index.value = 0;
          }
        } while (index.value < list1.length &&
            list1[index.value].resource!.type.toString() == "Album");
        if (index.value < list1.length) {
          String url = list1[index.value]
              .primaryDocs!
              .link
              .toString()
              .replaceAll('https', 'http');
          Stop();
          Play(url);
        }
      }
    }
  }

  void playPreviousSong() {
    if (list1.isNotEmpty) {
      if (list1[index.value].resource!.type.toString() == "Titre") {
        isRepated.value = false;
        if (isShuffled.value == false) {
          do {
            if (index.value > 0) {
              index.value--;
            } else {
              index.value = list1.length - 1;
            }
          } while (index.value < list1.length &&
              list1[index.value].resource!.type.toString() == "Album");
        } else {
          final random = Random();
          index.value = random.nextInt(list1.length);
        }
        if (index.value < list1.length) {
          String url = list1[index.value]
              .primaryDocs!
              .link
              .toString()
              .replaceAll('https', 'http');
          Stop();
          Play(url);
        }
      } else if (list1[index.value].resource!.type.toString() == "Album") {
        do {
          if (index.value > 0) {
            index.value--;
          } else {
            index.value = list1.length - 1;
          }
        } while (index.value < list1.length &&
            list1[index.value].resource!.type.toString() == "Album");
        if (index.value < list1.length) {
          String url = list1[index.value]
              .primaryDocs!
              .link
              .toString()
              .replaceAll('https', 'http');
          Stop();
          Play(url);
        }
      }
    }
  }

  void repeat() {
    if (isRepated.value == true) {
      Stop();
      _position.value = Duration.zero;

      _betterPlayerController.play();
    }
  }

  set url(String value) {
    if (Platform.isAndroid) {
      value = value.replaceFirst("http://", "https://");
    } else {
      value = value;
    }
  }

  void toggleShuffle() {
    isShuffled.value = !isShuffled.value;
  }

  @override
  void onInit() {
    super.onInit();
  }

  void shuffle() {
    isRepated.value = false;
    final random = Random();
    index.value = random.nextInt(list1.length);

    url = list1[index.value]
        .primaryDocs!
        .link
        .toString()
        .replaceAll('https', 'http');
  }

  Duration getCurrentPosition() {
    if (_betterPlayerController.videoPlayerController != null &&
        _betterPlayerController.videoPlayerController!.value.initialized) {
      return _betterPlayerController.videoPlayerController!.value.duration!;
    } else {
      return Duration.zero;
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(milliseconds: 200), (_) {
      if (_betterPlayerController.videoPlayerController != null) {
        _position.value =
            _betterPlayerController.videoPlayerController!.value.position;

        Duration? duration =
            _betterPlayerController.videoPlayerController!.value.duration;

        _duration.value = duration!;
      }
    });
  }

  AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> Play(String url) async {
    isPlayed.value = true;
    String erreur = "";
    BetterPlayerDataSource _betterPlayerDataSource = new BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      url,
      notificationConfiguration: BetterPlayerNotificationConfiguration(
        showNotification: true,
        title: list1[index.value].resource!.id.toString(),
        author: list1[index.value].resource!.crtr.toString(),
        imageUrl: list1[index.value].fieldList!.thumbSmall.toString(),
        activityName: "MainActivity",
      ),
      videoFormat: BetterPlayerVideoFormat.hls,
    );
    _betterPlayerController = BetterPlayerController(
      BetterPlayerConfiguration(autoPlay: false),
      betterPlayerDataSource: _betterPlayerDataSource,
    );

    if (_betterPlayerController != null) {
      Completer<void> initializationCompleter = Completer<void>();
      _betterPlayerController.play();

      _betterPlayerController.addEventsListener((event) {
        if (event.betterPlayerEventType == BetterPlayerEventType.initialized) {
          _duration.value =
              _betterPlayerController.videoPlayerController!.value.duration!;
          initializationCompleter.complete();
        }
        if (event.betterPlayerEventType == BetterPlayerEventType.progress) {
          _duration.value =
              _betterPlayerController.videoPlayerController!.value.duration!;
        }

        _position.value =
            _betterPlayerController.videoPlayerController!.value.position;

        _duration.value =
            _betterPlayerController.videoPlayerController!.value.duration!;
      });

      _betterPlayerController.addEventsListener((event) async {
        if (event.betterPlayerEventType == BetterPlayerEventType.finished) {
          if (isShuffled.value) {
            isRepated.value = false;

            final random = Random();
            index.value = random.nextInt(list1.length);

            String url = list1[index.value]
                .primaryDocs!
                .link
                .toString()
                .replaceAll('https', 'http');
            Stop();

            await Play(url);
          }
        }

        if (isRepated.value == true &&
            event.betterPlayerEventType == BetterPlayerEventType.finished) {
          _betterPlayerController.seekTo(Duration.zero);
          _betterPlayerController.play();
        }

        if (!isRepated.value &&
            !isShuffled.value &&
            event.betterPlayerEventType == BetterPlayerEventType.finished) {
          playNextSong();
        }
      });

      await initializationCompleter.future;
    }
  }

  void pause() {
    _betterPlayerController.videoPlayerController!.pause();
    isPlayed.value = false;
  }

  void resume() {
    isPlayed.value = true;

    _betterPlayerController.videoPlayerController!.play();
  }

  void Stop() {
    _betterPlayerController.dispose();

    isPlayed.value = false;
  }

  void repeatOnOff() {
    isRepated.value = !isRepated.value;
  }

  void handleSongEnd() {
    if (position.inMilliseconds.toDouble() ==
            duration.inMilliseconds.toDouble() &&
        position.inMilliseconds.toDouble() != 0) {
      if (isShuffled.value == true) {
        Future.delayed(const Duration(milliseconds: 2000), () {
          isRepated.value = false;

          final random = Random();
          index.value = random.nextInt(list1.length);

          String url = list1[index.value]
              .primaryDocs!
              .link
              .toString()
              .replaceAll('https', 'http');
          Stop();

          Play(url);
        });
      }
    }
  }

  void seekTo(Duration position) {
    _betterPlayerController.seekTo(position);
  }

  @override
  void onClose() {
    super.onClose();

    _betterPlayerController.dispose();
  }
}
