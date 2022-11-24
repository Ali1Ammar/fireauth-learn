import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  Future<User> create(String name, String email, String password) async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    await FirebaseAuth.instance.currentUser!.updateDisplayName(name);
    final user = FirebaseAuth.instance.currentUser!;
    if (!user.emailVerified) {
      FirebaseAuth.instance.currentUser!.sendEmailVerification();
    }

    return FirebaseAuth.instance.currentUser!;
  }

  Future<User> login(String email, String password) async {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    final user = FirebaseAuth.instance.currentUser!;
    if (!user.emailVerified) {
      FirebaseAuth.instance.currentUser!.sendEmailVerification();
    }

    return FirebaseAuth.instance.currentUser!;
  }

  updatePhoto(String imageUrl) {
    FirebaseAuth.instance.currentUser!.updatePhotoURL(imageUrl);
  }

  User? currentUser() {
    return FirebaseAuth.instance.currentUser;
  }
}
