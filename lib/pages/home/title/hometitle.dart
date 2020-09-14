import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: const Divider(
            height: 10,
            thickness: 1,
            indent: 0,
            endIndent: 40,
            color: Colors.black26,
          ),
        ),
        Text('Tasks',
            style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    color: Colors.black87,
                    fontSize: 42.0,
                    fontWeight: FontWeight.bold))),
        SizedBox(
          width: 16.0,
        ),
        Text('Lists',
            style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    color: Colors.black54,
                    fontSize: 42.0,
                    fontWeight: FontWeight.w200))),
        Expanded(
          child: const Divider(
            height: 10,
            thickness: 1,
            indent: 40,
            endIndent: 0,
            color: Colors.black26,
          ),
        ),
      ],
    );
  }
}
