import 'package:flutter/material.dart';
import 'package:my_todo_app/data/constants.dart';
import 'package:my_todo_app/data/controllers.dart';
import 'package:my_todo_app/data/notifiers.dart';
import 'package:my_todo_app/data/personal_info.dart';
import 'package:my_todo_app/data/profile_picture_data.dart';
import 'package:my_todo_app/data/todo_database.dart';
import 'package:my_todo_app/views/pages/about_me_page.dart';
import 'package:my_todo_app/views/pages/home_page.dart';
import 'package:my_todo_app/views/widgets/navbar_widget.dart';

// Menyimpan daftar page dan namanya untuk ditampilkan di UI
List<Widget> pages = [
  HomePage(),
  AboutMePage(),
];

List<AppBar> pagesAppBar = [
  AppBar(
    backgroundColor: Colors.white,
  ),
  AppBar(
    backgroundColor: Constants.ristekPrimaryColor,
    title: Text(
      'My profile',
      style: Constants.ristekTitleStyle,
    ),
    centerTitle: true,
  ),
];

class WidgetTree extends StatefulWidget {
  const WidgetTree({
    super.key,
    this.message,
  });

  final String? message;

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {

  // Load semua data yang pernah di save di shared preferences jika ada
  @override
  void initState() {
    super.initState();
    _loadTodos();
    _loadPersonalData();
    _loadProfilePicture();

    if (widget.message != null) {
      // Jalankan setelah build selesai
      Future.microtask( // Supaya memunculkan Snackbar hanya sekali (jika dibutuhkan)
        () {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(widget.message!),
                backgroundColor: Colors.green,
                duration: Duration(seconds: 2),
              ),
            );
          }
        },
      );
    }
  }

  void _loadTodos() async {
    await TodoDatabase.loadTodos();
    setState(() {});
  }

  void _loadPersonalData() async {
    await PersonalInfo.loadPersonalData();
    setState(() {
      setState(() {
        controllerFullName.text = fullNameNotifier.value;
        controllerNickname.text = nicknameNotifier.value;
        controllerHobbies.text = hobbiesNotifier.value;
        controllerSocialMedia.text = socialMediaNotifier.value;
      });
    });
  }

  Future<void> _loadProfilePicture() async {
    final profilePicture = await ProfilePictureData.getProfilePicture();
    if (profilePicture != null) {
      setState(() {
        profileImageBytes = profilePicture;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: ValueListenableBuilder<int>(
          valueListenable: selectedPage,
          builder: (context, value, child) {
            return pagesAppBar[value];
          },
        ),
      ),
      bottomNavigationBar: NavbarWidget(),
      body: PageView(
        controller: pageController,
        onPageChanged: (value) {
          selectedPage.value = value;
        },
        children: pages,
      ),
    );
  }
}
