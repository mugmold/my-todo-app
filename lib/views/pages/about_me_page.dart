import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_todo_app/data/constants.dart';
import 'package:my_todo_app/data/controllers.dart';
import 'package:my_todo_app/data/notifiers.dart';
import 'package:my_todo_app/data/personal_info.dart';
import 'package:my_todo_app/data/profile_picture_data.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutMePage extends StatefulWidget {
  const AboutMePage({super.key});

  @override
  State<AboutMePage> createState() => _AboutMePageState();
}

class _AboutMePageState extends State<AboutMePage> {
  String fullName = '';
  String nickname = '';
  String hobbies = '';
  String socialMedia = '';

  Future<void> _pickAndSaveProfilePicture() async {
    final picker = ImagePicker();
    final XFile? imageFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (imageFile == null) return;

    File file = File(imageFile.path);
    Uint8List bytes = await file.readAsBytes();

    await ProfilePictureData.saveProfilePicture(bytes);

    setState(() {
      profileImageBytes = bytes;
    });
  }

  Future<void> loadProfilePicture() async {
    profileImageBytes = await ProfilePictureData.getProfilePicture();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Constants.ristekPrimaryColor,
        ),
        Column(
          children: [
            SizedBox(height: 50),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                padding: EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: _pickAndSaveProfilePicture,
                        onLongPress: () {
                          // delete profile picture
                          if (profileImageBytes == null) return;
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Delete Profile Picture'),
                                content: Text(
                                    'Are you sure you want to delete your profile picture?'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      profileImageBytes = null;
                                      setState(() {});
                                      if (context.mounted) {
                                        Navigator.pop(context);
                                      }
                                    },
                                    child: Text(
                                      "Delete",
                                      style: TextStyle(
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: profileImageBytes != null
                              ? MemoryImage(profileImageBytes!)
                              : AssetImage(
                                  'assets/images/default_profile_picture.png'),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: 14, bottom: 5),
                        child: Text(
                          'Full Name',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Constants.ristekPrimaryColor,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(5.0),
                        width: MediaQuery.of(context).size.width * 0.85,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Constants.ristekPrimaryTransparent,
                            width: 1,
                          ),
                        ),
                        child: TextField(
                          controller: controllerFullName,
                          decoration: InputDecoration(
                            hintText: 'John Doe',
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(10.0),
                          ),
                          onEditingComplete: () async {
                            FocusScope.of(context).unfocus();
                            fullNameNotifier.value = controllerFullName.text;
                            await PersonalInfo.savePersonalData();
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: 14, bottom: 5),
                        child: Text(
                          'Nickname',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Constants.ristekPrimaryColor,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(5.0),
                        width: MediaQuery.of(context).size.width * 0.85,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Constants.ristekPrimaryTransparent,
                            width: 1,
                          ),
                        ),
                        child: TextField(
                          controller: controllerNickname,
                          decoration: InputDecoration(
                            hintText: 'John',
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(10.0),
                          ),
                          onEditingComplete: () async {
                            FocusScope.of(context).unfocus();
                            nicknameNotifier.value = controllerNickname.text;
                            await PersonalInfo.savePersonalData();
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: 14, bottom: 5),
                        child: Text(
                          'Hobbies',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Constants.ristekPrimaryColor,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(5.0),
                        width: MediaQuery.of(context).size.width * 0.85,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Constants.ristekPrimaryTransparent,
                            width: 1,
                          ),
                        ),
                        child: TextField(
                          controller: controllerHobbies,
                          decoration: InputDecoration(
                            hintText: 'Football, Basketball, etc.',
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(10.0),
                          ),
                          onEditingComplete: () async {
                            FocusScope.of(context).unfocus();
                            hobbiesNotifier.value = controllerHobbies.text;
                            await PersonalInfo.savePersonalData();
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: 14, bottom: 5),
                        child: Text(
                          'Social Media',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Constants.ristekPrimaryColor,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(5.0),
                        width: MediaQuery.of(context).size.width * 0.85,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Constants.ristekPrimaryTransparent,
                            width: 1,
                          ),
                        ),
                        child: TextField(
                          controller: controllerSocialMedia,
                          keyboardType: TextInputType.url,
                          decoration: InputDecoration(
                            hintText: 'https://www.instagram.com/johndoe',
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(10.0),
                            prefixIcon: GestureDetector(
                              onTap: () {
                                _launchURL(context, controllerSocialMedia.text);
                              },
                              child: Icon(Icons.link,
                                  color: Constants.ristekPrimaryColor),
                            ),
                          ),
                          onEditingComplete: () async {
                            FocusScope.of(context).unfocus();
                            socialMediaNotifier.value =
                                controllerSocialMedia.text;
                            await PersonalInfo.savePersonalData();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// Buat membuka URL
Future<void> _launchURL(BuildContext context, String url) async {
  final Uri uri = Uri.parse(url);

  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } else {
    if (!context.mounted) {
      return; // Cek apakah widget masih ada sebelum showSnackbar
    }
    _showSnackbar(context, 'Could not launch URL $url');
  }
}

// Menampilkan snackbar sebagai notifikasi
void _showSnackbar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
      duration: Duration(seconds: 2),
    ),
  );
}
