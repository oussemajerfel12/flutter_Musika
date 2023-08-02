import 'package:get/get.dart';

import '../ViewModel/SearchViewModel.dart';

class SearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchViewModel>(
      () => SearchViewModel(),
    );
  }
}
