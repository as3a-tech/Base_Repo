import 'package:bot_toast/bot_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'core/theme/controller/app_theme_controller.dart';
import 'core/theme/enum/theme_enum.dart';
import 'core/database/hive_const.dart';
import 'core/helpers/responsive_helper.dart';
import 'core/routes/app_router.dart';
import 'core/routes/route_imports.dart';
import 'core/theme/color/app_colors.dart';
import 'core/theme/app_theme/app_theme.dart';
import 'core/shared_widgets/custom_loading/custom_loading.dart';
import 'features/on_boarding/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox(HiveConst.appBox);

  timeago.setLocaleMessages('en', timeago.EnMessages());
  timeago.setLocaleMessages('en_short', timeago.EnShortMessages());
  timeago.setLocaleMessages('ar', timeago.ArMessages());
  timeago.setLocaleMessages('ar_short', timeago.ArShortMessages());
  Routes.configureRoutes(AppRouter.router);

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en'),
        Locale('ar', 'SA'),
        Locale('ar', 'EG'),
      ],
      path: 'assets/i18n',
      fallbackLocale: const Locale('ar', 'SA'),
      startLocale: const Locale('ar', 'SA'),
      saveLocale: true,
      child: ChangeNotifierProvider(
        create: (_) => AppThemeController(),
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        updateDeviceScreenType(constraints);
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => PercentLoadingController()),
          ],
          child: MaterialApp(
            title: 'App Name',
            localizationsDelegates: [...context.localizationDelegates],
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            theme: appThemeData(context),
            debugShowCheckedModeBanner: false,
            builder: BotToastInit(),
            navigatorObservers: [
              AppRouter.routeObserver,
              BotToastNavigatorObserver(),
            ],
            onGenerateRoute: AppRouter.router.generator,
            initialRoute: SplashScreen.routeName,
            navigatorKey: AppRouter.navigatorKey,
          ),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _incrementCounter() {
    switch (context.read<AppThemeController>().theme) {
      case ThemeEnum.light:
        context.read<AppThemeController>().theme = ThemeEnum.dark;
        break;
      case ThemeEnum.dark:
        context.read<AppThemeController>().theme = ThemeEnum.light;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: AppColors.primary(context),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
