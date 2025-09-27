import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonWebWidget extends StatefulWidget {
  String title;
  Color color;
  Function onTap;
  bool outlined;
  EdgeInsets? padding;
  IconData? icon;
  Color borderColor;
  double borderWidth;
  double height;
  Color backgroundColor;
  Color titleColor;
  double borderRadius;
  double titleFontSize;

  ButtonWebWidget({
    Key? key,
    required this.title,
    required this.color,
    required this.onTap,
    this.outlined = false,
    this.icon,
    this.padding,
    this.borderColor = Colors.transparent,
    this.borderWidth = 0,
    this.height = 40,
    this.backgroundColor = Colors.transparent,
    this.titleColor = Colors.black,
    this.borderRadius = 0,
    this.titleFontSize = 18,
  }) : super(key: key);

  @override
  State<ButtonWebWidget> createState() => _ButtonWebWidgetState();
}

class _ButtonWebWidgetState extends State<ButtonWebWidget> {
  @override
  Widget build(BuildContext context) {
    return registrationButtons(
      widget.title,
      widget.color,
          () => widget.onTap(),
    );
  }

  Widget registrationButtons(String title, Color color, Function onTap) {
    return IntrinsicWidth(
      child: Material(
        child: Container(
          height: 40,
          child: ElevatedButton(
            onPressed: () => widget.onTap(),
            style: ElevatedButton.styleFrom(
              side: BorderSide(
                color: widget.borderColor,
                width: widget.borderWidth,
              ),
              fixedSize: Size.fromHeight(widget.height),
              backgroundColor: widget.backgroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (widget.icon != null)
                  Icon(
                    widget.icon,
                    color: Colors.black,
                  ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: widget.titleFontSize,
                      fontWeight: FontWeight.w700,
                      color: widget.outlined ? widget.color : widget.titleColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
