import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/util/appbar.dart';
import 'package:news_app/constants/AppColors.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  late List<News> _newsList = [];

  @override
  void initState() {
    super.initState();

    getNews().then((newsList) {
      setState(() {
        _newsList = newsList;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar.getAppBar("HEADLINES"),
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Column(
          children: _newsList.map((news) {
            final publishedDate = DateTime.parse(news.publishedAt);
            final formattedDate =
                DateFormat('yyyy-MM-dd').format(publishedDate);

            return Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
              child: Card(
                elevation: 25,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Stack(
                  children: [
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(10),
                        ),
                        image: DecorationImage(
                          image: NetworkImage(news.imageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(1),
                            ],
                          ),
                          borderRadius: const BorderRadius.vertical(
                            bottom: Radius.circular(10),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              news.title,
                              style: const TextStyle(
                                fontFamily: 'RobotoSlab-Regular',
                                fontSize: 20,
                                color: AppColors.white,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              "${news.author} - $formattedDate",
                              style: const TextStyle(
                                fontFamily: 'RobotoSlab-Bold',
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: AppColors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
