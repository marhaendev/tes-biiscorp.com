import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// boxY
Widget boxY(double i) => SizedBox(
      height: i,
    );
// boxX
Widget boxX(double i) => SizedBox(
      width: i,
    );

AppBar appbar(title) => AppBar(title: Text(title));

// radius
radius(double i) =>
    RoundedRectangleBorder(borderRadius: BorderRadius.circular(i));

// noRadius
var noRadius = radius(0);

// elevatedNoRadius
var elevatedNoRadius = ElevatedButton.styleFrom(shape: noRadius);

EdgeInsets edge(double top, [double? right, double? bottom, double? left]) {
  if (right == null && bottom == null && left == null) {
    return EdgeInsets.all(top);
  } else if (bottom == null && left == null) {
    return EdgeInsets.symmetric(vertical: top, horizontal: right!);
  } else {
    return EdgeInsets.only(
        top: top,
        right: right ?? top,
        bottom: bottom ?? top,
        left: left ?? right ?? top);
  }
}

var noEdge = edge(0);

colorHex(value) => int.parse('0xFF${value.replaceFirst('#', '')}');

BoxDecoration blockquoteDecoration(color, width) =>
    BoxDecoration(border: Border(left: BorderSide(color: color, width: width)));

Widget blockquote(e, color, double width) {
  return Container(
    alignment: Alignment.centerLeft,
    margin: edge(10),
    padding: edge(0, 10),
    decoration: blockquoteDecoration(color, width),
    child: Text(
      e,
      style: GoogleFonts.firaCode(),
    ),
  );
}

// warna
const transparent = Colors.transparent;
const black = Colors.black;
const white = Colors.white;
const blue = Colors.blue;
const teal = Colors.teal;
const grey = Colors.grey;

// jsonBeauty
jsonBeauty(json) => JsonEncoder.withIndent('  ').convert(json);
