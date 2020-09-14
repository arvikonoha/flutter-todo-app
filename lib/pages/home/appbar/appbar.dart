import 'package:flutter/material.dart';

class CustAppbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 36.0, vertical: 48.0),
      child: Row(children: <Widget>[
        Image(
          image: AssetImage('graphics/leading-icon.png'),
          width: 28,
          fit: BoxFit.fitWidth,
        )
      ]),
    );
  }
}
