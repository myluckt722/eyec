import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme.dart';
import 'services/theme_controller.dart';
import 'home_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeController(),
      child: EyeCareApp(),
    ),
  );
}

class EyeCareApp extends StatelessWidget {
  const EyeCareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeController>(
      builder: (context, themeController, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'EyeCare Manager',
          theme: lightTheme,
          themeMode: themeController.isDarkMode
              ? ThemeMode.dark
              : ThemeMode.light,
          home: HomePage(),
        );
      },
    );
  }
}
