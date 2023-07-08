import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class IImagePicker extends StatefulWidget {
  IImagePicker({super.key, required this.title});
  final String title;

  @override
  State<IImagePicker> createState() => _IImagePickerState();
}

class _IImagePickerState extends State<IImagePicker> {
  final ImagePicker _picker = ImagePicker();

  File? _image;

  Future<File?> _cropImage({required File imageFile}) async {
    CroppedFile? croppedImage =
        await ImageCropper().cropImage(sourcePath: imageFile.path, aspectRatio: CropAspectRatio(ratioX: 16, ratioY: 9));
    if (croppedImage == null) return null;

    return File(croppedImage.path);
  }

  @override
  Widget build(BuildContext context) {
    final ImagePicker picker = ImagePicker();
    File? selectedImages;
    //
    Future _pickImage(ImageSource source) async {
      try {
        final image = await picker.pickImage(source: source);
        if (image == null) return;

        File? img = File(image.path);
        img = await _cropImage(imageFile: img);

        setState(() {
          selectedImages = img;
        });
        //Navigator.of(context).pop();
      } on PlatformException catch (e) {
        Navigator.of(context).pop();
      }
    }

    return ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black, minimumSize: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height * 0.08)),
        onPressed: () {
          showDialog<void>(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Basic dialog title'),
                content: selectedImages == null ? const Text("Data yok") : Image.file(selectedImages!),
                actionsAlignment: MainAxisAlignment.center,
                actions: <Widget>[
                  TextButton(
                    child: const Text('Galari'),
                    onPressed: () async {
                      //Navigator.of(context).pop();
                      await _pickImage(ImageSource.gallery);
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: const Text('Kamera'),
                    onPressed: () async {
                      await _pickImage(ImageSource.camera);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );

// Pick an image.
          //final XFile? image = await picker.pickImage(source: ImageSource.gallery);
        },
        icon: const Icon(Icons.image),
        label: selectedImages == null ? Text(widget.title) : const Icon(Icons.check));
  }
}
