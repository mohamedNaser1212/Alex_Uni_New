import 'package:alex_uni_new/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../models/news_model.dart';
import '../../reusable_widgets.dart';
import 'news_details_screen.dart';

class DrawerNewsScreen extends StatefulWidget {
  const DrawerNewsScreen({super.key});

  @override
  State<DrawerNewsScreen> createState() => _DrawerNewsScreenState();
}

class _DrawerNewsScreenState extends State<DrawerNewsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE6EEFA),
      appBar: AppBar(
        title: Text(lang == 'en' ? 'News' : 'الاخبار'),
        backgroundColor: const Color(0xffE6EEFA),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('News').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.separated(
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
                separatorBuilder: (context, index) => Divider(
                  thickness: 1,
                  color: Colors.grey[300],
                ),
                itemCount: snapshot.data!.docs.length,
              ),
            );
          } else {
            return Center(
              child: Text(lang == 'en' ? 'No Data Found' : 'لا يوجد بيانات '),
            );
          }
        },
      ),
    );
  }

  Widget buildNewsItem({
    required BuildContext context,
    required ArabicNewsModel model,
  }) =>
      InkWell(
        onTap: () {
          navigateTo(
            context: context,
            screen: NewsDetailsScreen(
              newsModel: model,
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(
                      model.images[0]!,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.title!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      model.descriptions[0]!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      model.date!,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
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