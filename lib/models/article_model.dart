class ArticleModel {
  //Get all data from API

  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  String? content;
  String? publishedAt;

  ArticleModel(
      {this.author,
      this.content,
      this.title,
      this.description,
      this.url,
      this.urlToImage,
      this.publishedAt });
}
