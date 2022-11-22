import 'package:fireauth/src/model/service/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AccountViewModel extends ChangeNotifier {
  final AuthService authService;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  User? get currentUser => authService.currentUser();
  AccountViewModel(this.authService);

  pressButton() async {
    await authService.create(
        nameController.text, emailController.text, passwordController.text);
    notifyListeners();
  }
}
