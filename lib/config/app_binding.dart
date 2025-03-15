import 'package:get/get.dart';
import 'package:getx_sql/controller/sql_controller.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SqlController());
  }
}
