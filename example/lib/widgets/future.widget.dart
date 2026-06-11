import 'package:flutter/material.dart';

class FutureText extends StatelessWidget {
  const FutureText(this.data, {super.key});

  final Future<String> data;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: data,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox.shrink();
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        return Text(snapshot.data ?? '');
      },
    );
  }
}
