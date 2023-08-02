import 'package:get/get.dart';

import '../ViewModel/PlayViewModel.dart';

class PlayBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PlayViewModel>(
      () => PlayViewModel(),
    );
  }
}
