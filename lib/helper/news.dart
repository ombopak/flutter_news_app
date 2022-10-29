import 'dart:convert';

import 'package:http/http.dart' as http;

import '../api_key.dart';
import '../models/article_model.dart';

class News {
  List<ArticleModel> news = [];

  Future<void> getNews() async {
    String curatedNews =
        'https://newsapi.org/v2/top-headlines?country=id&apiKey=$API_KEY';

    var response = await http.get(Uri.parse(curatedNews));

    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == 'ok') {
      jsonData['articles'].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          ArticleModel articleModel = ArticleModel(
            imageUrl: element['urlToImage'],
            title: element['title'],
            description: element['description'],
            url: element['url'],
          );
          news.add(articleModel);
        }
      });
    }
  }
}

class CategoryNews {
  List<ArticleModel> news = [];
  String? searchQuery;

  CategoryNews(this.searchQuery);

  Future<void> getNews() async {
    String curatedNews =
        'https://newsapi.org/v2/everything?q=$searchQuery&sortBy=popularity&apiKey=$API_KEY';

    var response = await http.get(Uri.parse(curatedNews));

    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == 'ok') {
      jsonData['articles'].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          ArticleModel articleModel = ArticleModel(
            imageUrl: element['urlToImage'],
            title: element['title'],
            description: element['description'],
            url: element['url'],
          );
          news.add(articleModel);
        }
      });
    }
  }
}
