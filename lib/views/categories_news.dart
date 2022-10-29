import 'package:flutter/material.dart';

import '../helper/news.dart';
import '../models/article_model.dart';
import '../models/category_model.dart';
import 'article_view.dart';

class CategoriesNews extends StatefulWidget {
  // const CategoriesNews({super.key});

  String? queryCategory;

  CategoriesNews(this.queryCategory);

  @override
  State<CategoriesNews> createState() => _CategoriesNewsState();
}

class _CategoriesNewsState extends State<CategoriesNews> {
  List<CategoryModel> categories = [];
  List<ArticleModel> articles = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getCategoryNews();
  }

  getCategoryNews() async {
    CategoryNews getCategoryNews = CategoryNews(widget.queryCategory);

    await getCategoryNews.getNews();
    articles = getCategoryNews.news;
    setState(() {
      isLoading = false;
    });
  }

  CategoryModel categoryModel = CategoryModel();
  List<CategoryModel> categoryList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'App',
              style: TextStyle(color: Colors.black),
            ),
            Text(
              'News',
              style: TextStyle(color: Colors.blue),
            ),
          ],
        ),
        elevation: 0,
      ),
      body: isLoading
          ? Container(
              child: Center(child: CircularProgressIndicator()),
            )
          : SingleChildScrollView(
              child: Container(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemCount: articles.length,
                  itemBuilder: (context, index) {
                    return BlogTile(
                      articles[index].imageUrl,
                      articles[index].title,
                      articles[index].description,
                      articles[index].url,
                    );
                  },
                ),
              ),
            ),
    );
  }
}

class BlogTile extends StatelessWidget {
  // const BlogTile({super.key});
  String? imageUrl;
  String? title;
  String? description;
  String? url;

  BlogTile(this.imageUrl, this.title, this.description, this.url);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ArticleView(url)));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(imageUrl!)),
          SizedBox(
            height: 10,
          ),
          Text(
            title!,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            description!,
            style: TextStyle(color: Colors.grey),
          ),
        ]),
      ),
    );
  }
}
