import 'dart:convert';
import 'package:allcountry_news_api/NewsApp/model/news_model.dart';
import 'package:http/http.dart' as http;

class NewsHelper {
  String country = "in";

  Future<NewsModel> newsApi(String country) async {
    String link =
        "https://newsapi.org/v2/everything?q=$country&from=2023-03-06&sortBy=publishedAt&apiKey=98aff2f401254f4fb17b96a2ff5a00af";

    Uri uri = Uri.parse(link);

    var response = await http.get(uri);

    var json = jsonDecode(response.body);
    NewsModel n1 = NewsModel.fromJson(json);

    return n1;
  }
}
