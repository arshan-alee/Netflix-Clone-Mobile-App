import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadImage(File imageFile, String path) async {
    final Reference ref = _storage.ref().child(path);
    final UploadTask uploadTask = ref.putFile(imageFile);
    await uploadTask.whenComplete(() {});
    return await ref.getDownloadURL();
  }

  Future<String> getImageUrl(String path) async {
    final Reference ref = _storage.ref().child(path);
    return await ref.getDownloadURL();
  }
}
