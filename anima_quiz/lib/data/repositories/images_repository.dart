import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class ImagesRepository {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Reference getImage(String imagePath) {
    return _storage.ref(imagePath);
  }

  Future<void> uploadImage(String uuid, File image) async {
    await _storage.ref(uuid).putFile(image);
  }
}
