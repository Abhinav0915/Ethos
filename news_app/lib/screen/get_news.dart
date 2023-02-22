import 'dart:convert';
import 'package:http/http.dart' as http;
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
  final prefs = await SharedPreferences.getInstance();
  final cachedData = prefs.getString('newsCache');
  if (cachedData != null) {
    // If there is cached data, return it
    final List<News> cachedNewsList = [];
    final List<dynamic> cachedResponseData = json.decode(cachedData);
    for (final article in cachedResponseData) {
      final News news = News(
        title: article["title"] ?? "",
        author: article["author"] ?? "Unknown",
        description: article["description"] ?? "",
        url: article["url"] ?? "",
        imageUrl: article["urlToImage"] ?? "",
        publishedAt: article["publishedAt"] ?? "",
      );
      cachedNewsList.add(news);
    }
    return cachedNewsList;
  } else {
    // If there is no cached data, fetch news from the API and cache the response
    String url =
        "https://newsapi.org/v2/top-headlines?country=us&apiKey=ba679dbdd4974c9492be054f2fd885c1";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final List<News> newsList = [];
      final Map<String, dynamic> responseData = json.decode(response.body);
      for (final article in responseData["articles"]) {
        final News news = News(
          title: article["title"] ?? "",
          author: article["author"] ?? "Unknown",
          description: article["description"] ?? "",
          url: article["url"] ?? "",
          imageUrl: article["urlToImage"] ?? "",
          publishedAt: article["publishedAt"] ?? "",
        );
        newsList.add(news);
      }
      await prefs.setString('newsCache', json.encode(responseData["articles"]));
      return newsList;
    } else {
      throw Exception("Failed to load news");
    }
  }
}
