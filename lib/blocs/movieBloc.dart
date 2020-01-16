import 'dart:async';

import 'package:flutter_app_credicxo/DataLayer/movie.dart';
import 'package:flutter_app_credicxo/DataLayer/movieClient.dart';

class MovieBloc {
  String videoId;

  List<Movie> moviesList;
  int status = -1;

  fetchAllMovies() async {
    _statusCodeStreamControler.sink.add(status);
    List<Movie> Movies = await MovieClinetApi().getData();
    status = MovieClinetApi.currentStatusCode;
    print("" + status.toString());
    _movieListStreamControler.sink.add(Movies);
    _statusCodeStreamControler.sink.add(status);
  }

  final _movieListStreamControler = StreamController<List<Movie>>();
  final _statusCodeStreamControler = StreamController<int>();

  Stream<List<Movie>> get movieListStream => _movieListStreamControler.stream;
  StreamSink<List<Movie>> get movieListSink => _movieListStreamControler.sink;

  Stream<int> get statusCodeStream => _statusCodeStreamControler.stream;
  StreamSink<int> get statusCodeSink => _statusCodeStreamControler.sink;

  MovieBloc() {
    fetchAllMovies();
  }

  void dispose() {
    _movieListStreamControler.close();
    _statusCodeStreamControler.close();
  }

  void movieDataListner(List<Movie> event) {
    _movieListStreamControler.sink.add(moviesList);
  }
}
