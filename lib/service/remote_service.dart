import 'package:dio/dio.dart';
import 'package:movie/modal/cast_modal.dart';
import 'package:movie/modal/movie_modal.dart';
import 'package:http/http.dart' as http;
import 'package:movie/modal/search_movie_modal.dart';
import 'package:movie/modal/single_details_movie.dart';
import 'package:movie/modal/top_rated_modal.dart';
import 'package:movie/modal/upcoming_movie_modal.dart';

class RemoteService {
  final String _apiKey = "26f79ea3c78de8808738bda241044608";
  static String mainUrl = "https://api.themoviedb.org/3";
  String getUpComingApi = '$mainUrl/movie/upcoming';
  String getTopRatedApi = "$mainUrl/movie/top_rated";
  String getCast = "$mainUrl/movie/";
  final Dio _dio = Dio();

  Future<List<MovieRecommadation>?> getMovies(String movie_name) async {
    var client = http.Client();
    var uri = Uri.parse(
        "https://apimovierecommadation.herokuapp.com/movie/" + movie_name);
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return movieRecommadationFromJson(json);
    }
  }

  Future<UpcomingMovie?> getUpcomingMovies() async {
    // var params = {"api_key": _apiKey, "language": "en-US", "page": 1};
    var client = http.Client();
    var uri = Uri.parse(getUpComingApi + "?api_key=" + _apiKey + "&region=IN");

    var response = await client.get(uri);

    if (response.statusCode == 200) {
      var json = response.body;
      return upcomingMovieFromJson(json);
    }
  }

  Future<TopRatedMovieModel?> getTopRatedMovies() async {
    // var params = {"api_key": _apiKey, "language": "en-US", "page": 1};
    var client = http.Client();
    var uri = Uri.parse(getTopRatedApi + "?api_key=" + _apiKey);

    var response = await client.get(uri);

    if (response.statusCode == 200) {
      var json = response.body;
      return topRatedMovieModelFromJson(json);
    }
  }

  Future<CastModel?> getCastOfMovies(String id) async {
    // var params = {"api_key": _apiKey, "language": "en-US", "page": 1};
    var client = http.Client();
    var uri = Uri.parse(getCast+"tt"+id+"/credits" + "?api_key=" + _apiKey+"&language=en-US");

    var response = await client.get(uri);

    if (response.statusCode == 200) {
      var json = response.body;
      return castModelFromJson(json);
    }
  }

  Future<List<SearchMovie>?> getSearch() async {
    var client = http.Client();
    var uri = Uri.parse("https://apimovierecommadation.herokuapp.com/movies");
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return searchMovieFromJson(json);
    }
  }

  Future<DetailsSingleMovieModal?> getDetailsSingleMovie(String id) async {
    // var params = {"api_key": _apiKey, "language": "en-US", "page": 1};
    var client = http.Client();
    var uri = Uri.parse("https://api.themoviedb.org/3/movie/tt"+id+"?api_key=8a1227b5735a7322c4a43a461953d4ff&language=en-US");

    var response = await client.get(uri);

    if (response.statusCode == 200) {
      var json = response.body;
      return detailsSingleMovieModalFromJson(json);
    }
  }
  // https://api.themoviedb.org/3/movie/tt8960382?api_key=8a1227b5735a7322c4a43a461953d4ff&language=en-US
}
