import 'package:get/get.dart';

import '../ViewModel/ProfilViewModel.dart';

class ProfilBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfilViewModel>(
      () => ProfilViewModel(),
    );
  }
}
