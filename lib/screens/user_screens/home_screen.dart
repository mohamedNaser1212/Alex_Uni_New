import 'package:alex_uni_new/constants.dart';
import 'package:flutter/material.dart';
import 'package:sliver_tools/sliver_tools.dart';
import '../../reusable_widgets.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // bool isArabic = lang == 'ar';
    // TextDirection textDirection =
    // isArabic ? TextDirection.rtl : TextDirection.ltr;

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

    // final drawerItems = ListView(
    //   children: <Widget>[
    //     // drawerHeader,
    //     const SizedBox(
    //       height: 20,
    //     ),
    //     SingleChildScrollView(
    //       child: Column(
    //         children: [
    //           Row(
    //             children: [
    //
    //               const Icon(Icons.message, size: 40,),
    //               const SizedBox(width: 10,),
    //               Text(isArabic ? 'صفحتي الشخصيه' : 'My profile',
    //                 style: const TextStyle(
    //                   color: Colors.black,
    //                   fontSize: 20, fontWeight: FontWeight.bold,
    //
    //                 ),),
    //               const Spacer(),
    //               // Added Spacer to push the arrow icon to the end
    //               const Icon(Icons.arrow_forward_ios, size: 30, weight: 40,),
    //
    //             ],
    //           ),
    //         ],
    //       ),
    //     ),
    //     const Divider(
    //       color: Colors.black,
    //       thickness: 1,
    //     ),
    //     const SizedBox(
    //       height: 20,
    //     ),
    //     Row(
    //       children: [
    //         const Icon(Icons.account_circle, size: 40,),
    //         const SizedBox(width: 10,),
    //         Text(isArabic ? 'الرسائل' : 'Messages', style: const TextStyle(
    //           color: Colors.black,
    //           fontSize: 20, fontWeight: FontWeight.bold,
    //
    //         ),),
    //         const Spacer(), // Added Spacer to push the arrow icon to the end
    //         const Icon(Icons.arrow_forward_ios, size: 30, weight: 40,),
    //
    //       ],
    //     ),
    //     const Divider(
    //       color: Colors.black,
    //       thickness: 1,
    //     ), const SizedBox(
    //       height: 20,
    //     ),
    //     Row(
    //       children: [
    //         const Icon(Icons.favorite_outlined, size: 40,),
    //         const SizedBox(width: 10,),
    //         Text(isArabic ? 'المفضله' : 'Favourite', style: const TextStyle(
    //           color: Colors.black,
    //           fontSize: 20, fontWeight: FontWeight.bold,
    //
    //         ),),
    //         const Spacer(),
    //         const Icon(Icons.arrow_forward_ios, size: 30, weight: 40,),
    //
    //       ],
    //     ),
    //     Divider(
    //       color: Colors.black,
    //       thickness: 1,
    //     ), const SizedBox(
    //       height: 20,
    //     ),
    //     Row(
    //       children: [
    //         const Icon(Icons.newspaper_sharp, size:40,),
    //         const SizedBox(width: 10,),
    //         Text(
    //           isArabic ? 'اخر الاخبار ' : 'Recent News', style: const TextStyle(
    //           color: Colors.black,
    //           fontSize: 20, fontWeight: FontWeight.bold,
    //
    //         ),),
    //         const Spacer(),
    //         const Icon(Icons.arrow_forward_ios, size: 20, weight: 40,),
    //
    //       ],
    //     ),
    //     const Divider(
    //       color: Colors.black,
    //       thickness: 1,
    //     ), const SizedBox(
    //       height: 20,
    //     ), Row(
    //       children: [
    //         const Icon(Icons.settings, size: 50,),
    //         const SizedBox(width: 10,),
    //         Text(isArabic ? 'الاعدادات' : 'Settings', style: const TextStyle(
    //           color: Colors.black,
    //           fontSize: 20, fontWeight: FontWeight.bold,
    //
    //         ),),
    //         const Spacer(),
    //         const Icon(Icons.arrow_forward_ios, size: 20, weight: 40,),
    //
    //       ],
    //     ),
    //     Divider(
    //       color: Colors.black,
    //       thickness: 1,
    //     ), const SizedBox(
    //       height: 20,
    //     ), Row(
    //       children: [
    //         const Icon(Icons.help_center, size: 50,),
    //         const SizedBox(width: 10,),
    //         Text(
    //           isArabic ? 'مساعده & حول' : 'Help & FAQs', style: const TextStyle(
    //           color: Colors.black,
    //           fontSize: 20, fontWeight: FontWeight.bold,
    //
    //         ),),
    //         const Spacer(),
    //         const Icon(Icons.arrow_forward_ios, size: 20, weight: 40,),
    //
    //       ],
    //     ),
    //     const Divider(
    //       color: Colors.black,
    //       thickness: 1,
    //     ), const SizedBox(
    //       height: 20,
    //     ),
    //   ],
    // );

    return SingleChildScrollView(
      child: Column(

        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              lang == 'en' ? 'Faculties' : 'الكليات',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                fontFamily: 'Inter',

              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => buildFacultyItem(context),
              separatorBuilder: (context, index) => const SizedBox(
                width: 10,
              ),
              itemCount: 10,
            ),
          ),
          const  SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              lang == 'en' ? 'News' : 'الاخبار',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                fontFamily: 'Inter',
              ),
            ),
          ),
          const    SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.34,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => buidNewsItem(context),
                separatorBuilder: (context, index) =>const SizedBox(
                  width: 15,
                ),
                itemCount: 10,
              ),
            ),
          ),
          const  SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              lang == 'en' ? 'Posts' : 'المنشورات',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                fontFamily: 'Inter',
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
            Container(
              decoration: BoxDecoration(

                borderRadius: BorderRadius.circular(
                  90,
                ),
              ),
            child: ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) => buildPostItem(context),
              separatorBuilder: (context, index) => const SizedBox(
                height: 20,
              ),
              itemCount: 10,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildFacultyItem(context) => InkWell(
    onTap: () {},
    child: Column(
      children: [
        CircleAvatar(
          backgroundColor: Colors.grey[300],
          radius: MediaQuery.of(context).size.width / 7.7,
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: MediaQuery.of(context).size.width / 8,
            child: Image.asset(
              'assets/images/college.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          lang == 'en' ? 'Science' : ' العلوم',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width / 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );

  Widget buidNewsItem(context)=>Container(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: const Color(0xffE6EEFA),
      borderRadius: BorderRadius.circular(
        16,
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.7,
          height: MediaQuery.of(context).size.height * 0.2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              25,
            ),
            image:const DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                'https://img.freepik.com/free-photo/stylish-korean-woman-calling-phone-talking-smartphone-looking-happy-upper-right-corner_1258-166198.jpg?w=1060&t=st=1691521908~exp=1691522508~hmac=7bb0edd5b037bcd7102d523d5f4bbd5074be8e8db3c2cc9e5c54bb87ed93d9b5',
              ),
            ),
          ),
          child:Container(

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                80,
              ),
              color: Colors.black.withOpacity(0.6),
            ),
            child: const Image(
              image: NetworkImage(
                'https://img.freepik.com/free-photo/stylish-korean-woman-calling-phone-talking-smartphone-looking-happy-upper-right-corner_1258-166198.jpg?w=1060&t=st=1691521908~exp=1691522508~hmac=7bb0edd5b037bcd7102d523d5f4bbd5074be8e8db3c2cc9e5c54bb87ed93d9b5',
              ),
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const   Text(
          'Just Now',
          style: TextStyle(
            color: Color(0xff7C7A7A),
          ),
        ),
        const  SizedBox(
          height: 3,
        ),
        const  Text(
          'Title',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'Inter',
          ),
        ),
        const  SizedBox(
          height: 5,
        ),
         SizedBox(
          width: MediaQuery.of(context).size.width * 0.7,
          child:const Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse volutpat imperdiet neque, sit amet semper arcu mattis sit amet. Proin accumsan lectus vel ullamcorper luctus. Aliquam a vestibulum elit. Morbi sapien ante, facilisis nec augue non, pretium accumsan',
            maxLines: 2,
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              fontFamily: 'Inter',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    ),
  );Widget buildPostItem(context) => Card(
    margin: const EdgeInsets.symmetric(horizontal: 14),
    color: const Color(0xffE6EEFA),
    elevation: 8,
    clipBehavior: Clip.none,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                  'https://img.freepik.com/free-photo/waist-up-portrait-handsome-serious-unshaven-male-keeps-hands-together-dressed-dark-blue-shirt-has-talk-with-interlocutor-stands-against-white-wall-self-confident-man-freelancer_273609-16320.jpg?w=826&t=st=1691522460~exp=1691523060~hmac=2968bc996c6aa11d26e09b088a8ecfa80e042d8194187115b928ef8401a1a774',
                ),
                radius: 25,
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Hazem Hamdy',
                          style: TextStyle(
                            height: 1.4,
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w900,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.verified,
                          size: 16,
                          color: Colors.blue,
                        ),
                      ],
                    ),
                    Text(
                      '@hazemhamdy',
                      style: TextStyle(
                        height: 1.4,
                        color: Color(0xff6C7A9C),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                '2h',
                style: TextStyle(
                  height: 1.4,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Divider(
              color: Colors.grey[350],
              height: 1,
            ),
          ),
          const Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse volutpat imperdiet neque, sit amet semper arcu mattis sit amet. Proin accumsan lectus vel ullamcorper luctus. Aliquam a vestibulum elit. Morbi sapien ante, facilisis nec augue non, pretium accumsan',
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(46),
                    image: const DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        'https://img.freepik.com/free-photo/stylish-korean-woman-calling-phone-talking-smartphone-looking-happy-upper-right-corner_1258-166198.jpg?w=1060&t=st=1691521908~exp=1691522508~hmac=7bb0edd5b037bcd7102d523d5f4bbd5074be8e8db3c2cc9e5c54bb87ed93d9b5',
                      ),
                    ),
                  ),
                  child: const Image(
                    image: NetworkImage(
                      'https://img.freepik.com/free-photo/stylish-korean-woman-calling-phone-talking-smartphone-looking-happy-upper-right-corner_1258-166198.jpg?w=1060&t=st=1691521908~exp=1691522508~hmac=7bb0edd5b037bcd7102d523d5f4bbd5074be8e8db3c2cc9e5c54bb87ed93d9b5',
                    ),
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  width: double.infinity,
                  color: Colors.black.withOpacity(0.6),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {},
                          child: const Icon(
                            Icons.favorite_outline_rounded,
                            size: 18,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 5),
                        InkWell(
                          onTap: () {},
                          child: const Text(
                            '120',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        InkWell(
                          onTap: () {},
                          child: const Icon(
                            Icons.comment_outlined,
                            size: 18,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 5),
                        InkWell(
                          onTap: () {},
                          child: const Text(
                            '120',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () {},
                          child: const Icon(
                            Icons.share_outlined,
                            size: 18,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 20),
                        InkWell(
                          onTap: () {},
                          child: const Icon(
                            Icons.bookmark_border_outlined,
                            size: 18,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}