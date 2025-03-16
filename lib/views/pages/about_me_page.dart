import 'dart:async';
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
  Timer? _debounce;

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
      if (context.mounted) {
        _showSnackbar(
            context, 'Profile picture saved successfully', Colors.green);
      }
    });
  }

  Future<void> loadProfilePicture() async {
    profileImageBytes = await ProfilePictureData.getProfilePicture();
    setState(() {});
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Constants.primaryColor,
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
                            color: Constants.primaryColor,
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
                            color: Constants.primaryTransparent,
                            width: 1,
                          ),
                        ),
                        child: TextField(
                          controller: Controllers.controllerFullName,
                          decoration: InputDecoration(
                            hintText: 'John Doe',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(10.0),
                          ),
                          onChanged: (value) async {
                            _debounce?.cancel();
                            _debounce = Timer(
                              Duration(milliseconds: 1000),
                              () async {
                                fullNameNotifier.value = value;
                                await PersonalInfo.savePersonalData();
                                if (context.mounted) {
                                  _showSnackbar(context,
                                      'Data saved successfully', Colors.green);
                                }
                              },
                            );
                          },
                          onEditingComplete: () async {
                            FocusScope.of(context).unfocus();
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
                            color: Constants.primaryColor,
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
                            color: Constants.primaryTransparent,
                            width: 1,
                          ),
                        ),
                        child: TextField(
                          controller: Controllers.controllerNickname,
                          decoration: InputDecoration(
                            hintText: 'John',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(10.0),
                          ),
                          onChanged: (value) async {
                            _debounce?.cancel();
                            _debounce = Timer(
                              Duration(milliseconds: 1000),
                              () async {
                                nicknameNotifier.value = value;
                                await PersonalInfo.savePersonalData();
                                if (context.mounted) {
                                  _showSnackbar(context,
                                      'Data saved successfully', Colors.green);
                                }
                              },
                            );
                          },
                          onEditingComplete: () async {
                            FocusScope.of(context).unfocus();
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
                            color: Constants.primaryColor,
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
                            color: Constants.primaryTransparent,
                            width: 1,
                          ),
                        ),
                        child: TextField(
                          controller: Controllers.controllerHobbies,
                          decoration: InputDecoration(
                            hintText: 'Football, Basketball, etc.',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(10.0),
                          ),
                          onChanged: (value) async {
                            _debounce?.cancel();
                            _debounce = Timer(
                              Duration(milliseconds: 1000),
                              () async {
                                hobbiesNotifier.value = value;
                                await PersonalInfo.savePersonalData();
                                if (context.mounted) {
                                  _showSnackbar(context,
                                      'Data saved successfully', Colors.green);
                                }
                              },
                            );
                          },
                          onEditingComplete: () async {
                            FocusScope.of(context).unfocus();
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
                            color: Constants.primaryColor,
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
                            color: Constants.primaryTransparent,
                            width: 1,
                          ),
                        ),
                        child: TextField(
                          controller: Controllers.controllerSocialMedia,
                          keyboardType: TextInputType.url,
                          decoration: InputDecoration(
                            hintText: 'https://www.instagram.com/johndoe',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(10.0),
                            prefixIcon: GestureDetector(
                              onTap: () {
                                _launchURL(context,
                                    Controllers.controllerSocialMedia.text);
                              },
                              child: Icon(Icons.link,
                                  color: Constants.primaryColor),
                            ),
                          ),
                          onChanged: (value) async {
                            _debounce?.cancel();
                            _debounce = Timer(
                              Duration(milliseconds: 1000),
                              () async {
                                socialMediaNotifier.value = value;
                                await PersonalInfo.savePersonalData();
                                if (context.mounted) {
                                  _showSnackbar(context,
                                      'Data saved successfully', Colors.green);
                                }
                              },
                            );
                          },
                          onEditingComplete: () async {
                            FocusScope.of(context).unfocus();
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
    _showSnackbar(context, 'Could not launch URL $url', Colors.red);
  }
}

// Menampilkan snackbar sebagai notifikasi
void _showSnackbar(BuildContext context, String message, Color color) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: color,
      duration: Duration(seconds: 2),
    ),
  );
}
