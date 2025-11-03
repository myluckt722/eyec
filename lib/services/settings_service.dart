import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/settings_model.dart';

class SettingsService {
  static const _key = 'eyec_settings';

  Future<void> save(SettingsModel model) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, jsonEncode(model.toMap()));
  }

  Future<SettingsModel> load() async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString(_key);
    if (json == null) {
      return SettingsModel(
        eyeReminderMinutes: 20,
        maxScreenTimeHours: 3,
        debugMode: false,
        allowEssentialApps: true,
        darkMode: false,
      );
    }
    return SettingsModel.fromMap(jsonDecode(json));
  }
}
