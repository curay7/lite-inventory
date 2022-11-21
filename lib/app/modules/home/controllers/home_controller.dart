import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:first/app/data/services/db_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:first/app/data/services/notification_services.dart';

import '../../../data/model/task.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  var taskList = <Task>[].obs;
  Rx<DateTime> selectedDate = DateTime.now().obs;
  late Task updateTask;

  @override
  void onInit() {
    super.onInit();
    getTask();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void sendNotification(String title, String body) {
    AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: 1, channelKey: 'test_channel', title: title, body: body));
    //AwesomeNotifications().actionStream.listen((event) {});
  }

  void findProductUpdate(int id) {
    taskList.forEach((element) {
      print(element);
      if (element.id == id) {
        updateTask = element;
      }
    });
  }

  void getTask() async {
    List<Map<String, dynamic>> tasks = await DBHelper.query();
    taskList.assignAll(
      tasks.map(
        (data) => new Task.fromJson(data),
      ),
    );
  }

  Future<int> addTask({Task? task}) async {
    return await DBHelper.insert(task);
  }

  void delete(Task task) {
    var id = DBHelper.delete(task);
    getTask();
  }

  Future<int> updateProduct({required int id, Task? task}) async {
    int returnId = await DBHelper.update(id: id, task: task!);
    getTask();
    return returnId;
  }
}
