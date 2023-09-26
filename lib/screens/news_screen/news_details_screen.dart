import 'package:alex_uni_new/models/news_model.dart';
import 'package:flutter/material.dart';

class NewsDetailsScreen extends StatefulWidget {
  const NewsDetailsScreen({super.key, required this.newsModel});

  final NewsModel newsModel;

  @override
  State<NewsDetailsScreen> createState() => _NewsDetailsScreenState();
}

class _NewsDetailsScreenState extends State<NewsDetailsScreen> {

  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.newsModel.title!),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Container(
            //   padding: const EdgeInsets.all(10.0),
            //   height: MediaQuery.of(context).size.height * 0.25,
            //   child: Image.network(newsModel.headlineImage!),
            // ),
            // const SizedBox(
            //   height: 10.0,
            // ),
            // Text(newsModel.headline!, style: const TextStyle(fontSize: 20.0)),
            // const SizedBox(
            //   height: 10.0,
            // ),
            GestureDetector(
              onHorizontalDragEnd: (details) {
                if (details.velocity.pixelsPerSecond.dx > 0) {
                  if (index > 0) {
                    setState(() {
                      index--;
                    });
                  }
                } else if (details.velocity.pixelsPerSecond.dx < 0) {
                  if (index < widget.newsModel.images!.length - 1) {
                    setState(() {
                      index++;
                    });
                  }
                }
              },
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    height: MediaQuery.of(context).size.height * 0.25,
                    child: Image.network(widget.newsModel.images![index]!),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    widget.newsModel.imageDescription![index]!,
                    style: const TextStyle(fontSize: 20.0),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
