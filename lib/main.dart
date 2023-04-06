import 'package:allcountry_news_api/NewsApp/provider/news_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'NewsApp/view/news_screen.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => NewsProvider(),
      )
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => NewsScreen(),
      },
    ),
  ));
}
