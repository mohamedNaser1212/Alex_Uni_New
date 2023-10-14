import 'package:alex_uni_new/constants/constants.dart';
import 'package:alex_uni_new/cubit/app_cubit.dart';
import 'package:alex_uni_new/screens/home/news/arabic_news_details_screen.dart';
import 'package:alex_uni_new/states/app_states.dart';
import 'package:alex_uni_new/widgets/reusable_widgets.dart';
import 'package:alex_uni_new/screens/home/news/english_news_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';

class DrawerNewsScreen extends StatefulWidget {
  const DrawerNewsScreen({super.key});

  @override
  State<DrawerNewsScreen> createState() => _DrawerNewsScreenState();
}

class _DrawerNewsScreenState extends State<DrawerNewsScreen> {
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    if (lang == 'en') {
      AppCubit.get(context).getEnglishNews();
    } else {
      AppCubit.get(context).getArabicNews();
    }
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (lang == 'en' && !AppCubit.get(context).isLastNews) {
          AppCubit.get(context).getEnglishNewsFromLast();
        } if(lang == 'ar' && !AppCubit.get(context).isLastNews) {
          AppCubit.get(context).getArabicNewsFromLast();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);

        return WillPopScope(
          onWillPop: () async {
            AppCubit.get(context).removeNews();
            Navigator.pop(context);
            return true;
          },
          child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  lang == 'en'
                      ? IconlyBold.arrow_left_circle
                      : IconlyBold.arrow_right_circle,
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
            body: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  lang == 'ar'
                      ? ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return buildNewsItem(
                              context: context,
                              model: cubit.news[index],
                            );
                          },
                          itemCount: cubit.news.length,
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                if (index == 0)
                                  SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height * 0.03,
                                  ),
                                buildNewsItem(
                                  context: context,
                                  model: cubit.bothNews[index],
                                ),
                              ],
                            );
                          },
                          itemCount: cubit.bothNews.length,
                        ),
                ],
              ),
            ),
          ),
        );
      },
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
              screen: lang == "en"
                  ? BothNewsDetailsScreen(
                      newsModel: model,
                    )
                  : ArabicNewsDetailsScreen(
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
                          mainAxisAlignment: MainAxisAlignment.start,
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
