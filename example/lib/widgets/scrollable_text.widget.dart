import 'package:flutter/material.dart';

class ScrollableText extends StatelessWidget {
  final String data;

  const ScrollableText(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: Text(data));
  }
}
