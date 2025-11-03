class SettingsModel {
  int eyeReminderMinutes;
  int maxScreenTimeHours;
  bool debugMode;
  bool allowEssentialApps;
  bool darkMode;

  SettingsModel({
    required this.eyeReminderMinutes,
    required this.maxScreenTimeHours,
    required this.debugMode,
    required this.allowEssentialApps,
    required this.darkMode,
  });

  Map<String, dynamic> toMap() => {
        'eyeReminderMinutes': eyeReminderMinutes,
        'maxScreenTimeHours': maxScreenTimeHours,
        'debugMode': debugMode,
        'allowEssentialApps': allowEssentialApps,
        'darkMode': darkMode,
      };

  factory SettingsModel.fromMap(Map<String, dynamic> map) => SettingsModel(
        eyeReminderMinutes: map['eyeReminderMinutes'] ?? 20,
        maxScreenTimeHours: map['maxScreenTimeHours'] ?? 3,
        debugMode: map['debugMode'] ?? false,
        allowEssentialApps: map['allowEssentialApps'] ?? true,
        darkMode: map['darkMode'] ?? false,
      );
}
