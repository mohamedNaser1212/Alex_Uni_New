import 'package:alex_uni_new/cubit/bloc_observer.dart';
import 'package:alex_uni_new/firebase_options.dart';
import 'package:alex_uni_new/screens/home_screen.dart';
import 'package:alex_uni_new/screens/login_screen.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:alex_uni_new/screens/splash_screen.dart';
import 'package:alex_uni_new/screens/registeration_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>()!;
    state.setLocale(newLocale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _selectedLocale = const Locale('en'); // Default language is English

  void setLocale(Locale newLocale) {
    setState(() {
      _selectedLocale = newLocale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
        LoginScreen.id: (context) => LoginScreen(),
        RegisterationScreen.id: (context) => const RegisterationScreen(),
        HomeScreen.id: (context) => const HomeScreen(),
      },
      initialRoute: SplashScreen.id,
    );
  }
}
