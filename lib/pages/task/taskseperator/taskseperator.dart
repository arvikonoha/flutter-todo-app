import 'package:flutter/material.dart';

class TaskSeparator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Divider(
      height: 10,
      indent: 80,
      endIndent: 0,
      thickness: 1,
      color: Colors.black12,
    );
  }
}
