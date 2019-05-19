import 'package:flutter/material.dart';

class GestureWidget extends StatelessWidget {
  final Widget _widget;
  GestureWidget(this._widget);

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      child: _widget,
        onScaleStart: (e) => {
          print("Start"),
          print(e)
        },
        onScaleUpdate: (e) => {
          print("Update"),
          print(e)
        },
        onScaleEnd: (e) => {
          print("End"),
          print(e)
        },
    );
  }

}