import 'package:alex_uni_new/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:alex_uni_new/models/news_model.dart';

class ArabicNewsDetailsScreen extends StatefulWidget {
  const ArabicNewsDetailsScreen({super.key, required this.newsModel});

  final ArabicNewsModel newsModel;

  @override
  State<ArabicNewsDetailsScreen> createState() =>
      _ArabicNewsDetailsScreenState();
}

class _ArabicNewsDetailsScreenState extends State<ArabicNewsDetailsScreen> {
  int index = 0;
  List<GlobalKey> leftIconButtonKeys = [];
  List<GlobalKey> rightIconButtonKeys = [];

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Initialize unique keys for each IconButton
    for (int i = 0; i < widget.newsModel.images.length; i++) {
      leftIconButtonKeys.add(GlobalKey());
      rightIconButtonKeys.add(GlobalKey());
    }
  }

  void goToPreviousImage() {
    if (index > 0) {
      setState(() {
        index--;
        scrollController.animateTo(
          0.0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    }
  }

  void goToNextImage() {
    if (index < widget.newsModel.images.length - 1) {
      setState(() {
        index++;
        scrollController.animateTo(
          0.0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasPreviousImage = index > 0;
    final hasNextImage = index < widget.newsModel.images.length - 1;

    return Scaffold(
      appBar: AppBar(
        title:
            //  lang=='ar'? widget.newsModel.arabicTitle!:widget.newsModel.title!,
            Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              lang == 'en' ? "Faculty of" : "كلية",
              style: TextStyle(
                fontFamily: lang == 'ar' ? 'arabic2' : 'poppins',
                color: const Color.fromARGB(255, 151, 151, 151),
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              lang == 'en' ? "Business Management" : "ادارة الاعمال",
              style: TextStyle(
                fontFamily: lang == 'ar' ? 'arabic2' : 'poppins',
                color: const Color.fromARGB(255, 31, 54, 77),
                fontSize: lang == 'ar' ? 18 : 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.332,
                    child: Stack(
                      children: [
                        Image.network(
                          widget.newsModel.images[index]!,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        if (hasPreviousImage)
                          Align(
                            alignment: Alignment.centerLeft,
                            child: InkWell(
                              key: leftIconButtonKeys[index],
                              onTap: goToPreviousImage,
                              child: Container(
                                decoration: BoxDecoration(
                                  color:
                                      const Color(0x2238455E).withOpacity(0.9),
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                child: IconButton(
                                  onPressed: goToPreviousImage,
                                  icon: const Icon(
                                    Icons.arrow_back_ios_new,
                                    color: Color(0xffFFFFFF),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        if (hasNextImage)
                          Align(
                            alignment: Alignment.centerRight,
                            child: InkWell(
                              key: rightIconButtonKeys[index],
                              onTap: goToNextImage,
                              child: Container(
                                decoration: BoxDecoration(
                                  color:
                                      const Color(0xff38455e).withOpacity(0.9),
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                child: IconButton(
                                  onPressed: goToNextImage,
                                  icon: Icon(
                                    lang == 'ar'
                                        ? Icons.arrow_back_ios
                                        : Icons.arrow_forward_ios,
                                    color: const Color(0xffFFFFFF),
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 4),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.transparent,
                          spreadRadius: 5,
                          blurRadius: 15,
                          offset: Offset(0, 3),
                        ),
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0),
                      ),
                    ),
                    height: MediaQuery.of(context).size.height * 0.55,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              widget.newsModel.title!,
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                fontFamily:
                                    lang == 'ar' ? 'arabic2' : 'poppins',
                                fontSize: 19.5,
                                fontWeight: FontWeight.w900,
                                color: defaultColor,
                              ),
                            ),
                            const SizedBox(
                              height: 7.0,
                            ),
                            Text(
                              lang == 'ar'
                                  ? widget.newsModel.date!
                                  : widget.newsModel.date!,
                              style: TextStyle(
                                fontFamily:
                                    lang == 'ar' ? 'arabic2' : 'poppins',
                                fontSize: 13.5,
                                fontWeight: FontWeight.w500,
                                color: const Color.fromARGB(255, 139, 139, 139),
                              ),
                              textDirection: TextDirection.ltr,
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 128.0, top: 8),
                              child: Divider(
                                thickness: 2,
                                color: Color.fromARGB(255, 239, 239, 239),
                              ),
                            ),
                            const SizedBox(
                              height: 4.0,
                            ),
                            Text(
                              widget.newsModel.descriptions[index]!,
                              style: TextStyle(
                                fontFamily:
                                    lang == 'ar' ? 'arabic2' : 'poppins',
                                fontSize: 16.0,
                                height: 1.5,
                                color: const Color.fromARGB(255, 63, 63, 63),
                              ),
                              textDirection: TextDirection.rtl,
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Divider(
            height: 1.0,
            color: Colors.grey,
          ),
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    '${index + 1}',
                    style: const TextStyle(
                      fontSize: 18.0,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Image.asset(
                    'assets/images/University.png',
                    width: MediaQuery.of(context).size.width * 0.08,
                  ),
                  Text(
                    '${widget.newsModel.images.length}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
