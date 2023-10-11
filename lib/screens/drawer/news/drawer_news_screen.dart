import 'package:alex_uni_new/constants/constants.dart';
import 'package:alex_uni_new/models/both_news_model.dart';
import 'package:alex_uni_new/models/news_model.dart';
import 'package:alex_uni_new/widgets/reusable_widgets.dart';
import 'package:alex_uni_new/screens/home/news/english_news_details_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class DrawerNewsScreen extends StatefulWidget {
  const DrawerNewsScreen({super.key});

  @override
  State<DrawerNewsScreen> createState() => _DrawerNewsScreenState();
}

class _DrawerNewsScreenState extends State<DrawerNewsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            IconlyBold.arrow_left_circle,
            color: defaultColor,
            size: 35,
          ),
        ),
        title: Text(
          lang == 'en' ? 'Latest News' : 'الاخبار',
          style: TextStyle(
            color: defaultColor,
          ),
        ),
        centerTitle: true,
      ),
      body: lang == 'ar'
          ? Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('News')
                      .orderBy('date', descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          DocumentSnapshot ds = snapshot.data!.docs[index];
                          ArabicNewsModel model = ArabicNewsModel.fromJson(
                              ds.data()! as Map<String, dynamic>?);

                          return buildNewsItem(
                            context: context,
                            model: model,
                          );
                        },
                        itemCount: snapshot.data!.docs.length,
                      );
                    } else {
                      return Center(
                        child: Text(
                            lang == 'en' ? 'No Data Found' : 'لا يوجد بيانات '),
                      );
                    }
                  },
                ),
              ],
            )
          : StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('News')
                  .where('type', isEqualTo: 'both')
                  .orderBy('date', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      DocumentSnapshot ds = snapshot.data!.docs[index];
                      BothNewsModel model = BothNewsModel.fromJson(
                          ds.data()! as Map<String, dynamic>?);
                      return Column(
                        children: [
                          if (index == 0)
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.03,
                            ),
                          buildNewsItem(
                            context: context,
                            model: model,
                          ),
                        ],
                      );
                    },
                    itemCount: snapshot.data!.docs.length,
                  );
                } else {
                  return Center(
                    child: Text(
                      lang == 'en' ? 'No Data Found' : 'لا يوجد بيانات',
                    ),
                  );
                }
              },
            ),
    );
  }

  Widget buildNewsItem({
    required BuildContext context,
    required model,
  }) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: () {
            navigateTo(
              context: context,
              screen: BothNewsDetailsScreen(
                newsModel: model,
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 195, 226, 252),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.134,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      image: DecorationImage(
                        image: NetworkImage(
                          model.images[0]!,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.03,
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: MediaQuery.of(context).size.height * 0.02,
                    ),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 249, 253, 255),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Column(
                      children: [
                        Text(
                          model.title!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textDirection: lang == 'en'
                              ? TextDirection.ltr
                              : TextDirection.rtl,
                          style: const TextStyle(
                            fontSize: 14.5,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: lang == 'en'
                              ? MainAxisAlignment.start
                              : MainAxisAlignment.end,
                          children: [
                            Text(
                              model.date!,
                              textDirection: lang == 'en'
                                  ? TextDirection.ltr
                                  : TextDirection.rtl,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color.fromARGB(255, 88, 88, 88),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.007,
                        ),
                        Text(
                          model.descriptions[0]!,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          textDirection: lang == 'en'
                              ? TextDirection.ltr
                              : TextDirection.rtl,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Color.fromARGB(255, 88, 88, 88),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
