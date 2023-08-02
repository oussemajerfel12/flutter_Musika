import 'package:get/get.dart';

import '../ViewModel/SplachViewModel.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SplachViewModel>(
      SplachViewModel(),
    );
  }
}
