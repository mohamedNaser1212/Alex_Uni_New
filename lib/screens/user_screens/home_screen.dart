import 'package:alex_uni_new/constants.dart';
import 'package:flutter/material.dart';
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

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              lang == 'en' ? 'Faculties' : 'الكليات',
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width / 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height / 5,
            child: ListView.separated(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => buildFacultyItem(context),
              separatorBuilder: (context, index) => SizedBox(
                width: 10,
              ),
              itemCount: 10,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildFacultyItem(context,) => InkWell(
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

  Widget buildPostItem(context) => Card(
        margin: EdgeInsets.symmetric(horizontal: 8),
        elevation: 10,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
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
                        'Mars 21, 2023 at 9:00 pm',
                        style:
                            Theme.of(context).textTheme.labelMedium!.copyWith(
                                  height: 1.4,
                                ),
                      ),
                    ],
                  )),
                  SizedBox(
                    width: 20,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.more_horiz_rounded,
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
              Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse volutpat imperdiet neque, sit amet semper arcu mattis sit amet. Proin accumsan lectus vel ullamcorper luctus. Aliquam a vestibulum elit. Morbi sapien ante, facilisis nec augue non, pretium accumsan',
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                padding: EdgeInsets.only(
                  bottom: 10,
                  top: 5,
                ),
                width: double.infinity,
                child: Wrap(
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.only(
                        end: 6,
                      ),
                      child: Container(
                        height: 25,
                        child: MaterialButton(
                          onPressed: () {},
                          minWidth: 1,
                          padding: EdgeInsets.zero,
                          child: Text(
                            '#software',
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: 140,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    6,
                  ),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      'https://img.freepik.com/free-photo/stylish-korean-woman-calling-phone-talking-smartphone-looking-happy-upper-right-corner_1258-166198.jpg?w=1060&t=st=1691521908~exp=1691522508~hmac=7bb0edd5b037bcd7102d523d5f4bbd5074be8e8db3c2cc9e5c54bb87ed93d9b5',
                    ),
                  ),
                ),
                child: Image(
                  image: NetworkImage(
                    'https://img.freepik.com/free-photo/stylish-korean-woman-calling-phone-talking-smartphone-looking-happy-upper-right-corner_1258-166198.jpg?w=1060&t=st=1691521908~exp=1691522508~hmac=7bb0edd5b037bcd7102d523d5f4bbd5074be8e8db3c2cc9e5c54bb87ed93d9b5',
                  ),
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Icon(
                        Icons.favorite_outline_rounded,
                        size: 18,
                        color: Colors.red,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Text(
                        '120',
                      ),
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {},
                      child: Icon(
                        Icons.comment_outlined,
                        size: 18,
                        color: Colors.blue,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Text(
                        '120',
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.grey[350],
                height: 1,
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                      'https://img.freepik.com/free-photo/waist-up-portrait-handsome-serious-unshaven-male-keeps-hands-together-dressed-dark-blue-shirt-has-talk-with-interlocutor-stands-against-white-wall-self-confident-man-freelancer_273609-16320.jpg?w=826&t=st=1691522460~exp=1691523060~hmac=2968bc996c6aa11d26e09b088a8ecfa80e042d8194187115b928ef8401a1a774',
                    ),
                    radius: 25,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Container(
                      height: 50,
                      child: reusableTextFormField(
                        label: 'Comment',
                        onTap: () {},
                        controller: commentController,
                        keyboardType: TextInputType.text,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Icon(
                      Icons.send_outlined,
                      color: Colors.blue,
                      size: 18,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
