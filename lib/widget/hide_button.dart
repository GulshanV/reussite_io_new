import 'package:flutter/material.dart';

class RaisedGradientHideButton extends StatelessWidget {
  final Widget child;
  final double width;
  final double height;
  final EdgeInsetsGeometry margin;
  final Function onPressed;

  final Color color;

  const RaisedGradientHideButton({
    Key key,
    @required this.child,
    this.margin,
    this.width = double.infinity,
    this.height = 50.0,
    this.onPressed,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 50.0,
      margin: margin ??
          const EdgeInsets.only(top: 20.0, bottom: 5, left: 20, right: 20),
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[500],
              offset: Offset(0.0, 1.5),
              blurRadius: 1.5,
            ),
          ]),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
            onTap: onPressed,
            child: Center(
              child: child,
            )),
      ),
    );
  }
}
