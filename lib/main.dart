import 'package:alex_uni_new/cache_helper.dart';
import 'package:alex_uni_new/constants.dart';
import 'package:alex_uni_new/cubit/bloc_observer.dart';
import 'package:alex_uni_new/firebase_options.dart';
import 'package:alex_uni_new/screens/login_screen.dart';
import 'package:alex_uni_new/screens/user_layout_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:alex_uni_new/screens/splash_screen.dart';

import 'cubit/app_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  uId = await CacheHelper.getData(key: 'uId');
  lang = await CacheHelper.getData(key: 'lang');
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Widget startPage;
  if (lang == null) {
    startPage = const SplashScreen();
  } else {
    if (uId == null) {
      startPage = const LoginScreen();
    } else {
      startPage = const UserLayout();
    }
  }
  runApp(MyApp(
    startPage: startPage,
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({
    Key? key,
    required this.startPage,
  }) : super(key: key);

  final Widget startPage;

  static void setLocale(BuildContext context, Locale newLocale) {
    final _MyAppState state = context.findAncestorStateOfType<_MyAppState>()!;
    state.setLocale(newLocale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Locale _selectedLocale;

  _MyAppState() {
    _selectedLocale = Locale(lang ?? 'en');
  }

  void setLocale(Locale newLocale) {
    setState(() {
      _selectedLocale = newLocale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => AppCubit()
            ..getUserData()
            ..getMyPosts()
            ..getSettings()
          ..getSavePosts(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              statusBarIconBrightness: Brightness.dark,
            ),
            backgroundColor: Colors.white,
            elevation: 2,
            titleTextStyle: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
          ),
        ),
        locale: _selectedLocale,
        supportedLocales: const [
          Locale('en', ''),
          Locale('ar', ''),
        ],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        routes: {
          SplashScreen.id: (context) => const SplashScreen(),
          LoginScreen.id: (context) => const LoginScreen(),
          UserLayout.id: (context) => const UserLayout(),
          // ... define other named routes if needed ...
        },
        home: widget.startPage,
      ),
    );
  }
}
