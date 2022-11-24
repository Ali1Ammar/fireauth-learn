import 'dart:math';

import 'package:fireauth/main.dart';
import 'package:fireauth/src/helper/nav_helper.dart';
import 'package:fireauth/src/model/service/auth_service.dart';
import 'package:fireauth/src/view/admin.dart';
import 'package:fireauth/src/view/profile.dart';
import 'package:fireauth/src/view/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AccountViewModel extends ChangeNotifier {
  final AuthService authService;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  User? get currentUser => authService.currentUser();
  AccountViewModel(this.authService) {
    Future.microtask(() {
      if (authService.currentUser() != null) {
        _goNextPage();
      }
    });
  }
  String? error;
  bool isLoading = false;

  pressCreateButton() async {
    run(() async {
      await authService.create(
          nameController.text, emailController.text, passwordController.text);
    });
  }

  void run(Future<void> Function() code) async {
    try {
      isLoading = true;
      error = null;
      notifyListeners();
      await code();
      _goNextPage();
    } on FirebaseAuthException catch (e) {
      error = e.message;
    } catch (e) {
      error = "unknown error";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  _goNextPage() {
    if (authService.currentUser()!.email == "admin1@admin.com") {
      NavigatorHelper.push(AdminPage());
    } else {
      NavigatorHelper.push(NoramlUserScreen());
    }
  }

  pressLoginButton() async {
    run(() async {
      await authService.login(emailController.text, passwordController.text);
    });
  }
}
