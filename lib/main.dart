import 'package:alex_uni_new/cache_helper.dart';
import 'package:alex_uni_new/constants.dart';
import 'package:alex_uni_new/cubit/bloc_observer.dart';
import 'package:alex_uni_new/firebase_options.dart';
import 'package:alex_uni_new/screens/home_screen.dart';
import 'package:alex_uni_new/screens/login_screen.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:alex_uni_new/screens/splash_screen.dart';
import 'package:alex_uni_new/screens/registeration_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  CacheHelper.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  String startPage;
  lang = await CacheHelper.getData(key: 'lang') ;
  uId = await CacheHelper.getData(key: 'uId');
  if(lang==null) {
    startPage=SplashScreen.id;
    if(uId!=null){
      startPage=HomeScreen.id;
    }
  } else {
    startPage=LoginScreen.id;
  }
  print(lang);
  runApp(MyApp(startPage: startPage,));
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
  Locale _selectedLocale =  Locale(lang??'en'); // Default language is English

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
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(
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
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.blue,
            elevation: 20,
          ),
          textTheme: TextTheme(
            bodyText1: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),),

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
        RegisterationScreen.id: (context) => RegisterationScreen(),
        HomeScreen.id: (context) => HomeScreen(), // Pass the email only
      },
      initialRoute: widget.startPage,
    );
  }
}
