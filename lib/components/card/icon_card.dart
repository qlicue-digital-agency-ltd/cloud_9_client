import 'package:flutter/material.dart';

typedef IconCardOnTap = Function();

class IconCard extends StatelessWidget {
  final Color iconColor;
  final Color textColor;
  final String icon;
  final String title;
  final Color backgroundColor;
  final IconCardOnTap onTap;

  const IconCard(
      {Key key,
      @required this.iconColor,
      @required this.icon,
      @required this.title,
      @required this.textColor,
      @required this.backgroundColor,
      @required this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        elevation: 2,
              child: Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.all(Radius.circular(20))
              ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(icon,
                height: 40,),
                Text(
                  title,
                  style: TextStyle(color: textColor),
                )
              ]),
        ),
      ),
    );
  }
}
