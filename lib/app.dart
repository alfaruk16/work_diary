import 'package:flutter/material.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:work_diary/core/navigator/iflutter_navigator.dart';
import 'package:work_diary/core/network_info/network_info.dart';
import 'features/app/data/data_sources/local_keys.dart';
import 'features/app/domain/repositories/local_storage_repo.dart';
import 'features/app/presentation/activities/dashboard/view/dashboard_screen.dart';
import 'features/app/presentation/activities/login/view/log_in_screen.dart';

class MyApp extends StatefulWidget {
  const MyApp(this.localStorageRepo, this.networkInfo, this._flutterNavigator,
      {Key? key})
      : super(key: key);

  final LocalStorageRepo localStorageRepo;
  final NetworkInfo networkInfo;
  final IFlutterNavigator _flutterNavigator;

  @override
  State<StatefulWidget> createState() {
    return _MyApp();
  }
}

class _MyApp extends State<MyApp> with WidgetsBindingObserver {
  int count = 0;
  bool updateView = false;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    checkVersionUpdate();
    widget.networkInfo.checkInternetConnection(widget._flutterNavigator);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    count++;
    if (!updateView && state == AppLifecycleState.resumed && count != 3) {
      count = 0;
      checkVersionUpdate();
    } else if (count > 3) {
      count = 0;
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Work Diary',
        navigatorKey: widget._flutterNavigator.navigatorKey,
        home: isLoggedIn(widget.localStorageRepo)
            ? const DashBoardScreen()
            : const LogInScreen());
  }

  bool isLoggedIn(LocalStorageRepo localStorageRepo) {
    if (localStorageRepo.read(key: tokenDB) != null) {
      return true;
    }
    return false;
  }

  Future<void> checkVersionUpdate() async {
    InAppUpdate.checkForUpdate().then((info) {
      if (info.updateAvailability == UpdateAvailability.updateAvailable) {
        updateView = true;
        InAppUpdate.performImmediateUpdate()
            .then((value) => updateView = false);
      }
    }).catchError((e) {
      // ShowSnackBar(
      //     message: 'App Update Failed',
      //     navigator: getIt<IFlutterNavigator>(),
      //     error: true);
    });
  }
}
