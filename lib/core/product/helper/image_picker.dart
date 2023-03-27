import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class IImagePicker extends StatelessWidget {
  IImagePicker({super.key, required this.title});
  final ImagePicker _picker = ImagePicker();
  final String title;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black, minimumSize: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height * 0.08)),
        onPressed: () async {
          //final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
        },
        icon: const Icon(Icons.image),
        label: Text(title));
  }
}
