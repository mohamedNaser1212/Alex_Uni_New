import 'package:alex_uni_new/cache_helper.dart';
import 'package:alex_uni_new/constants.dart';
import 'package:alex_uni_new/cubit/bloc_observer.dart';
import 'package:alex_uni_new/firebase_options.dart';
import 'package:alex_uni_new/screens/home_screen.dart';
import 'package:alex_uni_new/screens/image_gallary_page.dart';
import 'package:alex_uni_new/screens/login_screen.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:alex_uni_new/screens/splash_screen.dart';
import 'package:alex_uni_new/screens/registeration_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  CacheHelper.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  bool isAuthenticated = await checkAuthentication();

  String startPage = isAuthenticated ? HomeScreen.id : SplashScreen.id;

  runApp(MyApp(startPage: startPage));
}


Future<bool> checkAuthentication() async {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user = auth.currentUser;

  if (user != null) {
    // User is authenticated
    return true;
  } else {
    // User is not authenticated
    return false;
  }
}


Future<bool> checkProfileImageStatus() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool('hasSetProfileImage') ?? false;
}


class MyApp extends StatefulWidget {
  MyApp({
    Key? key,
    required this.startPage,
  }) : super(key: key);

  String startPage;

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>()!;
    state.setLocale(newLocale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _selectedLocale = Locale(lang ?? 'en'); // Default language is English

  void setLocale(Locale newLocale) {
    setState(() {
      _selectedLocale = newLocale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Your theme configuration...
        // ...
      ),
      locale: _selectedLocale,
      supportedLocales: const [
        Locale('en', ''), // English
        Locale('ar', ''), // Arabic
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      routes: {
        SplashScreen.id: (context) => const SplashScreen(),
        LoginScreen.id: (context) => const LoginScreen(),
        RegisterationScreen.id: (context) => const RegisterationScreen(),
        HomeScreen.id: (context) => HomeScreen(),
        GalleryPage.id: (context) => const GalleryPage(),

      },
      initialRoute: widget.startPage,
    );
  }
}