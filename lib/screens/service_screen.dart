import 'package:cloud_9_client/provider/utility_provider.dart';
import 'package:cloud_9_client/screens/categories_screen.dart';
import 'package:cloud_9_client/screens/procedure_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ServiceScreen extends StatefulWidget {
  @override
  _ServiceScreenState createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen>
    with SingleTickerProviderStateMixin {
  // final double maxSlide = 225.0;
  // bool _canBeDragged = true;
  // AnimationController _animationController;

  @override
  void initState() {
    super.initState();
  }

  // void _toggle() => _animationController.isDismissed
  //     ? _animationController.forward()
  //     : _animationController.reverse();

  // void _onDragStart(DragStartDetails details) {
  //   bool isDragOpenFromLeft =
  //       _animationController.isDismissed && details.globalPosition.dx < 0;
  //   bool isDragCloseFromRight =
  //       _animationController.isCompleted && details.globalPosition.dx > 0;
  //   _canBeDragged = isDragOpenFromLeft || isDragCloseFromRight;
  // }

  // void _onDragUpdate(DragUpdateDetails details) {
  //   if (_canBeDragged) {
  //     double delta = details.primaryDelta / maxSlide;
  //     _animationController.value += delta;
  //   }
  // }

  // void _onDragEnd(DragEndDetails details) {
  //   if (_animationController.isDismissed || _animationController.isCompleted)
  //     return;
  //   if (details.velocity.pixelsPerSecond.dx.abs() >= 365.0) {
  //     double visualVelocity = details.velocity.pixelsPerSecond.dx /
  //         MediaQuery.of(context).size.width;
  //     _animationController.fling(velocity: visualVelocity);
  //   } else if (_animationController.value < 0.5) {
  //     close();
  //     Drawer();
  //   } else {
  //     open();
  //   }
  // }

  // /// Starts an animation to open the drawer.
  // ///
  // /// Typically called by [ScaffoldState.openDrawer].
  // void open() {
  //   _animationController.fling(velocity: 1.0);
  // }

  // /// Starts an animation to close the drawer.
  // void close() {
  //   _animationController.fling(velocity: -1.0);
  // }

  @override
  Widget build(BuildContext context) {
    final _utilityProvider = Provider.of<UtilityProvider>(context);
    _utilityProvider.setAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250));
    return GestureDetector(
      onHorizontalDragStart: _utilityProvider.onDragStart,
      onHorizontalDragUpdate: _utilityProvider.onDragUpdate,
      //  onHorizontalDragEnd: _utilityProvider.onDragEnd,
      onTap: _utilityProvider.toggle,
      child: AnimatedBuilder(
          animation: _utilityProvider.animationController,
          builder: (context, _) {
            double slide = _utilityProvider.maxSlide *
                _utilityProvider.animationController.value;
            double scale =
                1 - (_utilityProvider.animationController.value * 0.3);
            return Stack(
              children: <Widget>[
                CategoriesScreen(),
                Transform(
                    transform: Matrix4.identity()
                      ..translate(slide)
                      ..scale(scale),
                    alignment: Alignment.centerLeft,
                    child: ProcedureScreen())
              ],
            );
          }),
    );
  }
}
