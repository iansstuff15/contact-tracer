import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String title;
  final Color color;
  final VoidCallback onPressed;

  AppButton({
    required this.title,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            primary: color, // background
            onPrimary: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            ), // foreground
          ),
          child: Container(height: 50, child: Center(child: Text(title)))),
    );
  }
}
