import 'package:get/get.dart';

import '../ViewModel/libraryViewModel.dart';

class LibraryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<libraryViewModel>(
      () => libraryViewModel(),
    );
  }
}
