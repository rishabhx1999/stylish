import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:retrieve_flutter/utils/preference_manager.dart';
import 'package:retrieve_flutter/views/pages/on_boarding/on_boarding_page.dart';
import 'config/app_routes.dart';
import 'config/app_theme.dart';
import 'config/local_strings.dart';
import 'config/size_config.dart';
import 'consts/app_consts.dart';

Future<void> main() async {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  WidgetsFlutterBinding.ensureInitialized();
  await PreferenceManager.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return OrientationBuilder(
              builder: (BuildContext context, Orientation orientation) {
                SizeConfig().init(constraints, orientation);
                return GetMaterialApp(
                    translations: LocalStrings(),
                    locale: const Locale('en', 'US'),
                    debugShowCheckedModeBanner: false,
                    title: AppConsts.appName,
                    theme: appTheme(context),
                    home: const OnBoardingPage()
                );
              });
        });
  }
}
