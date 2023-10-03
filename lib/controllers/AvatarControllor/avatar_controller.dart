import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class AvatarController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final ImagePicker _imagePicker = ImagePicker();

  Future<File?> pickImageFromGallery() async {
    final pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return null;
    return File(pickedFile.path);
  }

  Future<File?> pickImageFromCamera() async {
    final pickedFile = await _imagePicker.pickImage(source: ImageSource.camera);
    if (pickedFile == null) return null;
    return File(pickedFile.path);
  }

  Future<void> uploadImageToFirebaseStorage(File imageFile, String uid) async {
    print(imageFile.path);
    print(uid);
    final Reference storageRef =
        _storage.ref().child('avatars').child(uid).child('avatar.jpg');
    await storageRef.putFile(imageFile);
  }
}
