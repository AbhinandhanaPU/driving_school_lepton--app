import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:new_project_app/constant/utils/utils.dart';

final server = FirebaseFirestore.instance;
final serverAuth = FirebaseAuth.instance;
final serverStorage = FirebaseStorage.instance;

void handleFirebaseError(FirebaseAuthException error) {
  switch (error.code) {
    case 'invalid-email':
      showToast(msg: 'invalid-email');
      break;
    case 'user-disabled':
      showToast(msg: 'user-disabled');
      break;
    case 'user-not-found':
      showToast(msg: 'user-not-found');
      break;
    case 'wrong-password':
      showToast(msg: 'wrong-password');
      break;
    case 'invalid-credential':
      showToast(msg: 'Invalid-credential');
      break;

    default:
      showToast(msg: 'Something went wrong');
      break;
  }
}
