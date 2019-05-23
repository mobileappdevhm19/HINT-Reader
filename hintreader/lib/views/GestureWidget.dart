import 'package:flutter/material.dart';

class GestureWidget extends StatefulWidget {
  final Widget _widget;
  GestureWidget(this._widget);

  @override
  _GestureWidgetState createState() => _GestureWidgetState();
}

class _GestureWidgetState extends State<GestureWidget> {
  double startX;
  double endX;

  @override
  Widget build(BuildContext context) {
    // scale 1.0 && rotation 0.0 -> swipe
    return new GestureDetector(
      child: widget._widget,
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
          // only this is important
          startX = details.globalPosition.dx;
        },
        onHorizontalDragUpdate: (details) {
          // only this is important - update it
          endX = details.globalPosition.dx;
        },
        onHorizontalDragEnd: (details)  {
          double result = startX - endX;
          if (result > 0)  {
            print("Swipe Left");
          }  else  {
            print("Swipe Right");
          }
        }
    );
  }
}