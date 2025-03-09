import 'package:flutter/material.dart';

class Controllers {
  // Controller buat atur page NavigationBar
  static final PageController pageController = PageController();

  // Controller buat atur personal info user
  static final TextEditingController controllerFullName =
      TextEditingController();
  static final TextEditingController controllerNickname =
      TextEditingController();
  static final TextEditingController controllerHobbies =
      TextEditingController();
  static final TextEditingController controllerSocialMedia =
      TextEditingController();
}
