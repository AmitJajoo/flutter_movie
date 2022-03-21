// To parse this JSON data, do
//
//     final searchMovie = searchMovieFromJson(jsonString);

import 'dart:convert';

List<SearchMovie> searchMovieFromJson(String str) => List<SearchMovie>.from(json.decode(str).map((x) => SearchMovie.fromJson(x)));

String searchMovieToJson(List<SearchMovie> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SearchMovie {
  SearchMovie({
   required this.movie,
   required this.imdb,
  });

  String movie;
  String imdb;

  factory SearchMovie.fromJson(Map<String, dynamic> json) => SearchMovie(
    movie: json["movie"],
    imdb: json["imdb"],
  );

  Map<String, dynamic> toJson() => {
    "movie": movie,
    "imdb": imdb,
  };
}
