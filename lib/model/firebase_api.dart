import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:localization/view/helper/snackbar_helper.dart';
import 'package:localization/view_model/floor_map/pin/pin.dart';
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
      _log("Add document to id: ${document.id}");
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
      _log("Write document: $path");
    } catch (e) {
      _errorLogger(e);
    }
  }

  Future<List<Pin>> fetchPins({required String root}) async {
    try {
      final querySnapshot = await db.collection(root).get();
      final pins = <Pin>[];
      for (var query in querySnapshot.docs) {
        final data = query.data();
        pins.add(Pin(
          id: query.id,
          x: int.parse(data["x"]),
          y: int.parse(data["y"]),
        ));
      }
      _log("Fetch pins: $pins");
      return pins;
    } catch (e) {
      _errorLogger(e);
      return [];
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
        _log("Get storage path: $path");
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
      _log("Get storage path: $generatedPath");
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
    try {
      await storageRef.child(path).putFile(data);
      _log("Upload to storage: $path");
      return true;
    } catch (e) {
      _errorLogger(e);
      return false;
    }
  }

  Future<List<Reference>> fetchStorageRefs({required String path}) async {
    final fileList = await storageRef.child(path).listAll();
    final sortedFileList = fileList.items.reversed.toList();
    _log("Fetch storage refs: $sortedFileList");
    return sortedFileList;
  }

  Future<void> deleteFromStorage({required String firestoreId}) async {
    try {
      final deletesAsync = <Future>[];
      final storagePath = await getStoragePath(firestoreId: firestoreId);
      final storageRefs = await fetchStorageRefs(path: storagePath!);
      for (final ref in storageRefs) {
        deletesAsync.add(ref.delete());
      }

      deletesAsync.add(db.collection("storage").doc(firestoreId).delete());
      await Future.wait(deletesAsync);
      _log("Delete from storage to id: $firestoreId");
    } catch (e) {
      _errorLogger(e);
    }
  }

  void _log(dynamic t) {
    if (kDebugMode) {
      print(t);
    }
  }

  void _errorLogger(dynamic e) {
    if (kDebugMode) {
      print(e);
    }
    SnackBarHelper().show("エラー: $e");
  }
}
