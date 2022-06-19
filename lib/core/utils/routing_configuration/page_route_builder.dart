import 'package:flutter/material.dart';

import '../custom_animations/transition_animations.dart';

/// copyrighted on june 2022 by koussay please don't use this with my consent

class CustomPageRouteBuilder extends PageRouteBuilder {
  final List<CustomAnimationTransitions> animationTransitions;
  final Widget page;
  final double? rotation;
  final SlidBeginTransition slideOrigin;
  final Curve? curve;
  final Duration customTransitionDuration;
  final Duration customReverseTransitionDuration;

  CustomPageRouteBuilder({
    required this.slideOrigin,
    required this.animationTransitions,
    required this.page,
    this.rotation,
    required this.customTransitionDuration,
    required this.customReverseTransitionDuration,
    this.curve,
  }) : super(
          reverseTransitionDuration: customTransitionDuration,
          transitionDuration: customTransitionDuration,
          pageBuilder: (context, animation, animation2) => page,
        );

  @override
  Widget buildTransitions(context, Animation<double> animation,
      Animation<double> secondaryAnimation, child) {
    /**in case we want one transition animation**/
    if (animationTransitions.length == 1) {
      return TransitionAnimations.helperSelector(
          item: animationTransitions[0],
          animation: animation,
          child: child,
          curve: curve,
          rotation: rotation,
          slideOrigin: slideOrigin);
    }
    /**in case we want two transition animations combined **/
    return TransitionAnimations.helperSelector(
        item: animationTransitions[0],
        animation: animation,
        curve: curve,
        rotation: rotation,
        slideOrigin: slideOrigin,
        child: TransitionAnimations.helperSelector(
            curve: curve,
            rotation: rotation,
            slideOrigin: slideOrigin,
            item: animationTransitions[1],
            animation: animation,
            child: child));
  }
}
