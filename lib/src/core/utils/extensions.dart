import 'package:flutter/material.dart';

extension WidgetPaddingExtensions on Widget {
  Widget paddingAll(double value) => Padding(padding: EdgeInsets.all(value), child: this);
  Widget paddingSymmetric({double vertical = 0, double horizontal = 0}) => Padding(padding: EdgeInsets.symmetric(vertical: vertical, horizontal: horizontal), child: this);
}
