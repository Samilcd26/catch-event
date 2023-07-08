import 'package:flutter/material.dart';

SnackBar WarningMessage(String title, String description) {
  return SnackBar(
      backgroundColor: Colors.transparent,
      content: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontSize: 18, color: Colors.white)),
            Text(description, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 12, color: Colors.white)),
          ],
        ),
        padding: EdgeInsets.all(16),
        height: 90,
        decoration: const BoxDecoration(color: Color.fromARGB(255, 210, 102, 0), borderRadius: BorderRadius.all(Radius.circular(20))),
      ));
}

SnackBar SuccesMessage(String title, String description) {
  return SnackBar(
      backgroundColor: Colors.transparent,
      content: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontSize: 18, color: Colors.white)),
            Text(description, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 12, color: Colors.white)),
          ],
        ),
        padding: EdgeInsets.all(16),
        height: 90,
        decoration: const BoxDecoration(color: Color.fromARGB(255, 69, 201, 36), borderRadius: BorderRadius.all(Radius.circular(20))),
      ));
}

SnackBar ErrorMessage(String title, String description) {
  return SnackBar(
      backgroundColor: Colors.transparent,
      content: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontSize: 18, color: Colors.white)),
            Text(description, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 12, color: Colors.white)),
          ],
        ),
        padding: EdgeInsets.all(16),
        height: 90,
        decoration: const BoxDecoration(color: Color(0xFFC72C41), borderRadius: BorderRadius.all(Radius.circular(20))),
      ));
}
