import 'package:flutter/material.dart';

class ImageViewer extends StatefulWidget {
  final List<String> images;

  ImageViewer(this.images);

  @override
  _ImageViewerState createState() => _ImageViewerState();
}

class _ImageViewerState extends State<ImageViewer> {
  int index = 0;

  final double MIN_X_VALUE = 50;
  final double MAX_Y_FACTOR = 4;

  double x = 0;
  double y = 0;

  List<Widget> buildImageIndicators() {
    List<Widget> imageList = [];

    for (int i=0; i<widget.images.length; i++) {
      imageList.add(Container(
        height: 25,
        width: 25,
        child: IconButton(
          icon: index == i
              ? Icon(
                  Icons.radio_button_checked,
                  size: 15,
                )
              : Icon(Icons.radio_button_unchecked, size: 15),
          onPressed: () {
            setState(() {
              index = i;
            });
          },
        ),
      ));
    }
    return imageList;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          child: GestureDetector(
            child: Image.network(
              'http://10.0.2.2:8010/images/${widget.images[index]}',
            ),
            onPanDown: (details) {
              // print('onPanDown called with $details');
              x = 0;
              y = 0;
              // print('x = $x, y= $y');
            },
            onPanUpdate: (details) {
              // print('onPanUpdate called with $details');
              x += details.delta.dx;
              y += details.delta.dy;
              // print('x = $x, y= $y');
            },
            onPanEnd: (details) {
              // print('onPanEnd called with $details');
              if (x.abs() > MIN_X_VALUE && y.abs() < (x.abs() / MAX_Y_FACTOR)) {
                if (x > 0) {
                  if (index > 0) {
                    setState(() {
                      index -= 1;
                    });
                  }
                } else {
                  if (index < widget.images.length - 1) {
                    setState(() {
                      index += 1;
                    });
                  }
                }
              }
            },
            onPanCancel: () {
              // print('onPanCancel called');
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: buildImageIndicators(),
        )
      ],
    );
  }
}
