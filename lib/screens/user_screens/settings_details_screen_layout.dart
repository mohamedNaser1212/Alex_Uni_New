import 'package:alex_uni_new/constants.dart';
import 'package:alex_uni_new/reusable_widgets.dart';
import 'package:alex_uni_new/screens/splash_screen.dart';
import 'package:alex_uni_new/screens/user_layout_screen.dart';
import 'package:alex_uni_new/screens/user_screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cache_helper.dart';
import '../../cubit/app_cubit.dart';
import '../../main.dart';
import '../../states/app_states.dart';

class SettingsLayoutScreen extends StatefulWidget {
  // Add a parameter to receive the current locale and toggle function


  const SettingsLayoutScreen({
    Key? key,

  }) : super(key: key);

  @override
  State<SettingsLayoutScreen> createState() => _SettingsLayoutScreenState();
}

class _SettingsLayoutScreenState extends State<SettingsLayoutScreen> {
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
      UserLayout.id,
      arguments: selectedLocale,
    );
  }
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AppCubit, AppStates>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
  var cubit = AppCubit.get(context);

  return Scaffold(
    backgroundColor: Color(0xff3E657B),
      appBar: AppBar(
        title:  Text(
            lang == 'en' ? 'settings' :'الاعدادات'
        ),
      ),
      body: Stack(
        children: [
          Center(
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [

                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image.asset('assets/images/University.png'),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    const SizedBox(
                      height: 50,
                    ),
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.7,
                      padding: const EdgeInsets.all(20),
                      decoration: const BoxDecoration(
                        color: Color(0xffD9D9D9),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50),
                        ),
                      ),
                      child:  SingleChildScrollView(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 30),
                        Row(
                          children: [
                             Text(
                              lang == 'en' ? 'Language' : 'اللغه',
                              style:const TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff0D3961),
                              ),
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: _toggleDropdown,
                              child: AnimatedContainer(

                                duration: const Duration(milliseconds: 500),
                                decoration: BoxDecoration(
                                  color: Colors.grey,
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
                                     newLocale=_selectedLocale
                                      );
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

                          ],
                        ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Divider(
                                thickness: 1,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [

                                  Text(
                                      lang == 'en' ? 'Delete Account' : 'حذف الحساب',
                                    style:const TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xff0D3961),
                                    ),
                                  ),
                                  Spacer(),
                                  InkWell(
                                    onTap: () {
                                      AppCubit.get(context).deleteUser(
                                        context: context,
                                        id: uId!,
                                      );
                                    },
                                    child: const Icon(
                                      Icons.delete,
                                      size: 26,
                                    ),
                                  ),
                                  ]),


                              const SizedBox(
                                height: 20,
                              ),
                              const Divider(
                                thickness: 1,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Center(
                                child: Container(
                                 decoration:  BoxDecoration(
                                   color: Colors.black12.withOpacity(0.6),
                                   borderRadius: BorderRadius.all(Radius.circular(20),),),

                                  child: TextButton(
                                    onPressed: () {
                                      cubit.logout(context);

                                    },
                                    child: Text(lang=='en'?'Logout':'تسجيل الخروج',
                                      style:const TextStyle(
                                        fontSize: 26,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),


                                  ),
                                )
                              ),
                        ],

              ),
            ),
          ),
        ],
      ),
    ),
    ),
    )
    ]),
    );
  },
);
  }
}

