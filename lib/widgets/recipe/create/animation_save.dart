import 'package:flutter/material.dart';

class AnimationSave extends StatefulWidget {
  @override
  _AnimationSaveState createState() => _AnimationSaveState();
}

const double ICON_SIZE = 50;

class _AnimationSaveState extends State<AnimationSave>
    with SingleTickerProviderStateMixin {
  AnimationController saveController;
  Animation animation;

  @override
  void initState() {
    super.initState();
    saveController =
        AnimationController(duration: Duration(seconds: 2), vsync: this);
    animation = CurvedAnimation(parent: saveController, curve: Curves.bounceOut)
      ..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          print('completed');
        }
      });

    saveController.forward();
    saveController.addListener(() {
      setState(() {});
      //print(animation.value);
    });
  }

  @override
  Widget build(BuildContext context) {
    double center = MediaQuery.of(context).size.width / 2;
    return Hero(
      tag: 'success',
      child: Row(
        children: [
          Container(width: (animation.value * center) - (animation.value * ICON_SIZE/2) ),
          Icon(
            Icons.check,
            size: animation.value * ICON_SIZE,
            color: Colors.green,
          ),
        ],
      ),
    );
  }
}
