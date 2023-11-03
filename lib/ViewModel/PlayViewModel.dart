// ignore_for_file: depend_on_referenced_packages, no_leading_underscores_for_local_identifiers, unnecessary_new, unnecessary_null_comparison

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:musika/Model/SearchResult.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:audioplayers/audioplayers.dart';
import '../Provider/SqlServerApi.dart';
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
  RxBool IsLiked = false.obs;
  RxBool Trendy = false.obs;
  RxInt enter = 0.obs;
  SqlServerApi db = SqlServerApi();
  RxInt Nb_vues = 0.obs;
  String likes = "";
  Timer? _timer;
  late String User_Id;
  var currentSong = Result().obs;

  RxList<Result> list1 = RxList();

  final RxInt index = 0.obs;

  Duration get position => _position.value;
  Duration get duration => _duration.value;

  RxString _url = RxString("");
  String get url => _url.value;
  RxDouble containerHeight = RxDouble(50);
  DateTime now = DateTime.now();

  void playSongg(List<Result> _list1, int _index) {
    list1.clear();
    index.value = _index;

    for (int i = 0; i < _list1.length; i++) {
      list1.add(_list1[i]);
    }
  }

  Future<String> getNumberOfViews(String id) async {
    final response = await http
        .get(Uri.parse('http://197.10.242.135:3000/getNumberOfViews/$id'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      String data1 = data[0]["nombre_des_vus"].toString();
      return data1;
    } else {
      throw Exception('Failed to load view count');
    }
  }

  Future<String> getNumberOfLikes(String id) async {
    final response = await http
        .get(Uri.parse('http://197.10.242.135:3000/getNumberOfLikes/$id'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      String data1 = data[0]["nombre_des_likes"].toString();
      return data1;
    } else {
      throw Exception('Failed to load view count');
    }
  }

  Future<void> insertData(String titre, String ID, String date) async {
    final Uri uri = Uri.parse(
        'http://197.10.242.135:3000/insert-data'); // Replace with your Node.js server URL

    final response = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'titre': titre,
        'ID': ID,
        'Date': date,
      }),
    );

    if (response.statusCode == 200) {
      print('Data inserted successfully.');
    } else {
      print('Failed to insert data. Error: ${response.statusCode}');
    }
  }

  Future<void> insertLike(String id_titre, String ID_user, String date) async {
    final Uri uri = Uri.parse('http://197.10.242.135:3000/insert-Like');
    final response = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'id_user': ID_user,
        'id_Titre': id_titre,
        'Date_like': date,
      }),
    );

    if (response.statusCode == 200) {
      print('Data inserted successfully.');
    } else {
      print('Failed to insert data. Error: ${response.statusCode}');
    }
  }

  Future<bool> checkIfLikeExists(String id, String idUser) async {
    final String apiUrl =
        'http://197.10.242.135:3000/fetch_LIKE_exist/$id/$idUser';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['exists'];
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<bool> checkIfExists(String id) async {
    final String apiUrl = 'http://197.10.242.135:3000/fetch_if_exist/$id';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['exists'];
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> deleteRecord(String userID, String idTitre) async {
    final Uri uri = Uri.parse('http://197.10.242.135:3000/delete-record');

    try {
      final response = await http.delete(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'userID': userID,
          'idTitre': idTitre,
        }),
      );

      if (response.statusCode == 200) {
        print('Record deleted successfully.');
      } else {
        print('Failed to delete record. Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<void> insertData1(
      String id, String artist, String coverImage, String url) async {
    final Map<String, dynamic> data = {
      'ID': id,
      'Artiste': artist,
      'CoverImage': coverImage,
      'Lien': url,
    };

    final response = await http.post(
      Uri.parse('http://197.10.242.135:3000/insertdata'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'ID': id,
        'Artiste': artist,
        'CoverImage': coverImage,
        'Lien': url,
      }),
    );

    if (response.statusCode == 200) {
      // Request was successful
      print('Data inserted successfully');
    } else {
      // Handle errors here
      print('Error: ${response.reasonPhrase}');
    }
  }

  void playSong1(List<Result> _list1, int _index) {
    index.value = _index;

    for (int i = 0; i < _list1.length; i++) {
      list1.add(_list1[i]);
    }
  }

  void playNextSong() {
    enter = 0.obs;
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
    enter = 0.obs;
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
      enter = 0.obs;
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
    User_Id = getStorge.read("name");
  }

  void shuffle() {
    enter = 0.obs;
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
