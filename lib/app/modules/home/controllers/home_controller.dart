import 'package:get/get.dart';
import 'package:first/app/data/services/notification_services.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  final count = 0.obs;
  var notifyHelper;
  @override
  void onInit() {
    super.onInit();
    print("TEST INIT in View");
    // notifyHelper = NotifyHelper();
    // notifyHelper.initializeNotification();
    // notifyHelper.requestIOSPermissions();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
