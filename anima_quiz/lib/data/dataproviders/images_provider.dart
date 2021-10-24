import 'dart:io';

import 'package:anima_quiz/data/repositories/images_repository.dart';

class ImagesProvider {
  final _repository = ImagesRepository();

  Future<String> getImage(String imagePath) {
    return _repository.getImage(imagePath).getDownloadURL();
  }

  Future<void> uploadImage(String uuid, File image) async {
    try {
      await _repository.uploadImage(uuid, image);
    } catch (e) {
      print(e.toString());
    }
  }
}
