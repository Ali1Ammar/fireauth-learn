import 'package:fireauth/src/helper/pick_image.dart';
import 'package:fireauth/src/model/service/auth_service.dart';
import 'package:fireauth/src/model/service/storage_service.dart';
import 'package:flutter/material.dart';

class ProfileViewModel extends ChangeNotifier {
  final StorageService storageService;
  final AuthService authService;

  ProfileViewModel(this.storageService, this.authService);

  uploadImage() async {
    final file = (await pickImage());
    if (file == null) return;
    final imageUrl = await storageService.uploadFile(file.name, file.path);
    authService.updatePhoto(imageUrl);
  }
}
