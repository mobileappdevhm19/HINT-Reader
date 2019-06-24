import 'package:flutter/material.dart';

class ProgressIndicatorDemo extends StatefulWidget {
  static const String routeName = '/material/progress-indicator';

  @override
  _ProgressIndicatorDemoState createState() => _ProgressIndicatorDemoState();
}

class _ProgressIndicatorDemoState extends State<ProgressIndicatorDemo> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 0),
      vsync: this,
      animationBehavior: AnimationBehavior.normal,
    )..forward();

    _animation = kAlwaysDismissedAnimation;
  }

  @override
  void dispose() {
    _controller.stop();
    super.dispose();
  }

  Widget _buildIndicators(BuildContext context, Widget child) {
    final List<Widget> indicators = <Widget>[
      const LinearProgressIndicator(),
    ];
    return Column(
      children: indicators
          .map<Widget>((Widget c) => Container(child: c, margin: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0)))
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Progress indicators'),
        actions: <Widget>[/*MaterialDemoDocumentationButton(ProgressIndicatorDemo.routeName)*/],
      ),
      body: SafeArea(
                child: Container(
                  //padding: const EdgeInsets.only(bottom: 15.0),
                  child: AnimatedBuilder(
                    animation: _animation,
                    builder: _buildIndicators,
                  ),
        ),
      ),
    );
  }
}