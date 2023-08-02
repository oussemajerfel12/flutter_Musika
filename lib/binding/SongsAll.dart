import 'package:get/get.dart';

import '../ViewModel/HomeViewModel.dart';

class SongsAll extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeViewModel>(
      () => HomeViewModel(),
    );
  }
}
