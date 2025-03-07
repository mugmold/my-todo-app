import 'dart:convert';
import 'dart:typed_data';

import 'package:shared_preferences/shared_preferences.dart';

Uint8List? profileImageBytes; // Menyimpan gambar profile user

// Class buat simpan dan load data profile picture user
class ProfilePictureData {
  static Future<bool> saveProfilePicture(List<int> imageBytes) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String base64Image = base64Encode(imageBytes);
    return prefs.setString('profilePicture', base64Image);
  }

  static Future<Uint8List?> getProfilePicture() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? base64ProfilePicture = prefs.getString('profilePicture');
    if (base64ProfilePicture == null) {
      return null;
    }
    return base64Decode(base64ProfilePicture);
  }
}
