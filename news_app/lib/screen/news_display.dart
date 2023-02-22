import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/screen/get_news.dart';
import 'package:news_app/constants/AppColors.dart';
import 'package:news_app/util/appbar.dart';

class NewsDisplay extends StatelessWidget {
  final News news;

  NewsDisplay({required this.news});

  @override
  Widget build(BuildContext context) {
    final publishedDate = DateTime.parse(news.publishedAt);
    final formattedDate = DateFormat('yyyy-MM-dd').format(publishedDate);

    return Scaffold(
      body: Stack(
        children: [
          Hero(
            tag: news.imageUrl,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(news.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
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
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                          child: Text(
                            news.title,
                            style: const TextStyle(
                              fontFamily: 'RobotoSlab-Bold',
                              fontWeight: FontWeight.bold,
                              fontSize: 29,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 64),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                              child: Text(
                                "${news.author}",
                                style: const TextStyle(
                                  fontFamily: 'RobotoSlab',
                                  fontSize: 20,
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                            Text(
                              "$formattedDate",
                              style: const TextStyle(
                                fontFamily: 'RobotoSlab',
                                fontSize: 20,
                                color: AppColors.white,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(24, 0, 24, 10),
                          child: Text(
                            news.description,
                            style: const TextStyle(
                              fontFamily: 'RobotoSlab-Regular',
                              fontSize: 14,
                              color: AppColors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 42,
            left: 24,
            child: Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black.withOpacity(0.5),
              ),
              child: IconButton(
                icon: Icon(Icons.arrow_back),
                color: Colors.white,
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
