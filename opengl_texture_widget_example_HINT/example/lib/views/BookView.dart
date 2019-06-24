import 'package:flutter/material.dart';
import 'package:opengl_texture_example/progbar/MyLinearProgressIndicator.dart';
import 'dart:async';

import 'package:opengl_texture/opengl_texture.dart';

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter/foundation.dart';

class BookView extends StatefulWidget {
  BookView(this.darkmode, this.size);

  final bool darkmode;
  final int size; //-1 = zoomed in; 0 = normal; 1 = zoomed out

  @override
  State<StatefulWidget> createState() => _BookViewState(darkmode, size);
}

class _BookViewState extends State<BookView> {
  _BookViewState(this.darkmode, this.size);
  final _controller = new OpenGLTextureController();
  final _width = 300.0;
  final _height = 200.0;

  bool darkmode;
  int size;

  static Map<int, Color> color =
  {
    50:Color.fromRGBO(255,156,6, .1),
    100:Color.fromRGBO(255,156,6, .2),
    200:Color.fromRGBO(255,156,6, .3),
    300:Color.fromRGBO(255,156,6, .4),
    400:Color.fromRGBO(255,156,6, .5),
    500:Color.fromRGBO(255,156,6, .6),
    600:Color.fromRGBO(255,156,6, .7),
    700:Color.fromRGBO(255,156,6, .8),
    800:Color.fromRGBO(255,156,6, .9),
    900:Color.fromRGBO(255,156,6, 1),
  };

  MaterialColor colorCustom = MaterialColor(0xFFFF9C06, color);

  @override
  initState() {
    super.initState();

    initializeController();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: AppBar(
            bottom: MyLinearProgressIndicator(
              backgroundColor: colorCustom,
              value: calculateProgressBar(),
            ),
            // Here we take the value from the MyHomePage object that was created by
            // the App.build method, and use it to set our appbar title.
            actions: <Widget>[
              // action button
              IconButton(
                icon: Icon(Icons.wb_sunny),
                color: darkmode == false ? colorCustom : Colors.black,
                onPressed: () {
                  if (darkmode == false) {
                    setState(() {
                      darkmode = true;
                    });
                  } else {
                    setState(() {
                      darkmode = false;
                    });
                  }
                },
              ),
              RaisedButton(
                child: Text("A", style: TextStyle(color: size == -1 ? Colors.black : colorCustom, fontSize: 28)),
                color: Colors.grey[200],
                onPressed: () {
                  if(size == 0 || size == 1) {
                    setState(() {
                      size = -1;
                    });
                  } else {
                    setState(() {
                      size = 0;
                    });
                  }
                },
              ),
              RaisedButton(
                child: Text("a", style: TextStyle(color: size == 1 ? Colors.black : colorCustom, fontSize: 28)),
                color: Colors.grey[200],
                onPressed: () {
                  if(size == 0 || size == -1) {
                    setState(() {
                      size = 1;
                    });
                  } else {
                    setState(() {
                      size = 0;
                    });
                  }
                },
              )
            ]),
        body: new Center(
          child: new Container(
            // unclear how to figure out the correct width and height here (mr)
            padding: EdgeInsets.all(10.0),
            //width: _width,
            //height: _height,
            child: _controller.isInitialized
                ? new VarTexture(textureId: _controller.textureId, controller: _controller)
                : null,
          ),
        ),
      ),
    );
  }

  Future<Null> initializeController() async {
    await _controller.initialize(_width, _height);
    setState(() {});
  }
}

class VarTexture extends LeafRenderObjectWidget {
  /// Creates a widget backed by the texture identified by [textureId].
  const VarTexture({
    Key key,
    @required this.textureId,
    @required this.controller,
  }) : assert(textureId != null),
        super(key: key);

  /// The identity of the backend texture.
  final int textureId;
  final OpenGLTextureController controller;

  @override
  TextureBox createRenderObject(BuildContext context) {
    return VarTextureBox(textureId: textureId, controller: controller);
  }

  @override
  void updateRenderObject(BuildContext context, TextureBox renderObject) {
    renderObject.textureId = textureId;
  }
}


class VarTextureBox extends TextureBox {
  /// Creates a box backed by the texture identified by [textureId].
  VarTextureBox({ @required int textureId,
    @required this.controller,})
      : assert(textureId != null),assert(controller != null),
        super(textureId: textureId);

  final OpenGLTextureController controller;

  @override
  void performResize() {

    size = constraints.biggest;
    markNeedsPaint();
    controller.resize(size.width, size.height);
  }
}

calculateProgressBar() {
  return 0.335;
}
