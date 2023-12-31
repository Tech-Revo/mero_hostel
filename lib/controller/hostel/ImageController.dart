// ignore_for_file: file_names

import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageController extends GetxController {
  File? file;
  String? imageData;

  Future getImage({double? x, double? y}) async {
    var pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      var croppedImage = await ImageCropper().cropImage(
          sourcePath: pickedImage.path,
          aspectRatio: CropAspectRatio(ratioX: x ?? 3, ratioY: y ?? 2));
      if (croppedImage != null) {
        file = File(croppedImage.path);

        List<int> imageBytes = await File(croppedImage.path).readAsBytes();

        // Convert the image bytes to a Base64-encoded string
        String base64Image = base64Encode(imageBytes);
        imageData = base64Image;
      }

      update();
    }
  }
}
