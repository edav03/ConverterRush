import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final String? text;
  const CustomAppBar({super.key, this.text});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: const Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
      ),
      title: (text != null) ? Text(text!) : const Text(''),
      backgroundColor: Colors.white10,
      elevation: 0,
    );
  }
}
