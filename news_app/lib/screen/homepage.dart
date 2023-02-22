import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/util/appbar.dart';
import 'package:news_app/constants/AppColors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:news_app/screen/news_display.dart';
import 'package:news_app/screen/get_news.dart';

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
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NewsDisplay(news: news),
                    ),
                  );
                },
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
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
