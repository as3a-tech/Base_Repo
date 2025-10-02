import 'package:flutter/material.dart';

import '../../core/routes/app_router.dart';
import '../home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String routeName = '/';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 1), () {
      AppRouter.pushAndRemove(
        HomeScreen.routeName,
        queryParameters: HomeArgs(id: 100, name: 'name').toJson(),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('Splash Screen')));
  }
}
