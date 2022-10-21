import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:first/app/data/services/db_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:first/app/data/services/notification_services.dart';

import '../../../data/model/task.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  final count = 0.obs;

  @override
  void onInit() {
    super.onInit();
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

  void sendNotification(String title, String body) {
    AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: 1, channelKey: 'test_channel', title: title, body: body));
    //AwesomeNotifications().actionStream.listen((event) {});
  }

  Future<int> addTask({Task? task}) async {
    return await DBHelper.insert(task);
  }
}
