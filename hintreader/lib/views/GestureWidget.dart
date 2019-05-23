import 'package:flutter/material.dart';
import 'package:hintreader/views/BookView.dart';

class GestureWidget extends StatefulWidget {
  final Widget _widget;
  final BookViewState _view;
  GestureWidget(this._widget, this._view);

  @override
  _GestureWidgetState createState() => _GestureWidgetState(_view);
}

class _GestureWidgetState extends State<GestureWidget> {
  final BookViewState _view;

  double startX;
  double endX;
  double scaleRate;

  _GestureWidgetState(this._view);

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
          //print("Zoom out");
          _view.biggerText();
        }  else  {
          //print("Zoom in");
          _view.smallerText();
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