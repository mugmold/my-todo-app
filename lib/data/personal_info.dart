import 'package:my_todo_app/data/notifiers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersonalInfo {
  static Future<void> savePersonalData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('fullName', fullNameNotifier.value);
    await prefs.setString('nickname', nicknameNotifier.value);
    await prefs.setString('hobbies', hobbiesNotifier.value);
    await prefs.setString('socialMedia', socialMediaNotifier.value);
  }

  static Future<void> loadPersonalData() async {
    final prefs = await SharedPreferences.getInstance();
    fullNameNotifier.value = prefs.getString('fullName') ?? '';
    nicknameNotifier.value = prefs.getString('nickname') ?? '';
    hobbiesNotifier.value = prefs.getString('hobbies') ?? '';
    socialMediaNotifier.value = prefs.getString('socialMedia') ?? '';
  }
}
