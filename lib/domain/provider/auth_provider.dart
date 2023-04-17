import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../app/app_toast.dart';
import '../model/user_model.dart';

class AuthProvider extends GetxService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GetStorage _getStorage = GetStorage();
  final DatabaseReference _databaseReference =
      FirebaseDatabase.instance.ref().child('users');

  Future<UserModel?> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      final UserModel user = UserModel(
          uuid: userCredential.user!.uid,
          name: _databaseReference
              .child(userCredential.user!.uid)
              .child('name')
              .toString(),
          email: userCredential.user!.email!,
          password: password);
      _getStorage.write('user', user.toJson());
      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        AppToast.showError('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        AppToast.showError('Wrong password provided for that user.');
      } else if (e.code == 'invalid-email') {
        AppToast.showError('Invalid email.');
      } else {
        AppToast.showError(e.message!);
      }
      return null;
    }
  }

  Future<UserModel?> signUp(String email, String password, String name) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      _databaseReference.child(userCredential.user!.uid).set({
        'name': name,
        'email': email,
      });
      final UserModel user = UserModel(
          uuid: userCredential.user!.uid,
          name: name,
          email: userCredential.user!.email!,
          password: password);
      _getStorage.write('user', user.toJson());
      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        AppToast.showError('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        AppToast.showError('The account already exists for that email.');
      } else if (e.code == 'invalid-email') {
        AppToast.showError('Invalid email.');
      } else {
        AppToast.showError(e.message!);
      }
      return null;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    _getStorage.remove('user');
  }

  UserModel? getCurrentUser() {
    User? user = _auth.currentUser;
    if (user != null) {
      final UserModel userModel = UserModel.fromJson(_getStorage.read('user'));

      return userModel;
    }
    return null;
  }
}
