// ignore_for_file: deprecated_member_use, sort_child_properties_last

import 'package:flutter/material.dart';

/*import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:musika/Model/SongModel.dart';
import 'package:musika/ViewModel/HomeViewModel.dart';
import 'package:musika/binding/HomeBinding.dart';

import '../Model/SearchResult.dart';
import '../Model/ArtisteModel.dart';

import '../Model/TranslationService.dart';
import '../ViewModel/AlbumViewModel.dart';
import '../consts/theme_data.dart';
import 'package:share_plus/share_plus.dart';
*/
  /* 
class AlbumView extends GetView<AlbumViewModel> {
 Result result;
  late final item = ArtisteModel(
    RscUid: result.resource!.rscUid.toString(),
    ttl: result.resource!.ttl.toString(),
    Id: result.resource!.id.toString(),
  );

  bool debugPrintGestureArenaDiagnostics = false;

  //ArtisteDetail(this.result, {super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ArtisteViewModel());
    return FutureBuilder(
        future: Future.wait([
          controller.Artiste_Titre(item.ttl.toString()),
          controller.Artiste_Album(item.ttl.toString())
        ]),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (!snapshot.hasData) {
            return Scaffold(
                backgroundColor: Styles.themeData(
                        controller.getStorge.read("isDarkMode"), context)
                    .primaryColor,
                body: Center(
                    child: CircularProgressIndicator(
                  color: Color.fromARGB(255, 201, 92, 2),
                  backgroundColor: Colors.grey,
                )));
          }
          List<Result>? _Titrehot = snapshot.data![0];
          List<Result>? _Album = snapshot.data![1];

          return Directionality(
              textDirection: TranslationService().textDirection,
              child: Scaffold(
                backgroundColor: Styles.themeData(
                        controller.getStorge.read("isDarkMode"), context)
                    .primaryColor,
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
                  backgroundColor: Styles.themeData(
                          controller.getStorge.read("isDarkMode"), context)
                      .primaryColor,
                  centerTitle: true,
                ),
                body: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        color: Styles.themeData(
                                controller.getStorge.read("isDarkMode"),
                                context)
                            .primaryColor,
                        // width: double.infinity,
                        height: 260,
                        child: Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Container(
                                  height: 230,
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  child: Column(children: [
                                    Container(
                                      width: 180,
                                      height: 160,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Styles.themeData(
                                                    controller.getStorge
                                                        .read("isDarkMode"),
                                                    context)
                                                .primaryColorLight
                                                .withOpacity(0.1),
                                            spreadRadius: 2,
                                            offset: Offset(2, 2),
                                          ),
                                        ],
                                        image: DecorationImage(
                                            image: AssetImage(
                                              'lib/Resources/drawable/micro_01_1.png',
                                            ),
                                            fit: BoxFit.contain),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 25,
                                    ),
                                    Container(
                                      child: Text(
                                        item!.ttl.toString(),
                                        style: Styles.themeData(
                                                controller.getStorge
                                                    .read("isDarkMode"),
                                                context)
                                            .textTheme
                                            .headline1,
                                      ),
                                    ),
                                  ]),
                                ),
                              ),
                              Align(
                                  alignment: Alignment.topRight,
                                  child: Container(
                                      child: Column(
                                    children: [
                                      Image.asset(
                                          'lib/Resources/drawable/shuffle_1.png',
                                          width: 164),
                                      SizedBox(height: 10),
                                      Image.asset(
                                        'lib/Resources/drawable/heart_01_1.png',
                                        width: 30,
                                      ),
                                    ],
                                  ))),
                            ]),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      IntrinsicHeight(
                        child: Container(
                          height: 90,
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.all(20),
                          child: Text('Songs'.tr,
                              textAlign: TextAlign.start,
                              style: Styles.themeData(
                                      controller.getStorge.read("isDarkMode"),
                                      context)
                                  .textTheme
                                  .headline1),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          height: 250,
                          width: MediaQuery.of(context).size.width,
                          child: ListView.builder(
                            shrinkWrap: false,
                            scrollDirection: Axis.vertical,
                            itemCount: _Titrehot?.length,
                            itemBuilder: (BuildContext context, int index) =>
                                Card(
                              color: Styles.themeData(
                                      controller.getStorge.read("isDarkMode"),
                                      context)
                                  .primaryColor,
                              child: Card(
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        radius: 47,
                                        backgroundColor: Styles.themeData(
                                                controller.getStorge
                                                    .read("isDarkMode"),
                                                context)
                                            .primaryColorLight
                                            .withOpacity(0.1),
                                        backgroundImage: NetworkImage(
                                          _Titrehot![index]
                                              .fieldList!
                                              .thumbSmall
                                              .toString(),
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            _Titrehot![index]
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
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                color: Styles.themeData(
                                        controller.getStorge.read("isDarkMode"),
                                        context)
                                    .primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 90,
                        padding: const EdgeInsets.all(20),
                        child: Text('Albums'.tr,
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
                          width: MediaQuery.of(context).size.width,
                          child: ListView.builder(
                              shrinkWrap: false,
                              scrollDirection: Axis.horizontal,
                              itemCount: _Album?.length,
                              itemBuilder: (BuildContext context, int index) =>
                                  Card(
                                    color: Styles.themeData(
                                            controller.getStorge
                                                .read("isDarkMode"),
                                            context)
                                        .primaryColor,
                                    child: Center(
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.4,
                                        height: 250,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
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
                                                overflow: TextOverflow.ellipsis,
                                                _Album![index]
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
                                    ),
                                  )),
                        ),
                      ),
                      Container(
                        height: 120,
                      )
                    ],
                  ),
                ),
              ));
        });
  }
  }
  */

