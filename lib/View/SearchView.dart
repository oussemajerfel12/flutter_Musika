// ignore_for_file: deprecated_member_use, prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/default_transitions.dart';
import 'package:musika/View/HomeView.dart';
import 'package:musika/View/ProfileView.dart';
import 'package:musika/View/SearchViewDetail.dart';
import 'package:provider/provider.dart';

import '../Model/TranslationService.dart';
import '../ViewModel/HomeViewModel.dart';
import '../ViewModel/SearchViewModel.dart';
import '../consts/Mygradient.dart';
import '../consts/theme_data.dart';
import 'FilterView.dart';
import 'libraryView.dart';

class SearchView extends GetView<SearchViewModel> {
  @override
  Widget build(BuildContext context) {
    final HomeViewModel c = Get.put(HomeViewModel());
    String defaultValue = '';

    final SearchController = TextEditingController(text: defaultValue);

    final List<Color> colors = [
      Color.fromRGBO(254, 213, 213, 1.0),
      Color.fromRGBO(254, 213, 236, 1.0),
      Color.fromRGBO(250, 213, 254, 1.0),
      Color.fromRGBO(224, 213, 254, 1.0),
      Color.fromRGBO(213, 224, 254, 1.0),
      Color.fromRGBO(213, 249, 254, 1.0),
      Color.fromRGBO(213, 254, 244, 1.0),
      Color.fromRGBO(216, 254, 213, 1.0),
      Color.fromRGBO(253, 254, 213, 1.0),
    ];

    final List<Color> colors1 = [
      Color.fromRGBO(252, 157, 157, 1.0),
      Color.fromRGBO(255, 143, 204, 1.0),
      Color.fromRGBO(244, 141, 255, 1.0),
      Color.fromRGBO(173, 144, 254, 1.0),
      Color.fromRGBO(141, 172, 255, 1.0),
      Color.fromRGBO(142, 220, 231, 1.0),
      Color.fromRGBO(156, 228, 211, 1.0),
      Color.fromRGBO(167, 230, 162, 1.0),
      Color.fromRGBO(185, 240, 137, 1.0),
    ];

    final List<String> items1 = [
      '{\\"'
          '_69\\"'
          ':\\"'
          'مالوف\\"'
          '}',
      '{\\"'
          '_64\\"'
          ':\\"'
          'Titre\\"'
          '}',
      '{\\"'
          '_69\\"'
          ':\\"'
          'موسيقى صوفية/دينية\\"'
          '}',
      '{\\"'
          '_69\\"'
          ':\\"'
          'مزود\\"'
          '}',
      '{\\"'
          '_69\\"'
          ':\\"'
          'مزود\\"'
          '}',
      '{\\"'
          '_69\\"'
          ':\\"'
          'موسيقى آلية\\"'
          '}',
      '{\\"'
          '_69\\"'
          ':\\"'
          'مزود\\"'
          '}',
      '{\\"'
          '_68\\"'
          ':\\"'
          'موسيقى مغاربية\\"'
          '}',
      '{\\"'
          '_68\\"'
          ':\\"'
          'موسيقى مغاربية\\"'
          '}',
      '{\\"'
          '_74\\"'
          ':\\"'
          'Nouveauté\\"'
          '}',
      '{\\"'
          '_74\\"'
          ':\\"'
          'Nouveauté\\"'
          '}',
      '{\\"'
          '_68\\"'
          ':\\"'
          'موسيقى مصرية\\"'
          '}',
    ];
    final List<String> items = [
      "Mālūf",
      "Song",
      "Sufi / religious",
      "Popular tradition",
      "Mizwid",
      "Instrumental",
      /* "Rap",
      "Alternative",
      "Maghreb",
      "Nouveautés",
      "Classique",
      "Egypte",
     "en attente",
      "en attente",
      "en attente",
      "en attente",
      "en attente",
      "en attente",
      "en attente",
      "en attente",
      "en attente",
      "en attente",
      "en attente",
      "en attente",
      "en attente",
      "en attente",
      "en attente",
      "en attente",
      "en attente",
      "en attente",
      "en attente",
      "en attente",
      "en attente",
      "en attente",
      "en attente",
      "en attente",
      "en attente",
      "en attente",
      "en attente",
      "en attente",
      "en attente",*/
    ];
    /*final List<String> ListImage = [
      "lib/Resources/drawable/mezoued_1.png",
      "lib/Resources/drawable/malouf_1.png",
      "lib/Resources/drawable/sufi_1.png",
      "lib/Resources/drawable/rap_1.png",
      "lib/Resources/drawable/alternative_1.png",
      "lib/Resources/drawable/maghreb_1.png",
      "lib/Resources/drawable/nouveautes_1.png",
      "lib/Resources/drawable/classique_1.png",
      "lib/Resources/drawable/egypte_1.png"
    ];*/
    Get.put(SearchViewModel());
    TextDirection tt = TranslationService().textDirection;

    return Scaffold(
      appBar: null,
      body: Container(
          decoration: BoxDecoration(gradient: MyGradient.getGradient()),
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(16, 8, 16, 20),
                child: Container(
                  height: 55,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Directionality(
                    textDirection: TranslationService().textDirection,
                    child: TextField(
                      controller: SearchController,
                      onSubmitted: (text) {
                        controller.page = 0;
                        if (text.isEmpty) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SearchViewDetail(text: "*"),
                            ),
                          );
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  SearchViewDetail(text: SearchController.text),
                            ),
                          );
                        }
                      },
                      style: TextStyle(
                        color: Color(0xFF000000),
                        fontFamily: 'Poppins',
                        fontSize: 18,
                        height: 27 / 18,
                        letterSpacing: 0,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Search'.tr,
                        hintStyle: TextStyle(
                          color: Color(0xFF000000).withOpacity(1.0),
                          fontWeight: FontWeight.normal,
                          fontSize: 18,
                          height: 1.8,
                          letterSpacing: 0,
                          fontStyle: FontStyle.normal,
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 25),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GridView.builder(
                  padding: EdgeInsets.only(left: 12, top: 8, right: 14),
                  itemCount: items.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 2,
                    crossAxisSpacing: 2,
                    crossAxisCount: 2,
                    childAspectRatio: 1.98,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    Color color = colors[index % colors.length];
                    // ignore: unused_label
                    padding:
                    const EdgeInsets.all(16.0);
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            12.0), // Adjust the radius as needed
                      ),
                      color: color,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => FilterView(items1[index]),
                          ));
                        },
                        child: Container(
                          padding: EdgeInsets.all(
                              10), // Adjust the padding as needed
                          child: Center(
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Directionality(
                                    textDirection:
                                        TranslationService().textDirection,
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          right: tt == TextDirection.rtl
                                              ? 10
                                              : 10),
                                      child: Transform(
                                        transform: Matrix4.translationValues(
                                          tt == TextDirection.rtl ? 10.0 : 0.0,
                                          0.0,
                                          0.0,
                                        ), // Adjust the margin as needed

                                        child: Image.asset(
                                          'lib/Resources/drawable/musika.logo.icon.png',
                                          width: 40,
                                          color:
                                              colors1[index % colors1.length],
                                          // Définit la largeur de l'image
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      items[index].tr,
                                      style: TextStyle(
                                        color: Color(0xFF2D2D2D),
                                        fontFamily: 'Poppins',
                                        fontSize: 14,
                                        height: 21 / 14,
                                        letterSpacing: 0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              if (Get.find<HomeViewModel>().Miniplayer.value == true)
                Container(
                  height: 110,
                ),
              Container(
                height: 70,
              )
            ],
          )),
    );
  }
}
