import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mint_it_asses/core/brand/brand_guid.dart';
import 'package:mint_it_asses/core/settings/app_settings.dart';

import '../core/shared/ui/Animated_logo.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer timer;

  @override
  initState() {
    timer = Timer(const Duration(milliseconds: 1500), () {
      Navigator.pushNamed(context, AppSettings.loginRouteName);
    });
    super.initState();
  }
void disableAllFocus(){

}
  @override
  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          // Status bar color
          statusBarColor: Color(0xffB61E1E),
          statusBarIconBrightness: Brightness.light, // For Android (dark icons)
          statusBarBrightness: Brightness.dark, // For iOS (dark icons)
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: Brand.customRedGradient,
        ),
        child: const Center(
          child: AnimatedLogo(
            logoBlocSize: 300,
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

