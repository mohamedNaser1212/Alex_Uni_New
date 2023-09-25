import 'package:alex_uni_new/models/news_model.dart';
import 'package:flutter/material.dart';

class NewsDetailsScreen extends StatelessWidget {
  const NewsDetailsScreen({super.key, required this.newsModel});

  final NewsModel newsModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(newsModel.title!),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10.0),
              height: MediaQuery.of(context).size.height * 0.25,
              child: Image.network(newsModel.headlineImage!),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text(newsModel.headline!, style: const TextStyle(fontSize: 20.0)),
            const SizedBox(
              height: 10.0,
            ),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => Container(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Text(
                      newsModel.sectionTitles![index]!,
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.25,
                      child: Image.network(
                        newsModel.images![index]!,
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      newsModel.imageDescription![index]!,
                      style: const TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      newsModel.descriptions![index]!,
                      style: const TextStyle(
                        fontSize: 18.0,
                      )
                    ),
                  ],
                ),
              ),
              separatorBuilder: (context, index) => const SizedBox(
                height: 10.0,
              ),
              itemCount: newsModel.sectionTitles!.length,
            ),
          ],
        ),
      ),
    );
  }
}
