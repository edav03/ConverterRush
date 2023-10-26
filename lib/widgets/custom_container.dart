import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final String placeHolder;
  final void Function() onPressed;
  final Color backgroundColor;
  final MaterialStateProperty<Size?>? minimumSize;
  final Color? textColor;
  final Icon? icon;
  final bool? iconVisible;

  const CustomContainer({
    Key? key,
    required this.placeHolder,
    required this.onPressed,
    required this.backgroundColor,
    this.icon,
    this.minimumSize,
    this.textColor,
    this.iconVisible = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(backgroundColor),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        minimumSize:
            minimumSize ?? MaterialStateProperty.all(const Size(80, 80)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text(
              placeHolder,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                letterSpacing: 0.15,
                color: textColor ?? Colors.black,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
