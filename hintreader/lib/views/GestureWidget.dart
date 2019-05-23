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
  double scaleRate;

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      child: widget._widget,
        // Scale
        onScaleStart: (details) {
          scaleRate = 1;
        },
        onScaleUpdate: (details) {
          // only this is important - update it
          scaleRate = details.scale;
        },
        onScaleEnd: (details) {
          if (scaleRate > 1)  {
            print("Zoom out");
          }  else  {
            print("Zoom in");
          }
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