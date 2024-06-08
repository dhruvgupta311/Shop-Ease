import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessengerState? scaffoldMessenger = ScaffoldMessenger.of(context);
  if (scaffoldMessenger != null) {
    scaffoldMessenger.showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
  } else {
    debugPrint("ScaffoldMessenger.of(context) returned null. Cannot show SnackBar.");
  }
}

Future<List<File>> pickImages() async {
  List<File> images = [];
  try {
    var files = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
    );
    if (files != null && files.files.isNotEmpty) {
      for (int i = 0; i < files.files.length; i++) {
        if (files.files[i].path != null) {
          images.add(File(files.files[i].path!));
        }
      }
    }
  } catch (e) {
    debugPrint("Error picking images: $e");
  }
  return images;
}
