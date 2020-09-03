import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final bool hasBorder;
  final Function clickFunction;

  ButtonWidget({this.text,this.hasBorder,this.clickFunction});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Ink(
        decoration: BoxDecoration(
            color: hasBorder?Colors.white : Colors.redAccent,
            borderRadius: BorderRadius.circular(10),
            border: hasBorder?
            Border.all(color: Colors.redAccent,width: 1.0)
                : Border.fromBorderSide(BorderSide.none)
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 50,
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18.0,
                  color: !hasBorder?Colors.grey[100] : Colors.redAccent,
                ),
              ),
            ),
          ),
          onTap: clickFunction,
        ),
      ),
    );
  }
}
