import 'dart:ui';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:work_diary/core/ioc/global.dart';
import 'package:work_diary/core/navigator/iflutter_navigator.dart';
import 'package:work_diary/core/network_info/network_info.dart';
import 'package:work_diary/features/app/domain/repositories/local_storage_repo.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  configureDependencies();
  initFirebase();
  await initGetStorage();
  runApp(MyApp(getIt<LocalStorageRepo>(), getIt<NetworkInfo>(), getIt<IFlutterNavigator>()));
}

Future<void> initFirebase() async {
  await Firebase.initializeApp();
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
}

Future<void> initGetStorage() async {
  await GetStorage.init();
}
