import 'package:flutter/material.dart';

class ParaMimPage extends StatelessWidget {
  const ParaMimPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Material(
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: Text('Para Mim!'),
            ),
          ),
        ],
      ),
    );
  }
}
