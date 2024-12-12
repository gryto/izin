import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  final Function()? onPressed;
  final String label;
  final Size minimumSize;
  final double? fontSize;
  const DefaultButton(
      {super.key,
      required this.onPressed,
      required this.label,
      required this.minimumSize, this.fontSize});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          minimumSize: minimumSize),
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Text(
          label,
          style: TextStyle(
              fontSize: fontSize ?? 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
