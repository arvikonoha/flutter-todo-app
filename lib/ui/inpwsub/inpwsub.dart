import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

typedef void OnFieldSubmittedCallback(String field);

class CustInputWithForm extends StatefulWidget {
  CustInputWithForm(
      {this.initFieldValue,
      this.onFieldSubmit,
      this.placeholder,
      this.isCircular,
      this.buttonColor});
  final String placeholder;
  final String initFieldValue;
  final bool isCircular;
  final Color buttonColor;
  final OnFieldSubmittedCallback onFieldSubmit;

  CIWFState createState() => CIWFState(
      placeholder: placeholder,
      field: initFieldValue,
      buttonColor: buttonColor,
      onFieldSubmit: onFieldSubmit,
      isCircular: isCircular);
}

class CIWFState extends State<CustInputWithForm> {
  final _formkey = GlobalKey<FormState>();
  CIWFState(
      {this.field,
      @required this.onFieldSubmit,
      this.placeholder,
      this.isCircular,
      this.buttonColor});
  String field;
  final String placeholder;

  final bool isCircular;
  final Color buttonColor;
  final OnFieldSubmittedCallback onFieldSubmit;

  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
              margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 2.0),
              child: Form(
                key: _formkey,
                child: TextFormField(
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(16.0),
                      hintStyle: GoogleFonts.alata(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.black45)),
                      hintText: placeholder),
                  initialValue: field,
                  onChanged: (text) {
                    setState(() {
                      field = text;
                    });
                  },
                  validator: (value) {
                    if (value.isEmpty)
                      return "Please enter some text";
                    else
                      return null;
                  },
                ),
              )),
        ),
        GestureDetector(
          onTap: () {
            if (_formkey.currentState.validate()) onFieldSubmit(field);
          },
          child: Container(
            margin: EdgeInsets.all(4.0),
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
                color: buttonColor,
                borderRadius: isCircular
                    ? BorderRadius.circular(100)
                    : BorderRadius.circular(10)),
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
