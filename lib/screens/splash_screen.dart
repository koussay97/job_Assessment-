import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mint_it_asses/core/brand/brand_guid.dart';
import 'package:mint_it_asses/core/settings/app_settings.dart';

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

class AnimatedLogo extends StatefulWidget {
  final double logoBlocSize;

  const AnimatedLogo({
    Key? key,
    required this.logoBlocSize,
  }) : super(key: key);

  @override
  State<AnimatedLogo> createState() => _AnimatedLogoState();
}

class _AnimatedLogoState extends State<AnimatedLogo>
    with TickerProviderStateMixin {
  late final AnimationController _animationController;
  late Animation<double> part1Animation;
  late Animation<double> part2Animation;
  late Animation<double> part3Animation;

  @override
  initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,

    )..forward();

    part1Animation =
        Tween<double>(begin: 1, end: 0).animate(_animationController);
    part2Animation =
        Tween<double>(begin: 4, end: 0).animate(_animationController);
    part3Animation =
        Tween<double>(begin: 1, end: 0.282).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double logoBlocHeight = widget.logoBlocSize / 4;
    double logoBlocWidth = widget.logoBlocSize;
    return SizedBox(
      //  color: Colors.yellow,
      height: logoBlocHeight,
      width: logoBlocWidth,
      child: Stack(
        children: [
          AnimatedBuilder(
              animation: part1Animation,
              child: SizedBox(
                  height: logoBlocHeight,
                  width: 0.4 * logoBlocWidth,
                  child: Brand.logoWhite1),
              builder: (context, child) {
                return Positioned(
                  top: part1Animation.value * logoBlocWidth,
                  //should get to 0,
                  right: 0,
                  child: SizedBox(
                      height: logoBlocHeight,
                      width: 0.4 * logoBlocWidth,
                      child: Brand.logoWhite1),
                );
              }),
          AnimatedBuilder(
              animation: part2Animation,
              child: SizedBox(
                  height: logoBlocHeight,
                  width: 0.828 * logoBlocWidth,
                  child: Brand.logoWhite2),
              builder: (context, child) {
                return Positioned(
                  top: 0,
                  left: part2Animation.value * logoBlocHeight, //0,
                  child: SizedBox(
                      height: logoBlocHeight,
                      width: 0.828 * logoBlocWidth,
                      child: Brand.logoWhite2),
                );
              }),
          AnimatedBuilder(
              animation: part3Animation,
              child: Positioned(
                bottom: 0,
                right: part3Animation.value * logoBlocWidth,
                child: SizedBox(
                    height: 0.5633 * logoBlocHeight,
                    width: 0.55087 * logoBlocWidth,
                    child: Brand.logoWhite3),
              ),
              builder: (context, child) {
                return Positioned(
                  bottom: 0,
                  right: part3Animation.value * logoBlocWidth,
                  child: SizedBox(
                      height: 0.5633 * logoBlocHeight,
                      width: 0.55087 * logoBlocWidth,
                      child: Brand.logoWhite3),
                );
              }),
        ],
      ),
    );
  }
}
