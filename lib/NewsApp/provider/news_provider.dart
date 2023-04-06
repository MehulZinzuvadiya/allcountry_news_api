import 'package:allcountry_news_api/NewsApp/model/news_model.dart';
import 'package:allcountry_news_api/Utils/newsapi_helper.dart';
import 'package:flutter/material.dart';

class NewsProvider extends ChangeNotifier {
  NewsModel? newsModeldata;

  Future<NewsModel> getNews(country) async {
    NewsHelper nh1 = NewsHelper();
    NewsModel newsModel = await nh1.newsApi(country);
    newsModeldata = newsModel;
    return newsModel;
  }

  @override
  notifyListeners();
}
