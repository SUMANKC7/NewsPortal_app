// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:news_app/models/article_model.dart';
import 'package:news_app/models/category_model.dart';
import 'package:news_app/screens/all_news.dart';
import 'package:news_app/screens/category_news.dart';
import 'package:news_app/screens/detailscreen.dart';
import 'package:news_app/services/data.dart';
import 'package:news_app/services/news.dart';
import 'package:news_app/theme/colors.dart';
import 'package:timeago/timeago.dart' as timeago;

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  List<CategoryModel> categories = [];
  List<ArticleModel> articles = [];
  bool _loading = true;
  @override
  void initState() {
    categories = getCategories();
    getNews();
    super.initState();
  }

  getNews() async {
    News newsClass = News();
    await newsClass.getNews();
    articles = newsClass.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              "assests/images/kabar.png",
              width: 99,
              height: 30,
            ),
            Material(
              elevation: 2,
              shape:RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.circular(10)),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.notifications_outlined,
                  size: 32,
                ),
              ),
            ),
          ],
        ),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: 18, right: 18, top: 15, bottom: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Latest",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          AllNews(news: "See all")));
                            },
                            child: Text(
                              "See all",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: ColorsPallate.catagoryColor),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 70,
                      margin: EdgeInsets.only(left: 8),
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          return CategoryTile(
                              categoryName: categories[index].categoryName);
                        },
                      ),
                    ),
                    Container(
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          itemCount: articles.length,
                          itemBuilder: (context, index) {
                            return BlogTile(
                              description: articles[index].description!,
                              imageUrl: articles[index].urlToImage!,
                              title: articles[index].title!,
                              author: articles[index].author!,
                              publishedAt: articles[index].publishedAt!,
                              url: articles[index].url!,
                            );
                          }),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  final categoryName, image;
  const CategoryTile({super.key, this.categoryName, this.image});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CategoryNews(name: categoryName)));
      },
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          child: Stack(
            children: [
              Container(
                child: Text(
                  categoryName,
                  style: TextStyle(
                    color: ColorsPallate.catagoryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class BlogTile extends StatelessWidget {
  String imageUrl, title, description, author, publishedAt, url;
  BlogTile(
      {super.key,
      required this.description,
      required this.imageUrl,
      required this.title,
      required this.author,
      required this.publishedAt,
      required this.url});
  @override
  Widget build(BuildContext context) {
// Parse the publishedAt string to a DateTime object
    DateTime publishedDate = DateTime.parse(publishedAt);

    // Initialize timeago library with custom localization
    timeago.setLocaleMessages('en', timeago.EnMessages());

    // Calculate the time ago string
    String timeAgo = timeago.format(publishedDate, allowFromNow: true);

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Detailscreen(blogUrl: url)));
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 16, bottom: 20),
        child: Material(
          elevation: 0.3,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 1),
                  child: Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        imageUrl,
                        height: 96,
                        width: 98.95,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 4,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        author,
                        style: TextStyle(
                            color: ColorsPallate.catagoryColor,
                            fontSize: 13,
                            letterSpacing: 0.12,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.6,
                      child: Text(
                        title,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.12,
                            color: ColorsPallate.newsTitle),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Image.asset(
                          "assests/images/bbc.png",
                          height: 20,
                          width: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5, right: 6),
                          child: Text(
                            author,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.12,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          CupertinoIcons.clock,
                          size: 14,
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Text(
                          timeAgo,
                          style: TextStyle(
                              color: ColorsPallate.catagoryColor,
                              fontSize: 13,
                              letterSpacing: 0.12,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
