import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:metronews_app/bindings/app_binding.dart';
import 'package:metronews_app/routes/app_pages.dart';
import 'package:metronews_app/utils/app_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // load environment variables first before the app
  await dotenv.load(fileName: '.env');

  runApp(MetroNewsApp());
}

class MetroNewsApp extends StatelessWidget {
  const MetroNewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'MetroNewsApp',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.background,
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white
          )
        )
      ),
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      initialBinding: AppBinding(),
      debugShowCheckedModeBanner: false,
    );
  }
}


// async* = untuk memanggil