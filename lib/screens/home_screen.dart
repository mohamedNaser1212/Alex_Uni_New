import 'package:flutter/material.dart';

import '../constants.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key, this.email}) : super(key: key);
  static const String id = 'home_screen';
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final String? email;

  @override
  Widget build(BuildContext context) {
    final selectedLocale = Locale(lang ?? 'en'); // Provide a default value for lang
    bool isArabic = lang == 'ar';
    TextDirection textDirection =
    isArabic ? TextDirection.rtl : TextDirection.ltr;
    // drawerHeader = UserAccountsDrawerHeader(
    //   accountName: const Text(''),
    //   accountEmail: Text(email, style: const TextStyle(
    //     color: Colors.black,
    //     fontSize: 20,
    //     fontWeight: FontWeight.bold,
    //   ),
    //   ), // Use the passed email here
    //   currentAccountPicture: const CircleAvatar(
    //     backgroundColor: Colors.white,
    //     child: Icon(Icons.image, size: 50,),
    //   ),
    //
    // );

    final drawerItems = ListView(
      children: <Widget>[
        // drawerHeader,
        const SizedBox(
          height: 20,
        ),
        SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [

                  const Icon(Icons.message, size: 40,),
                  const SizedBox(width: 10,),
                  Text(isArabic ? 'صفحتي الشخصيه' : 'My profile',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20, fontWeight: FontWeight.bold,

                    ),),
                  const Spacer(),
                  // Added Spacer to push the arrow icon to the end
                  const Icon(Icons.arrow_forward_ios, size: 30, weight: 40,),

                ],
              ),
            ],
          ),
        ),
        const Divider(
          color: Colors.black,
          thickness: 1,
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            const Icon(Icons.account_circle, size: 40,),
            const SizedBox(width: 10,),
            Text(isArabic ? 'الرسائل' : 'Messages', style: const TextStyle(
              color: Colors.black,
              fontSize: 20, fontWeight: FontWeight.bold,

            ),),
            const Spacer(), // Added Spacer to push the arrow icon to the end
            const Icon(Icons.arrow_forward_ios, size: 30, weight: 40,),

          ],
        ),
        const Divider(
          color: Colors.black,
          thickness: 1,
        ), const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            const Icon(Icons.favorite_outlined, size: 40,),
            const SizedBox(width: 10,),
            Text(isArabic ? 'المفضله' : 'Favourite', style: const TextStyle(
              color: Colors.black,
              fontSize: 20, fontWeight: FontWeight.bold,

            ),),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios, size: 30, weight: 40,),

          ],
        ),
        Divider(
          color: Colors.black,
          thickness: 1,
        ), const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            const Icon(Icons.newspaper_sharp, size:40,),
            const SizedBox(width: 10,),
            Text(
              isArabic ? 'اخر الاخبار ' : 'Recent News', style: const TextStyle(
              color: Colors.black,
              fontSize: 20, fontWeight: FontWeight.bold,

            ),),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios, size: 20, weight: 40,),

          ],
        ),
        const Divider(
          color: Colors.black,
          thickness: 1,
        ), const SizedBox(
          height: 20,
        ), Row(
          children: [
            const Icon(Icons.settings, size: 50,),
            const SizedBox(width: 10,),
            Text(isArabic ? 'الاعدادات' : 'Settings', style: const TextStyle(
              color: Colors.black,
              fontSize: 20, fontWeight: FontWeight.bold,

            ),),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios, size: 20, weight: 40,),

          ],
        ),
        Divider(
          color: Colors.black,
          thickness: 1,
        ), const SizedBox(
          height: 20,
        ), Row(
          children: [
            const Icon(Icons.help_center, size: 50,),
            const SizedBox(width: 10,),
            Text(
              isArabic ? 'مساعده & حول' : 'Help & FAQs', style: const TextStyle(
              color: Colors.black,
              fontSize: 20, fontWeight: FontWeight.bold,

            ),),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios, size: 20, weight: 40,),

          ],
        ),
        const Divider(
          color: Colors.black,
          thickness: 1,
        ), const SizedBox(
          height: 20,
        ),
      ],
    );

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          color: Colors.black,
          onPressed: () {
            scaffoldKey.currentState!.openDrawer();
          },
        ),
        backgroundColor: Colors.white,
        title: const Text('Drawer example'),
      ),
      body:Column(
        children: [


        ],
      ),
      drawer: Drawer(
        child: drawerItems,
      ),
    );
  }
}
