// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../ViewModel/SplachViewModel.dart';
import '../consts/Mygradient.dart';

class SplashView extends GetView<SplachViewModel> {
  const SplashView({Key? key}) : super(key: key);
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: TweenAnimationBuilder(
        duration: Duration(seconds: 5),
        tween: Tween<double>(begin: 0, end: 1),
        builder: (BuildContext context, double value, Widget? child) {
          return Container(
              decoration: BoxDecoration(
                gradient: MyGradient.getGradient(),
              ),
              child: Center(
                  child: Opacity(
                opacity: value,
                child: Container(
                  child: Center(
                    child: Image(
                      image:
                          AssetImage('lib/Resources/drawable/musikasplash.png'),
                      alignment: Alignment.center,
                    ),
                  ),
                ),
              )));
        },
        onEnd: () {
          // La transition vers la prochaine page peut être effectuée ici
        },
      ),
    );
  }
}
