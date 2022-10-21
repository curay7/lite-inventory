import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:first/app/data/services/db_helper.dart';
import 'package:first/app/modules/home/bindings/home_binding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'app/data/services/theme_services.dart';
import 'app/routes/app_pages.dart';
import 'app/modules/layout/themes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  AwesomeNotifications().initialize(null, [
    NotificationChannel(
      channelKey: 'test_channel',
      channelName: 'Test Notification',
      channelDescription: 'Notficiations for basic testing Aspire',
    )
  ]);

  await DBHelper.initDb();
  await GetStorage.init();
  runApp(
    GetMaterialApp(
      title: "Application",
      themeMode: ThemeServices().theme,
      theme: Themes.light,
      darkTheme: Themes.dark,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      initialBinding: HomeBinding(),
    ),
  );
}
