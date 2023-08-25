import 'package:alex_uni_new/cache_helper.dart';
import 'package:alex_uni_new/constants.dart';
import 'package:flutter/material.dart';
import '../main.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  static String id = 'SplashScreen';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Locale _selectedLocale;
  bool _isDropdownOpen = false;
  @override
  void initState() {
    super.initState();
    _selectedLocale = const Locale('en'); // Default language is English
  }

  void _changeLanguage(Locale? newLocale) {
    if (newLocale != null) {
      lang=newLocale.toString();
      CacheHelper.saveData(
        key: 'lang',
        value: newLocale.toString(),
      ).then((value) {
        setState(() {
          _selectedLocale = newLocale;
        });
        MyApp.setLocale(context, newLocale);
      }).catchError((e) {
        print(e.toString());
      });
    }
  }

  void _toggleDropdown() {
    setState(() {
      _isDropdownOpen = !_isDropdownOpen;
    });
  }

  void _navigateToLoginScreen(Locale selectedLocale) {
    Navigator.pushNamed(
      context,
      LoginScreen.id,
      arguments: selectedLocale,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff2D5F7B),
              Color(0xff568BAE),
              Color(0xff1B2E42),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Positioned(
                top: 20,
                right: 20,
                child: GestureDetector(
                  onTap: _toggleDropdown,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.circular(_isDropdownOpen ? 10 : 200),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: DropdownButton<Locale>(
                        value: _selectedLocale,
                        onChanged: (newLocale) {
                          _changeLanguage(newLocale);
                          _navigateToLoginScreen(
                              newLocale!); // Navigate when language changes
                        },
                        items: const [
                          DropdownMenuItem(
                            value: Locale('en'),
                            child: Text('English'),
                          ),
                          DropdownMenuItem(
                            value: Locale('ar'),
                            child: Text('Arabic'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 30),
                    const Spacer(),
                    Image.asset('assets/images/University-Logo.png'),
                    const SizedBox(
                      height: 200,
                    ),
                    const Text(
                      'Empowering Minds,\nEnriching Futures',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Belleza',
                        color: Color(0xffD1DFF3),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
