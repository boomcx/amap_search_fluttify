import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({
    super.key,
    required this.label,
    required this.onPressed,
  });

  final String label;
  final ValueChanged<BuildContext> onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        backgroundColor: Colors.black,
        shape: const StadiumBorder(),
      ),
      onPressed: () => onPressed(context),
      child: Text(
        label,
        style: const TextStyle(color: Colors.white, fontSize: 15),
      ),
    );
  }
}
