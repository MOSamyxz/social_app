// ignore_for_file: use_build_context_synchronously

import 'dart:typed_data';

import 'package:chatapp/core/routes/routes.dart';
import 'package:chatapp/core/services/cache_helper.dart';
import 'package:chatapp/data/firebase_auth/firebase_storage_services.dart';
import 'package:chatapp/data/model/user_model.dart';
import 'package:chatapp/generated/l10n.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseAuthServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signUp({
    required String email,
    required String password,
    required BuildContext context,
    required String username,
    required String gender,
    required Uint8List file,
  }) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final lastStory =
          Timestamp.fromDate(DateTime.now().subtract(const Duration(hours: 1)));

      String photoUrl = await FirebaseStorageServices()
          .uploadImageToStorage('Pics', 'profile', file, false);
      UsersModel user = UsersModel(
        userName: username,
        uId: credential.user!.uid,
        imageUrl: photoUrl,
        email: email,
        bio: '',
        gender: gender,
        birthDay: '',
        followers: [],
        following: [],
        receivedRequest: [],
        sentRequest: [],
        coverUrl: '',
        lastActive: DateTime.now(),
        isOnline: true,
        lastStory: lastStory,
      );

      await _firestore
          .collection("users")
          .doc(credential.user!.uid)
          .set(user.toMap());

      String uId = credential.user!.uid;

      CacheHelper.sharedPreferences.setString('uId', uId);

      _auth.currentUser!.sendEmailVerification();

      if (!context.mounted) return;
      GoRouter.of(context).pushReplacement(Routes.signInScreen);
      Fluttertoast.showToast(
        msg: S.of(context).checkEmail,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Fluttertoast.showToast(
          msg: S.of(context).weakPassword,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      } else if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(
          msg: S.of(context).emailAlreadyInUse,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signIn({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      if (credential.user!.emailVerified) {
        GoRouter.of(context).pushReplacement(Routes.applayout);
      } else {
        Fluttertoast.showToast(
          msg: S.of(context).verifyEmail,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(
          msg: S.of(context).noUserForThisEmail,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(
          msg: S.of(context).wrongPassword,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateEmail(BuildContext context, String newEmail) async {
    try {
      await _auth.currentUser!.verifyBeforeUpdateEmail(newEmail);
      Fluttertoast.showToast(
        msg: S.of(context).checkEmail,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        Fluttertoast.showToast(
          msg: 'Please log in again',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      } else {
        print('Firebase Auth Exception: ${e.code}');
      }
    } catch (e) {
      print('Error sending verification email: $e');
    }
  }

  Future<void> updatePassword(String newPassword) async {
    try {
      await _auth.currentUser!.updatePassword(newPassword);
      Fluttertoast.showToast(
        msg: 'Password has been updated',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    } catch (e) {
      if (e is FirebaseAuthException) {
        if (e.code == 'requires-recent-login') {
          Fluttertoast.showToast(
            msg: 'Please log in again',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
          );
        } else {
          // Handle other FirebaseAuthException errors
          print('Error updating password: ${e.message}');
        }
      } else {
        // Handle other exceptions
        print('Error updating password: $e');
      }
    }
  }

  Future<bool> validatePassword(BuildContext context, String password) async {
    var firebaseUser = _auth.currentUser;
    var authCredentials = EmailAuthProvider.credential(
        email: firebaseUser!.email!, password: password);
    try {
      var authResult =
          await firebaseUser.reauthenticateWithCredential(authCredentials);
      return authResult.user != null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(
          msg: S.of(context).noUserForThisEmail,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(
          msg: S.of(context).wrongPassword,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      }
      return false;
    } on Exception catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<void> signOut(context) async {
    await _auth.signOut();
    GoRouter.of(context).pushReplacement(Routes.signInScreen);
  }

  Future<void> resetPassword({
    required BuildContext context,
    required String email,
  }) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      if (!context.mounted) return;
      GoRouter.of(context).push(Routes.signInScreen);
      Fluttertoast.showToast(
        msg: S.of(context).checkEmailResetPassword,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code.toString() == 'user-not-found') {
        Fluttertoast.showToast(
          msg: S.of(context).noUserForThisEmail,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      }
    } catch (e) {
      rethrow;
    }
  }
}
