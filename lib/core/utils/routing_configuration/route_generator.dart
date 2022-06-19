import 'package:mint_it_asses/core/brand/brand_guid.dart';
import 'package:mint_it_asses/core/utils/custom_animations/transition_animations.dart';
import 'package:mint_it_asses/core/utils/routing_configuration/page_route_builder.dart';
import 'package:mint_it_asses/screens/driver_screen.dart';
import 'package:mint_it_asses/screens/login_screen.dart';
import 'package:mint_it_asses/screens/main_screen.dart';
import 'package:mint_it_asses/screens/splash_screen.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) =>  SplashScreen());
      case '/login':
        //return MaterialPageRoute(builder: (_)=>const LoginScreen());
        return CustomPageRouteBuilder(
            curve: Curves.elasticInOut,
            customReverseTransitionDuration: const Duration(milliseconds: 800),
            customTransitionDuration: const Duration(milliseconds: 1000),
          page: const LoginScreen(),
            animationTransitions: [
              CustomAnimationTransitions.buildSlideTransition,
              CustomAnimationTransitions.buildSizeTransition
            ],
            slideOrigin: SlidBeginTransition.fromRight,
            );
      case '/main':
        return CustomPageRouteBuilder(
          curve: Curves.elasticInOut,
          customReverseTransitionDuration: const Duration(milliseconds: 800),
          customTransitionDuration: const Duration(milliseconds: 1000),
          page: const MainScreen(),
          animationTransitions: [
            CustomAnimationTransitions.buildRotationTransition,
            CustomAnimationTransitions.buildScaleTransition
          ],
          rotation: 1,
          slideOrigin: SlidBeginTransition.fromLeft,
        );
      case '/driver':
        if (args is Map<String, dynamic>) {
          return MaterialPageRoute(builder: (_) => const DriverScreen());
        } else {
          return _errorRoute();
        }
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        backgroundColor: Brand.backgroundColor,
        body: const Center(
          child: Text('not authorized'),
        ),
      );
    });
  }

  /// see if we could return a pop up instead of a full route
}
