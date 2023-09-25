import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:localization/view/helper/snackbar_helper.dart';

class FirebaseApi {
  static final FirebaseApi instance = FirebaseApi._internal();

  FirebaseApi._internal();

  factory FirebaseApi() => instance;
  final storageRef = FirebaseStorage.instance.ref();
  final db = FirebaseFirestore.instance;

  Future<void> writeToFirestore({
    required String root,
    required String path,
    required Map<String, String> data,
  }) async {
    await db
        .collection(root)
        .doc(path)
        .set(data)
        .onError((e, _) => _errorLogger(e));
  }

  Future<String?> getStoragePath({required String firestorePath}) async {
    final docRef = db.collection("storage").doc(firestorePath);
    try {
      final document = await docRef.get();
      final Map<String, dynamic>? data = document.data();
      return data?["path"];
    } on FirebaseException catch (e) {
      _errorLogger(e);
      return null;
    }
  }

  Future<bool> uploadToStorage({
    required String path,
    required File data,
  }) async {
    await storageRef.child(path).putFile(data);
    try {
      await storageRef.child(path).putFile(data);
      return true;
    } on FirebaseException catch (e) {
      _errorLogger(e);
      return false;
    }
  }

  Future<List<Reference>> fetchStorageRefs({required String path}) async {
    final fileList = await storageRef.child(path).listAll();
    return fileList.items.reversed.toList();
  }

  void _errorLogger(dynamic e) {
    if (kDebugMode) {
      print(e);
    }
    SnackBarHelper().show("エラー: $e");
  }
}
