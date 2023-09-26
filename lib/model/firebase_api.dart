import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:localization/view/helper/snackbar_helper.dart';
import 'package:uuid/uuid.dart';

class FirebaseApi {
  static final FirebaseApi instance = FirebaseApi._internal();

  FirebaseApi._internal();

  factory FirebaseApi() => instance;
  final storageRef = FirebaseStorage.instance.ref();
  final db = FirebaseFirestore.instance;

  Future<String> addToFirestore({
    required String root,
    required Map<String, String> data,
  }) async {
    try {
      final document = await db.collection(root).add(data);
      return document.id;
    } catch (e) {
      _errorLogger(e);
      return "";
    }
  }

  Future<void> writeToFirestore({
    required String root,
    required String path,
    required Map<String, String> data,
    bool update = false,
  }) async {
    try {
      if (update) {
        await db.collection(root).doc(path).update(data);
      } else {
        await db.collection(root).doc(path).set(data);
      }
    } catch (e) {
      _errorLogger(e);
    }
  }

  Future<String?> getStoragePath({required String firestoreId}) async {
    if (firestoreId.isEmpty) {
      return null;
    }
    try {
      final docRef = db.collection("storage").doc(firestoreId);
      final document = await docRef.get();
      final Map<String, dynamic>? data = document.data();
      final path = data?["path"];
      if (path != null) {
        return path;
      }
      final generatedPath = const Uuid().v4();
      writeToFirestore(
        root: "storage",
        path: firestoreId,
        data: {
          "path": generatedPath,
        },
        update: true,
      );
      return generatedPath;
    } catch (e) {
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
    } catch (e) {
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
