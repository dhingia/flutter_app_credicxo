class Movie {
  int id;
  double popularity;
  bool video;
  var vote_count;
  var vote_average;
  String title;
  String release_date;
  String original_language;
  String original_title;
  List<int> genre_ids;
  String backdrop_path;
  bool adult;
  String overview;
  String poster_path;

  Movie.fromJson(Map json)
      : id = json['id'],
        popularity = json['popularity'],
        video = json['video'],
        vote_count = json['vote_count'],
        vote_average = json['vote_average'],
        title = json['title'],
        release_date = json['release_date'],
        original_language = json['original_language'],
        original_title = json['original_title'],
        genre_ids = json != null ? List.from(json['genre_ids']) : null,
        backdrop_path = json['backdrop_path'],
        adult = json['adult'],
        overview = json['overview'],
        poster_path = json['poster_path'];
}
