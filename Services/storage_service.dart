import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
// import '../helpers/enums.dart';

class StorageServices {
  static final FirebaseStorage _storage = FirebaseStorage.instance;

  static Future<String> uploadFile(
        File file, Function(double) onProgress) async
  {
    String filePath =
        "${DateTime.now().millisecondsSinceEpoch}-${file.path.split('/').last}";
    final storageRef = _storage
        .ref()
        .child("data")
        .child(filePath);

    // Create a new upload task to upload the file
    final uploadTask = storageRef.putFile(file);
    // Listen for state changes, errors, and completion of the upload.
    uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
      final progress = snapshot.bytesTransferred / snapshot.totalBytes;

      onProgress(progress * 100); // report progress using the provided callback
    }, onError: (error) {
      throw Exception('Failed to upload file: $error');
    });

    // Wait for the upload task to complete
    await uploadTask;
    return await uploadTask.snapshot.ref.getDownloadURL();
  }

  static Future<List<String>> uploadMultiFiles(
      List<File> files, Function(double) onProgress) async {
    List<String> dbFilePath = [];
    List<double> progressList = [];
    List<Future> waitList = [];
    for (var file in files) {
      progressList.add(0.0);
      String filePath =
          "${DateTime.now().millisecondsSinceEpoch}-${file.path.split('/').last}";
      final storageRef = _storage
          .ref()
          .child("data")
          .child(filePath);

      // Create a new upload task to upload the file
      final uploadTask = storageRef.putFile(file);
      // Listen for state changes, errors, and completion of the upload.
      uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
        progressList[files.indexOf(file)] =
            snapshot.bytesTransferred / snapshot.totalBytes;
        double totalProgress = 0;
        for (double element in progressList) {
          totalProgress += element;
        }
        onProgress((totalProgress / progressList.length) *
            100); // report progress using the provided callback
      }, onError: (error) {
        throw Exception('Failed to upload file: $error');
      });
      waitList.add(uploadTask);
    }
    var result = await Future.wait(waitList);
    for (var element in result) {
      dbFilePath.add(await element.ref.getDownloadURL());
    }
    return dbFilePath;
  }
  static Future<List<String>> uploadMultiUint8ListFiles(List<Uint8List> uint8Lists, Function(double) onProgress) async {
    List<String> downloadURLs = [];
    List<double> progressList = [];
    List<Future> waitList = [];

    for (var i = 0; i < uint8Lists.length; i++) {
      progressList.add(0.0);

      String filePath = "${DateTime.now().millisecondsSinceEpoch}-file$i";
      final storageRef = _storage.ref().child("data").child(filePath);

      final uploadTask = storageRef.putData(uint8Lists[i]);

      uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
        progressList[i] = snapshot.bytesTransferred / snapshot.totalBytes;
        double totalProgress = progressList.reduce((a, b) => a + b);
        onProgress((totalProgress / progressList.length) * 100);
      }, onError: (error) {
        throw Exception('Failed to upload file: $error');
      });

      waitList.add(uploadTask);
    }

    var results = await Future.wait(waitList);
    for (var result in results) {
      downloadURLs.add(await result.ref.getDownloadURL());
    }

    return downloadURLs;
  }

  static Future<List<String>> uploadMultiUint8ListFilesWithCustomNames( List<Uint8List> uint8Lists, List<String> fileNames, Function(double) onProgress) async {
    List<String> downloadURLs = [];
    List<double> progressList = [];
    List<Future> waitList = [];

    for (var i = 0; i < uint8Lists.length; i++) {
      progressList.add(0.0);
      String fileName = fileNames.length > i ? fileNames[i] : "file$i";

      String filePath = "${DateTime.now().millisecondsSinceEpoch}-$fileName";
      final storageRef = _storage.ref().child("data").child(filePath);

      final uploadTask = storageRef.putData(uint8Lists[i]);

      uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
        progressList[i] = snapshot.bytesTransferred / snapshot.totalBytes;
        double totalProgress = progressList.reduce((a, b) => a + b);
        onProgress((totalProgress / progressList.length) * 100);
      }, onError: (error) {
        throw Exception('Failed to upload file: $error');
      });

      waitList.add(uploadTask);
    }

    var results = await Future.wait(waitList);
    for (var result in results) {
      downloadURLs.add(await result.ref.getDownloadURL());
    }

    return downloadURLs;
  }

}
