import 'package:flutter/material.dart';

class CategoryModel {
  String? name;
  IconData? icon;
  bool? onSelect;
  Color? color;
  CategoryModel(this.name, this.icon, this.onSelect, this.color);
  String? markerUrl;
}
