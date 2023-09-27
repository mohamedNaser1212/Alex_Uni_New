import 'package:flutter/material.dart';
import 'package:alex_uni_new/models/news_model.dart';

class NewsDetailsScreen extends StatefulWidget {
  const NewsDetailsScreen({super.key, required this.newsModel});

  final NewsModel newsModel;

  @override
  State<NewsDetailsScreen> createState() => _NewsDetailsScreenState();
}

class _NewsDetailsScreenState extends State<NewsDetailsScreen> {
  int index = 0;
  List<GlobalKey> leftIconButtonKeys = [];
  List<GlobalKey> rightIconButtonKeys = [];

  @override
  void initState() {
    super.initState();

    // Initialize unique keys for each IconButton
    for (int i = 0; i < widget.newsModel.images!.length; i++) {
      leftIconButtonKeys.add(GlobalKey());
      rightIconButtonKeys.add(GlobalKey());
    }
  }

  void goToPreviousImage() {
    if (index > 0) {
      setState(() {
        index--;
      });
    }
  }

  void goToNextImage() {
    if (index < widget.newsModel.images!.length - 1) {
      setState(() {
        index++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasPreviousImage = index > 0;
    final hasNextImage = index < widget.newsModel.images!.length - 1;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.newsModel.title!),
        centerTitle: true,
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
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: Stack(
                      children: [
                        Image.network(
                          widget.newsModel.images[index]!,
                          width: double.infinity,
                        ),
                        if (hasPreviousImage)
                          Align(
                            alignment: Alignment.centerLeft,
                            child: InkWell(
                              key: leftIconButtonKeys[index],
                              onTap: goToPreviousImage,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xff2238455E).withOpacity(0.9),
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                child: IconButton(
                                  onPressed: goToPreviousImage,
                                  icon: Icon(
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
                                  color: Color(0xff2238455E).withOpacity(0.9),
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                child: IconButton(
                                  onPressed: goToNextImage,
                                  icon: Icon(
                                    Icons.arrow_forward_ios,
                                    color: Color(0xffFFFFFF),
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
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 15,
                          offset: const Offset(0, 3),
                        ),
                      ],
                      color: Colors.white,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0),
                      ),
                    ),
                    height: MediaQuery.of(context).size.height * 0.65,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            widget.newsModel.imageDescription[index]!,
                            style: const TextStyle(
                              fontSize: 20.0,
                            ),
                            textAlign: TextAlign.start,
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
