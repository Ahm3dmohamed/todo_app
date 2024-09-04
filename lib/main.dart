import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/firebase_options.dart';
import 'package:todo_app/modules/core/model/auth/pages/create_acount_screen.dart';
import 'package:todo_app/modules/core/model/auth/pages/login_screen.dart';
import 'package:todo_app/modules/core/themes/apptheme.dart';
import 'package:todo_app/modules/layouts/manager/provider/local_provider.dart';
import 'package:todo_app/modules/layouts/manager/provider/provider.dart';
import 'package:todo_app/modules/layouts/manager/provider/theme_provider.dart';
import 'package:todo_app/modules/layouts/screens/layout_screen.dart';
import 'package:todo_app/modules/layouts/screens/splash_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_app/modules/layouts/screens/settings/settings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    print("Firebase initialization error: $e");
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => LocaleProvider()),
        ChangeNotifierProvider(
            create: (context) => MainProvider()), // Add this line
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = ThemeProvider.get(context);
    LocaleProvider localeProvider = LocaleProvider.get(context);

    return MaterialApp(
      theme: Apptheme.lightTheme,
      themeMode: themeProvider.currentTheme,
      darkTheme: Apptheme.darkTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.routeName,
      routes: {
        LayoutScreen.routeName: (context) => const LayoutScreen(),
        SplashScreen.routeName: (context) => SplashScreen(),
        Settings.routeName: (context) => const Settings(),
        LoginScreen.routeName: (context) => const LoginScreen(),
        CreateAcountScreen.routeName: (context) => CreateAcountScreen(),
      },
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(localeProvider.currentLocale),
    );
  }
}
// Drop DownTwon to change bettween mode and language 