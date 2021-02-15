import 'package:flutter/material.dart';

class AnimationSuccess extends StatefulWidget {
  final String title;

  AnimationSuccess(this.title);

  @override
  _AnimationSuccessState createState() => _AnimationSuccessState();
}

class _AnimationSuccessState extends State<AnimationSuccess>
    with SingleTickerProviderStateMixin {
  AnimationController successController;
  Animation animation;

  @override
  void initState() {
    super.initState();
    successController =
        AnimationController(duration: Duration(seconds: 2), vsync: this);
    animation =
        CurvedAnimation(parent: successController, curve: Curves.bounceOut)
          ..addStatusListener((AnimationStatus status) {
            if (status == AnimationStatus.completed) {
              print('completed');
              Navigator.pop(context);
            }
          });

    successController.forward();
    successController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    successController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Container(
        child: Center(
          child: Hero(
            tag: 'success',
            child: Icon(
              Icons.check,
              size: animation.value * 300,
              color: Colors.green,
            ),
          ),
        ),
      ),
    );
  }
}
