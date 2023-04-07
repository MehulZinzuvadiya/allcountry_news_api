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

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   Provider.of<NewsProvider>(context, listen: false).getNews('in');
  // }

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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                  onPressed: () {
                    newsProviderF!.changeCountry('gb');
                  },
                  child: Text("in")),
              TextButton(
                  onPressed: () {
                    newsProviderF!.changeCountry('uk');
                  },
                  child: Text("uk")),
              TextButton(
                  onPressed: () {
                    newsProviderF!.changeCountry('us');
                  },
                  child: Text("us")),
              TextButton(
                  onPressed: () {
                    newsProviderF!.changeCountry('uae');
                  },
                  child: Text('uae')),
            ],
          ),
          Expanded(
            child: FutureBuilder(
              future:
                  newsProviderT!.getNews('${newsProviderT!.selectedCountry}'),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                } else if (snapshot.hasData) {
                  NewsModel? nm1 = snapshot.data;

                  return ListView.builder(
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text("${nm1!.articles[index].source!.name}"),
                        subtitle: Text("${nm1!.articles[index].description}"),
                      );
                    },
                    itemCount: nm1!.articles.length,
                  );
                }

                return Container(child: CircularProgressIndicator());
              },
            ),
          )
        ],
      ),
    ));
  }
}
