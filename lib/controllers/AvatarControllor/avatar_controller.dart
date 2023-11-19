import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_firebase_project_app/Utils/utils.dart';
import 'package:flutter_firebase_project_app/services/FireStorage_services/ImageStorage_services.dart';
import 'package:image_picker/image_picker.dart';

class AvatarController {
  final ImagePicker _imagePicker = ImagePicker();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CloudImageServices _cloudImageServices = CloudImageServices();

  Future<void> saveAvatar(File? avatarImage, String uid) async {
    if (avatarImage != null) {
      await _cloudImageServices.uploadImageToFirebaseStorage(avatarImage!, uid);
    }
    if (avatarImage == null) {
      Utils.toastMessage('Please Select Image');
      // await _cloudImageServices.uploadImageToFirebaseStorage(
      //     File('assets/images/avatar.png'), uid);
    }
  }

  Future getAvatar(String uid) async {
    return await _cloudImageServices.getImageFromFireBaseStorage(uid);
  }

  Future<File?> pickImageFromGallery() async {
    final pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return null;
    return File(pickedFile.path);
  }

  Future<File?> pickImageFromCamera() async {
    final pickedFile = await _imagePicker.pickImage(source: ImageSource.camera);
    print(pickedFile);
    if (pickedFile == null) return null;

    return File(pickedFile.path);
  }
}
