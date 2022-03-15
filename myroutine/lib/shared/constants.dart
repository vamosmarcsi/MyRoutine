import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.brown, width: 1.0)),
  focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: myPrimaryColor, width: 2.5)),
);

const myPrimaryColor = Colors.brown;
//lila:Color(0xFF7E57C2);
const myPrimaryLightColor = Color(0xFFA1887F);
//világoslila: Color(0xFFD1C4E9);
