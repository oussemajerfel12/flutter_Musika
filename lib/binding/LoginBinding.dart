import 'package:get/get.dart';

import '../ViewModel/LoginViewModel.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginViewModel>(
      () => LoginViewModel(),
    );
  }
}
