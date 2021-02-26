import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String title;
  final bool hasBorder;
  final double height;
  final Function onTap;

  ButtonWidget({
    this.title,
    this.hasBorder,
    this.height = 60.0,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Ink(
        decoration: BoxDecoration(
          color: hasBorder ? Colors.white : onTap == null ? Colors.grey : Colors.redAccent,
          borderRadius: BorderRadius.circular(10),
          border: hasBorder 
          ? Border.all(
            color: Colors.redAccent,
            width: 1.0,
          ) : Border.fromBorderSide(BorderSide.none)
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: height,
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                  color: hasBorder ? Colors.redAccent : Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 18.0,
                ),
              ),
            ),
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}
