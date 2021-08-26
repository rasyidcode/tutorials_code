class ApiResultModel {
  String? status;
  int? totalResults;
  List<Articles>? articles;

  ApiResultModel({this.status, this.totalResults, this.articles});

  ApiResultModel.fromJson(Map<String, dynamic> json) {
    this.status = json['status'] ?? '';
    this.totalResults = json['totalResults'] ?? 0;
    if (json['articles'] != null) {
      this.articles = List.empty(growable: true);
      json['articles'].forEach((v) {
        this.articles!.add(new Articles.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status ?? null;
    data['totalResults'] = this.totalResults ?? null;
    data['articles'] = this.articles != null
        ? this.articles!.map((v) => v.toJson()).toList()
        : null;
    return data;
  }
}

class Articles {
  Source? source;
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  String? publishedAt;
  String? content;

  Articles(
      {this.source,
      this.author,
      this.title,
      this.description,
      this.url,
      this.urlToImage,
      this.publishedAt,
      this.content});

  Articles.fromJson(Map<String, dynamic> json) {
    source =
        json['source'] != null ? new Source.fromJson(json['source']) : null;
    author = json['author'] ?? null;
    title = json['title'] ?? null;
    description = json['description'] ?? null;
    url = json['url'] ?? null;
    urlToImage = json['urlToImage'] ?? null;
    publishedAt = json['publishedAt'] ?? null;
    content = json['content'] ?? null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['source'] = this.source != null ? this.source!.toJson() : null;
    data['author'] = this.author ?? null;
    data['title'] = this.title ?? null;
    data['description'] = this.description ?? null;
    data['url'] = this.url ?? null;
    data['urlToImage'] = this.urlToImage ?? null;
    data['publishedAt'] = this.publishedAt ?? null;
    data['content'] = this.content ?? null;
    return data;
  }
}

class Source {
  String? id;
  String? name;

  Source({this.id, this.name});

  Source.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? null;
    name = json['name'] ?? null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id ?? null;
    data['name'] = this.name ?? null;
    return data;
  }
}
