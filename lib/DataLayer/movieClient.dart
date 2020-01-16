import 'dart:convert' as convert;
import 'package:flutter_app_credicxo/DataLayer/video.dart';
import 'package:http/http.dart' as http;

import 'movie.dart';

class MovieClinetApi {
  String apiKey = "802b2c4b88ea1183e50e6b285a27696e";
  static int currentStatusCode = -1;
  Future<List<Movie>> getData() async {
    List<Movie> list;

    String link = "http://api.themoviedb.org/3/movie/popular?api_key=$apiKey";
    var response = await http.get(link);
    currentStatusCode = response.statusCode;

    if (response.statusCode == 200) {
      var data = convert.jsonDecode(response.body);
      var rest = data["results"] as List;
      print(rest);
      list = rest.map<Movie>((json) => Movie.fromJson(json)).toList();
    }
    print("List Size: ${list.length}");
    return list;
  }

  Future<List<Video>> getVideoData(String id) async {
    List<Video> list;

    String link =
        'http://api.themoviedb.org/3/movie/$id/videos?api_key=$apiKey';
    var response = await http.get(link);
    currentStatusCode = response.statusCode;

    if (response.statusCode == 200) {
      var data = convert.jsonDecode(response.body);
      var rest = data["results"] as List;
      print(rest);
      list = rest.map<Video>((json) => Video.fromJson(json)).toList();
    }
    print("List Size: ${list.length}");
    return list;
  }

  static String getHeaderUrl(String backdrop_path) {
    return 'http://image.tmdb.org/t/p/w500' + backdrop_path;
  }

  static String getPosterUrl(poster_path) {
    return "http://image.tmdb.org/t/p/w185/$poster_path";
  }
}
