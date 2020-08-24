import 'package:flutter/material.dart';

class UtilityProvider with ChangeNotifier {
  final double _maxSlide = 225.0;
  bool _canBeDragged = true;
  AnimationController _animationController;

  //getters
  double get maxSlide => _maxSlide;
  bool get canBeDragged => _canBeDragged;
  AnimationController get animationController => _animationController;

  //setters
  set setAnimationController(AnimationController _animationCtrlr) {
    _animationController = _animationCtrlr;
    notifyListeners();
  }

  //functions
  void toggle() => _animationController.isDismissed
      ? _animationController.forward()
      : _animationController.reverse();

  void onDragStart(DragStartDetails details) {
    bool isDragOpenFromLeft =
        _animationController.isDismissed && details.globalPosition.dx < 0;
    bool isDragCloseFromRight =
        _animationController.isCompleted && details.globalPosition.dx > 0;
    _canBeDragged = isDragOpenFromLeft || isDragCloseFromRight;
  
  }

  void onDragUpdate(DragUpdateDetails details) {
    if (_canBeDragged) {
      double delta = details.primaryDelta / _maxSlide;
      _animationController.value += delta;
    }
  }

  void onDragEnd(
    DragEndDetails details,
    BuildContext context,
  ) {
    if (_animationController.isDismissed || _animationController.isCompleted)
      return;
    if (details.velocity.pixelsPerSecond.dx.abs() >= 365.0) {
      double visualVelocity = details.velocity.pixelsPerSecond.dx /
          MediaQuery.of(context).size.width;
      _animationController.fling(velocity: visualVelocity);
    } else if (_animationController.value < 0.5) {
      _close();
      Drawer();
    } else {
      _open();
    }
  }

  /// Starts an animation to open the drawer.
  ///
  /// Typically called by [ScaffoldState.openDrawer].
  void _open() {
    _animationController.fling(velocity: 1.0);
  }

  /// Starts an animation to close the drawer.
  void _close() {
    _animationController.fling(velocity: -1.0);
  }
}
