import 'package:flutter/material.dart';

enum CustomAnimationTransitions {
  buildSlideTransition,
  buildScaleTransition,
  buildRotationTransition,
  buildSizeTransition,
}

enum SlidBeginTransition {
  fromRight,
  fromLeft,
  fromTop,
  fromBottom,
  fromTopLeft,
  fromTopRight,
  fromBottomRight,
  fromBottomLeft,
}
abstract class TransitionAnimations{
  static Widget helperSelector(
      {required CustomAnimationTransitions item,
        required Animation<double> animation,
        required Widget child, Curve? curve,SlidBeginTransition? slideOrigin, double? rotation}) {
    switch (item) {
      case CustomAnimationTransitions.buildSlideTransition:
        return buildSlideTransition(
            position: animation, child: child, curve: curve, origin: slideOrigin);
      case CustomAnimationTransitions.buildScaleTransition:
        return buildScaleTransition(
            scaleAnimation: animation, child: child, curve: curve);
      case CustomAnimationTransitions.buildSizeTransition:
        return buildSizeTransition(
          sizeAnimation: animation,
          child: child,
          curve: curve,
        );
      case CustomAnimationTransitions.buildRotationTransition:
        return buildRotationTransition(
            numberOfRotations: rotation,
            rotationAnimation: animation,
            child: child,
            curve: curve);
      default:
        return buildSlideTransition(
            position: animation, child: child, curve: curve);
    }
  }

  static Offset _helperSliderSelector({SlidBeginTransition? origin}) {
    switch (origin) {
      case SlidBeginTransition.fromBottom:
        return const Offset(0, -1);
      case SlidBeginTransition.fromTop:
        return const Offset(0, 1);
      case SlidBeginTransition.fromLeft:
        return const Offset(-1, 0);
      case SlidBeginTransition.fromRight:
        return const Offset(1, 0);
      case SlidBeginTransition.fromBottomLeft:
        return const Offset(-1, -1);
      case SlidBeginTransition.fromBottomRight:
        return const Offset(1, -1);
      case SlidBeginTransition.fromTopRight:
        return const Offset(1, 1);
      case SlidBeginTransition.fromTopLeft:
        return const Offset(-1, 1);
      default:
        return const Offset(1, 0);
    }
  }

  static Widget buildSlideTransition(
      {required Animation<double> position,
        required Widget child,
        SlidBeginTransition? origin,
        Curve? curve,
        Offset? customBeginTransition,
        Offset? customEndTransition,
      }) {
    var beginTransition=customBeginTransition?? _helperSliderSelector(origin: origin);
     var endTransition=customEndTransition?? Offset.zero;
    var tween = Tween(begin: beginTransition, end: endTransition);
    var offsetAnimation = position.drive(tween);

    if (curve != null) {
      var curvedAnimation = CurvedAnimation(parent: position, curve: curve);
      return SlideTransition(
        position: tween.animate(curvedAnimation),
        child: child,
      );
    }
    return SlideTransition(
      position: offsetAnimation,
      child: child,
    );
  }

  static Widget buildScaleTransition(
      {required Animation<double> scaleAnimation,
        required Widget child,
        Curve? curve}) {
    var beginScale = 0.0;
    var endScale = 1.0;
    var scaleTween = Tween(begin: beginScale, end: endScale);
    if (curve != null) {
      var curvedAnimation =
      CurvedAnimation(parent: scaleAnimation, curve: curve);
      return ScaleTransition(
        scale: scaleTween.animate(curvedAnimation),
        child: child,
      );
    }
    return ScaleTransition(
      scale: scaleTween.animate(scaleAnimation),
      child: child,
    );
  }

  static Widget buildRotationTransition(
      {required Animation<double> rotationAnimation,
        required Widget child,
        required Curve? curve,
        double? numberOfRotations = 1}) {
    var beginRotation = 0.0;
    var endRotation = numberOfRotations ?? 1.0;
    var rotationTween = Tween(begin: beginRotation, end: endRotation);

    if (curve != null) {
      var curvedAnimation =
      CurvedAnimation(parent: rotationAnimation, curve: curve);
      return ScaleTransition(
        scale: rotationTween.animate(curvedAnimation),
        child: child,
      );
    }
    return RotationTransition(
      turns: rotationTween.animate(rotationAnimation),
      child: child,
    );
  }

  static Widget buildSizeTransition(
      {required Animation<double> sizeAnimation,
        required Widget child,
        required Curve? curve}) {
    var beginSize = 0.0;
    var endSize = 1.0;
    var sizeTween = Tween(begin: beginSize, end: endSize);

    if (curve != null) {
      var curvedAnimation =
      CurvedAnimation(parent: sizeAnimation, curve: curve);
      return ScaleTransition(
        scale: sizeTween.animate(curvedAnimation),
        child: child,
      );
    }
    return Align(
      alignment: Alignment.center,
      child: SizeTransition(sizeFactor: sizeAnimation),
    );
  }
 /* static Widget buildClipTransition({
    required Animation<double> sizeAnimation,
    required Widget child,
    required Curve? curve}){

}*/
}