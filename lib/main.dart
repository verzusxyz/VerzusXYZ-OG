import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:verzusxyz/data/services/push_notification_service.dart';
import 'package:verzusxyz/environment.dart';
import 'package:verzusxyz/firebase_options.dart';
import 'package:get/get.dart';
import 'package:verzusxyz/core/route/route.dart';
import 'package:verzusxyz/core/utils/messages.dart';
import 'package:verzusxyz/data/controller/localization/localization_controller.dart';
import 'package:permission_handler/permission_handler.dart';
import 'core/di_service/di_services.dart' as di_service;

/// The main entry point of the application.
///
/// This function initializes the Flutter binding, requests necessary permissions,
/// sets up dependency injection, initializes Firebase, and runs the application.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Permission.camera.request();
  await Permission.microphone.request();
  await Permission.photos.request();
  Map<String, Map<String, String>> languages = await di_service.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
    name: Environment.appName,
  );
  await PushNotificationService(apiClient: Get.find()).setupInteractedMessage();
  HttpOverrides.global = MyHttpOverrides();
  runApp(MyApp(languages: languages));
}

/// A custom [HttpOverrides] class to bypass SSL certificate validation.
///
/// This is useful for development and testing purposes, but should be used with
/// caution in production environments.
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

/// The root widget of the application.
///
/// This widget sets up the `GetMaterialApp` and configures the initial route,
/// navigation, and localization settings.
class MyApp extends StatefulWidget {
  /// The language data for the application.
  final Map<String, Map<String, String>> languages;

  /// Creates a new [MyApp] instance.
  ///
  /// Requires a map of language data.
  const MyApp({Key? key, required this.languages}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocalizationController>(
      builder: (localizeController) => GetMaterialApp(
        title: Environment.appName,
        debugShowCheckedModeBanner: false,
        defaultTransition: Transition.noTransition,
        transitionDuration: const Duration(milliseconds: 200),
        initialRoute: RouteHelper.splashScreen,
        navigatorKey: Get.key,
        getPages: RouteHelper().routes,
        locale: localizeController.locale,
        translations: Messages(languages: widget.languages),
        fallbackLocale: Locale(
          localizeController.locale.languageCode,
          localizeController.locale.countryCode,
        ),
      ),
    );
  }
}
