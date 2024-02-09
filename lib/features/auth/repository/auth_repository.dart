import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fishnetlk/core/constants/firebaes_collection_names.dart';
import 'package:fishnetlk/core/constants/storage_folder_names.dart';
import 'package:fishnetlk/core/utils/utils.dart';
import 'package:fishnetlk/features/auth/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

//Author model creation
class AuthRepository {
  final _storage = FirebaseStorage.instance;
  final _firestore = FirebaseFirestore.instance;

  // create account
  Future<UserCredential?> createAccount({
    required String fullName,
    required DateTime birthday,
    required String gender,
    required File? image,
  }) async {
    try {
      // Save image to firebase storage
      final path = _storage
          .ref(StorageFolderNames.profilePics)
          .child(FirebaseAuth.instance.currentUser!.uid);

      if (image == null) {
        return null;
      }

      final taskSnapshot = await path.putFile(image);
      final downloadUrl = await taskSnapshot.ref.getDownloadURL();

      UserModel user = UserModel(
        fullName: fullName,
        birthDay: birthday,
        gender: gender,
        profilePicUrl: downloadUrl,
        uid: FirebaseAuth.instance.currentUser!.uid,
        friends: const [],
        sentRequests: const [],
        receivedRequests: const [],
      );

      // save user to firestore
      await _firestore
          .collection(FirebaseCollectionNames.users)
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set(
            user.toMap(),
          );

    } catch (e) {
      showToastMessage(text: e.toString());
      return null;
    }
  }

  // Verify Email
  Future<String?> verifyEmail() async {
    final user = FirebaseAuth.instance.currentUser;
    try {
      if (user != null) {
        user.sendEmailVerification();
      }
      return null;
    } catch (e) {
      showToastMessage(text: e.toString());
      return e.toString();
    }
  }

  // get user info
  Future<UserModel> getUserInfo() async {
    final userData = await _firestore
        .collection(FirebaseCollectionNames.users)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    final user = UserModel.fromMap(userData.data()!);
    return user;
  }
}
