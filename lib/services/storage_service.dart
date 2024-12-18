import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as p;

class StorageService {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  StorageService();

  Future<String?> uploadUserProfile({
    required File file,
    required String uid,
  }) async {
    try {
      // Check if the file exists
      if (!file.existsSync()) {
        throw Exception('File does not exist');
      }

      // Correct file reference creation
      Reference fileRef = _firebaseStorage.ref('users/profileImage').child(
            '$uid${p.extension(file.path)}', // Removed space between uid and extension
          );

      // Upload file and get download URL
      UploadTask task = fileRef.putFile(file);
      TaskSnapshot snapshot = await task;
      return await fileRef.getDownloadURL();
    } catch (e) {
      // Log and handle errors
      print('Error uploading profile image: $e');
      return null;
    }
  }
}
