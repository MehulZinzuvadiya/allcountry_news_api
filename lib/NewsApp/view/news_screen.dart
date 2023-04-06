import 'package:allcountry_news_api/NewsApp/model/news_model.dart';
import 'package:allcountry_news_api/NewsApp/provider/news_provider.dart';
import 'package:allcountry_news_api/Utils/newsapi_helper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  NewsProvider? newsProviderT;
  NewsProvider? newsProviderF;
  NewsModel? nm1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<NewsProvider>(context, listen: false).getNews('in');
  }

  @override
  Widget build(BuildContext context) {
    newsProviderT = Provider.of<NewsProvider>(context, listen: true);
    newsProviderF = Provider.of<NewsProvider>(context, listen: false);
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Times of India",
            style: GoogleFonts.dancingScript(fontSize: 24)),
        centerTitle: true,
        backgroundColor: Colors.red.shade700,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                    onPressed: () {
                      newsProviderT!.getNews("in");
                    },
                    child: Text("in")),
                TextButton(
                    onPressed: () {
                      newsProviderT!.getNews("uk");
                    },
                    child: Text("uk")),
                TextButton(
                    onPressed: () {
                      newsProviderT!.getNews("au");
                    },
                    child: Text("au")),
                TextButton(
                    onPressed: () {
                      newsProviderT!.getNews("us");
                    },
                    child: Text("us")),
              ],
            ),
            FutureBuilder(
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                } else if (snapshot.hasData) {
                  NewsModel? nm1 = snapshot.data;

                  return Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text("${nm1!.articles[index].source!.name}"),
                          subtitle: Text("${nm1!.articles[index].description}"),
                        );
                      },
                      itemCount: nm1!.articles.length,
                    ),
                  );
                }

                return CircularProgressIndicator();
              },
              future: newsProviderF!.getNews('uk'),
            )
          ],
        ),
      ),
    ));
  }
}
