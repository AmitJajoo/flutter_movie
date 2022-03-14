import 'package:dio/dio.dart';
import 'package:movie/modal/cast_modal.dart';
import 'package:movie/modal/movie_modal.dart';
import 'package:http/http.dart' as http;
import 'package:movie/modal/top_rated_modal.dart';
import 'package:movie/modal/upcoming_movie_modal.dart';

class RemoteService {
  final String _apiKey = "26f79ea3c78de8808738bda241044608";
  static String mainUrl = "https://api.themoviedb.org/3";
  String getUpComingApi = '$mainUrl/movie/upcoming';
  String getTopRatedApi = "$mainUrl/movie/top_rated";
  String getCast = "$mainUrl/movie/tt5074352/credits";
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

  Future<CastModel?> getCastOfMovies() async {
    // var params = {"api_key": _apiKey, "language": "en-US", "page": 1};
    var client = http.Client();
    var uri = Uri.parse(getCast + "?api_key=" + _apiKey+"&language=en-US");

    var response = await client.get(uri);

    if (response.statusCode == 200) {
      var json = response.body;
      return castModelFromJson(json);
    }
  }
}
