import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:localization/constant/i208_map_size.dart';
import 'package:localization/view/helper/snackbar_helper.dart';
import 'package:localization/view_model/floor_map/pin/pin.dart';
import 'package:uuid/uuid.dart';

import 'geolocation/geolocation_state/geolocation_state.dart';

class FirebaseApi {
  static final FirebaseApi instance = FirebaseApi._internal();

  FirebaseApi._internal();

  factory FirebaseApi() => instance;
  final storage = FirebaseStorage.instance.ref();
  final db = FirebaseFirestore.instance;

  Future<String> addToFirestore({
    required String root,
    required Map<String, String> data,
  }) async {
    try {
      final document = await db.collection(root).add(data);
      _log("Add document to id: ${document.id}");
      return document.id;
    } catch (e, stackTrace) {
      _errorLogger(e, stackTrace);
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
    } catch (e, stackTrace) {
      _errorLogger(e, stackTrace);
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
          x: I208MapSize().convertToPinX(int.parse(data["x"])),
          y: I208MapSize().convertToPinY(int.parse(data["y"])),
        ));
      }
      _log("Fetch pins: $pins");
      return pins;
    } catch (e, stackTrace) {
      _errorLogger(e, stackTrace);
      return [];
    }
  }

  Future<String?> getStoragePath({required String firestoreId}) async {
    if (firestoreId.isEmpty) {
      return "Temp";
    }
    try {
      final docRef = db.collection("i208").doc(firestoreId);
      final document = await docRef.get();
      final Map<String, dynamic>? data = document.data();
      final path = data?["path"];
      _log("Get storage path: $path");
      return path;
    } catch (e, stackTrace) {
      _errorLogger(e, stackTrace);
      return null;
    }
  }

  Future<bool> uploadToStorage({
    required String firestoreId,
    required String name,
    required File data,
    GeolocationState? geolocation,
  }) async {
    try {
      String? path = await getStoragePath(firestoreId: firestoreId);
      // パスが存在しない場合は新しくフォルダ生成
      if (path == null) {
        path = const Uuid().v4();
        await writeToFirestore(
          root: "i208",
          path: firestoreId,
          data: {
            "path": path,
          },
          update: true,
        );
      }
      // GPS情報が含まれる場合は追加
      if (geolocation != null) {
        await writeToFirestore(
          root: "i208",
          path: firestoreId,
          data: geolocation
              .toJson()
              .map((key, value) => MapEntry(key, value.toString())),
          update: true,
        );
      }
      await storage.child("$path/$name").putFile(data);
      _log("Upload to storage: $path");
      return true;
    } catch (e, stackTrace) {
      _errorLogger(e, stackTrace);
      return false;
    }
  }

  Future<List<Reference>> fetchStorageRefs({required String path}) async {
    final fileList = await storage.child(path).listAll();
    final sortedFileList = fileList.items.reversed.toList();
    _log("Fetch storage refs: $sortedFileList");
    return sortedFileList;
  }

  Future<void> deleteFromStorage({required String firestoreId}) async {
    try {
      final deletesAsync = <Future>[];
      final storagePath = await getStoragePath(firestoreId: firestoreId);
      if (storagePath != null) {
        final storageRefs = await fetchStorageRefs(path: storagePath);
        for (final ref in storageRefs) {
          deletesAsync.add(ref.delete());
        }
      }
      deletesAsync.add(db.collection("i208").doc(firestoreId).delete());
      await Future.wait(deletesAsync);
      _log("Delete from storage to id: $firestoreId");
    } catch (e, stackTrace) {
      _errorLogger(e, stackTrace);
    }
  }

  Future<void> deleteTempFiles() async {
    try {
      final deletesAsync = <Future>[];
      final storageRefs = await fetchStorageRefs(path: "Temp");
      for (final ref in storageRefs) {
        deletesAsync.add(ref.delete());
      }
      await Future.wait(deletesAsync);
      _log("Delete temp files from storage");
    } catch (e, stackTrace) {
      _errorLogger(e, stackTrace);
    }
  }

  Future<void> copyStorageFiles({
    required String srcPath,
    required String destPath,
  }) async {
    try {
      final srcAsync = <Future>[];
      final storageRefs = await fetchStorageRefs(path: srcPath);
      for (final ref in storageRefs) {
        srcAsync.add(ref.getData());
      }
      final srcData = await Future.wait(srcAsync);

      final destAsync = <Future>[];
      for (int i = 0; i < storageRefs.length; i++) {
        destAsync.add(
          storage.child("$destPath/${storageRefs[i].name}").putData(srcData[i]),
        );
      }
      await Future.wait(destAsync);
      _log("Copy storage files: $storageRefs");
    } catch (e, stackTrace) {
      _errorLogger(e, stackTrace);
    }
  }

  void _log(dynamic t) {
    if (kDebugMode) {
      print(t);
    }
  }

  void _errorLogger(dynamic e, dynamic stackTrace) {
    if (kDebugMode) {
      print(e);
      print(stackTrace);
    }
    SnackBarHelper().show("エラー: $e");
  }
}
