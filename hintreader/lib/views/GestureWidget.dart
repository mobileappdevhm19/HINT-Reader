import 'package:flutter/material.dart';

class GestureWidget extends StatelessWidget {
  final Widget _widget;
  GestureWidget(this._widget);

  @override
  Widget build(BuildContext context) {
    // scale 1.0 && rotation 0.0 -> swipe
    return new GestureDetector(
      child: _widget,
        // Scale
        onScaleStart: (details) {
          Offset offset = details.focalPoint;
          double direction = offset.direction;
          double distance = offset.distance;
          double dx = offset.dx;
          double dy = offset.dy;

          print("Scale Start");
          print("Dir: $direction, Dis: $distance, Dx: $dx, Dy: $dy");
          print(details);
        },
        onScaleUpdate: (details) {
          print("Scale Update");
          //print(details);
        },
        onScaleEnd: (details) {
          print("Scale End");
          print(details);
          print("");
        },

        // Swipe
        onHorizontalDragStart: (details)  {
          print("Swipe Start");
          print(details);
        },
        onHorizontalDragUpdate: (details) {
          print("Swipe Update");
          //print(e);
        },
        onHorizontalDragEnd: (details)  {
          print("Swipe End");
          print(details);
          print("");
        },
    );
  }
}