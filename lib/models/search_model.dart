

class SearchResponseModel {
  List<SearchModel>? search;
  String? totalResults;
  String? response;

  SearchResponseModel({
    this.search,
    this.totalResults,
    this.response,
  });

  factory SearchResponseModel.fromJson(Map<String, dynamic> json) => SearchResponseModel(
    search: json["Search"] == null ? [] : List<SearchModel>.from(json["Search"]!.map((x) => SearchModel.fromJson(x))),
    totalResults: json["totalResults"],
    response: json["Response"],
  );

  Map<String, dynamic> toJson() => {
    "Search": search == null ? [] : List<dynamic>.from(search!.map((x) => x.toJson())),
    "totalResults": totalResults,
    "Response": response,
  };
}

class SearchModel {
  String? title;
  String? year;
  String? imdbId;
  String? type;
  String? poster;

  SearchModel({
    this.title,
    this.year,
    this.imdbId,
    this.type,
    this.poster,
  });

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
    title: json["Title"],
    year: json["Year"],
    imdbId: json["imdbID"],
    type: json["Type"],
    poster: json["Poster"],
  );

  Map<String, dynamic> toJson() => {
    "Title": title,
    "Year": year,
    "imdbID": imdbId,
    "Type": type,
    "Poster": poster,
  };
}
