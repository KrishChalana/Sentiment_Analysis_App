import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Textfield extends StatefulWidget {
  const Textfield({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Textfield();
  }
}

class _Textfield extends State<Textfield> {
  void _updateText(val) {
    displayText = val;
  }

  final _formkey = GlobalKey<FormState>();

  var displayText = '';
  var _result = '';
  // String? name = '';

  void _getData() async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:3500/predict'),
      body: json.encode({'input': displayText}),
      headers: {
        "content-type": "application/json",
        "accept": "application/json",
      },
    );

    setState(() {
      _result = response.body;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            margin: EdgeInsets.all(30),
            alignment: Alignment.center,
            child: Form(
              key: _formkey,
              child: TextFormField(
                onChanged: (val) {
                  _updateText(val);
                },
                style: GoogleFonts.lato(color: Colors.red),
                decoration: InputDecoration(
                    labelText: 'Text',
                    icon: Icon(Icons.abc_outlined),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
                // controller: _the_controller,
              ),
            )),
        Container(
          width: 300,
          child: OutlinedButton(
            onPressed: () {
              _getData();
            },
            child: const Text(
              'Sumbit Now',
              style: TextStyle(color: Colors.white),
            ),
            style: OutlinedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20))),
          ),
        ),
        Container(
          margin: EdgeInsets.all(0),
          child: Text(
            'Result :  $_result',
            style: TextStyle(color: Colors.black),
          ),
        )
      ],
    );
  }
}
