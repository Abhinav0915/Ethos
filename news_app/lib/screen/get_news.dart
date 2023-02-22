import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/util/appbar.dart';
import 'package:news_app/constants/AppColors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:news_app/screen/news_display.dart';
import 'package:news_app/screen/homepage.dart';

class News {
  final String title;
  final String author;
  final String description;
  final String url;
  final String imageUrl;
  final String publishedAt;

  News({
    required this.title,
    required this.author,
    required this.description,
    required this.url,
    required this.imageUrl,
    required this.publishedAt,
  });
}

Future<List<News>> getNews() async {
  String url =
      "https://newsapi.org/v2/top-headlines?country=us&apiKey=ba679dbdd4974c9492be054f2fd885c1";
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final List<News> newsList = [];

    final Map<String, dynamic> responseData = json.decode(response.body);

    for (final article in responseData["articles"]) {
      final News news = News(
        title: article["title"],
        author: article["author"] ?? "Unknown",
        description: article["description"],
        url: article["url"],
        imageUrl: article["urlToImage"] ?? "",
        publishedAt: article["publishedAt"] ?? "",
      );

      newsList.add(news);
    }

    return newsList;
  } else {
    throw Exception("Failed to load news");
  }
}
