import 'package:flutter/material.dart';

typedef IconCardOnTap = Function();

class IconOnlyCard extends StatelessWidget {
  final Color iconColor;

  final IconData icon;

  final Color backgroundColor;
  final IconCardOnTap onTap;

  const IconOnlyCard(
      {Key key,
      @required this.iconColor,
      @required this.icon,
      @required this.backgroundColor,
      @required this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Icon(
          icon,
          color: iconColor,
        ),
      ),
    );
  }
}
