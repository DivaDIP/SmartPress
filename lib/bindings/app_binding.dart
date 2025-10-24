import 'package:get/get.dart';
import 'package:metronews_app/controllers/news_controller.dart';

class AppBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<NewsController>(NewsController(), permanent: true);
  }
}


// untuk semua controller aplikais
// binding = supaya controller busa terkendali dg baik