import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/screen/get_news.dart';


class NewsDisplay extends StatelessWidget {
  final News news;

  NewsDisplay({required this.news});

  @override
  Widget build(BuildContext context) {
    final publishedDate = DateTime.parse(news.publishedAt);
    final formattedDate = DateFormat('yyyy-MM-dd').format(publishedDate);

    return Scaffold(
      appBar: AppBar(
        title: Text(news.title),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Image.network(
              news.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              news.description,
              style: const TextStyle(
                fontSize: 20.0,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              "${news.author} - $formattedDate",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}