import 'package:flutter/material.dart';

class AnimationFailure extends StatefulWidget {
final String title;
final Function setNormalState;

  AnimationFailure(this.title, this.setNormalState);

  @override
  _AnimationFailureState createState() => _AnimationFailureState();
}

class _AnimationFailureState extends State<AnimationFailure> with SingleTickerProviderStateMixin {

  AnimationController failureController;
  Animation animation;

  @override
  void initState() {
    super.initState();
    failureController =
        AnimationController(duration: Duration(seconds: 2), vsync: this);
    animation =
        CurvedAnimation(parent: failureController, curve: Curves.bounceOut);

    failureController.forward();
    failureController.addListener(() {
      setState(() {});
      print(animation.value);
    });
  }

   @override
  void dispose() {
    super.dispose();
    failureController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Hero(
            tag: 'failure',
            child: Icon(
              Icons.error_outline,
              color: Colors.redAccent,
              size: animation.value * 75,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Vi är ledsna, men någonting gick fel. Var vänlig försök igen!',
            style: TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 10,
          ),
          RaisedButton(
            child: const Text('Fortsätt'),
            color: Colors.redAccent,
            onPressed: () {
              widget.setNormalState();
            },
          ),
        ],
      ),
    );
  }
}
