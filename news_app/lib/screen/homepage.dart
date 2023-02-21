import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/util/appbar.dart';
import 'package:news_app/constants/AppColors.dart';

class News {
  final String title;
  final String author;
  final String description;
  final String url;
  final String imageUrl;

  News({
    required this.title,
    required this.author,
    required this.description,
    required this.url,
    required this.imageUrl,
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
      body: SingleChildScrollView(
        child: Column(
          children: _newsList.map((news) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(10),
                        ),
                        image: DecorationImage(
                          image: NetworkImage(news.imageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            news.title,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "By ${news.author}",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            news.description,
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 8),
                        ],
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
