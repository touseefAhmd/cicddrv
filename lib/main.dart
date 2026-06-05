import 'package:driver_app/utils/theme/theme_provider.dart';
import 'package:driver_app/views/screens/manifestList/manifest_data_screen.dart';
import 'package:driver_app/widgets/mediapicker/media_picker_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(
          create: (_) => ThemeProvider(),
        ),
        ChangeNotifierProvider<MediaPickerProvider>(
          create: (_) => MediaPickerProvider(),
        ),
      ],
      child: const AppRoot(),
    );
  }
}


class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: themeProvider.themeMode,
          home: const ManifestDataScreen(), // your real app start screen
        );
      },
    );
  }
}