import 'package:flutter/material.dart';

import '../../../Data/Models/category_model.dart';

enum OrganizerCategories {
  FOOD,
  CULTURAL,
  TOURISTY,
  SHOOP,
  CHARITABLE,
  COMPETITION,
  RELIGIOUS,
  ART,
  BUSINESS,
  EDUCATION,
  MUSIC,
}

List<CategoryModel> allCategoryList = [
  CategoryModel(OrganizerCategories.FOOD.name, Icons.lunch_dining_rounded, false, Colors.amber),
  CategoryModel(OrganizerCategories.CULTURAL.name, Icons.theater_comedy_rounded, false, Colors.purple),
  CategoryModel(OrganizerCategories.TOURISTY.name, Icons.beach_access, false, Colors.blueGrey),
  CategoryModel(OrganizerCategories.SHOOP.name, Icons.shopping_bag_rounded, false, Colors.cyan),
  CategoryModel(OrganizerCategories.CHARITABLE.name, Icons.handshake_rounded, false, Colors.red),
  CategoryModel(OrganizerCategories.COMPETITION.name, Icons.emoji_events_rounded, false, Colors.blueAccent),
  CategoryModel(OrganizerCategories.RELIGIOUS.name, Icons.mosque_rounded, false, Colors.black54),
];
