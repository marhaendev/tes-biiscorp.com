import 'package:flutter/material.dart';

// noRadius
var elevatedNoRadius = ElevatedButton.styleFrom(shape: noRadius);
Widget boxY(double i) => SizedBox(
      height: i,
    );
Widget boxX(double i) => SizedBox(
      width: i,
    );
radius(double i) =>
    RoundedRectangleBorder(borderRadius: BorderRadius.circular(i));
var noRadius = radius(0);

EdgeInsets padding(double top, [double? right, double? bottom, double? left]) {
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

var noPadding = padding(0);
var noEdge = padding(0);
edge(double e, int i) => padding(e);
