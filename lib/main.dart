import 'package:flutter/material.dart';
import 'package:hadi_bulsana/common/constants/text_strings.dart';
import 'package:hadi_bulsana/core/utils/routing/route_constant.dart';
import 'package:hadi_bulsana/core/utils/routing/route_generator.dart';
import 'package:hadi_bulsana/core/utils/themes/app_theme.dart';
import 'package:hadi_bulsana/ui/views/onboard/onboard.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (_) =>
          ThemeProvider(), // ThemeProvider kullanarak global state yönetimi
      builder: (context, _) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        return MaterialApp(
          title: TTexts.appName,
          debugShowCheckedModeBanner: false,
          themeMode: themeProvider.themeMode, // Buradan themeMode değerini al
          theme: TAppTheme.lightTheme,
          darkTheme: TAppTheme.darkTheme,
          initialRoute: RouteConstant.onBoardScreenRoute,
          onGenerateRoute: RouterGenerator.generateRoute,
          home: const OnboardScreen(),
        );
      },
    );
  }
}

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  void toggleTheme() {
    _themeMode =
        _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners(); // Değişiklikleri dinleyenleri bilgilendir
  }
}
