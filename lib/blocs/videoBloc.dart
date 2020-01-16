import 'dart:async';

import 'package:flutter_app_credicxo/DataLayer/movieClient.dart';
import 'package:flutter_app_credicxo/DataLayer/video.dart';

class VideoBloc {
  String videoId;

  List<Video> moviesList;

  fetchAllVideos(String id) async {
    List<Video> videos = await MovieClinetApi().getVideoData(id);
    _videoListStreamControler.sink.add(videos);
    return _videoListStreamControler.stream;
  }

  final _videoListStreamControler = StreamController<List<Video>>();

  Stream<List<Video>> get videoListStream => _videoListStreamControler.stream;
  StreamSink<List<Video>> get videoListSink => _videoListStreamControler.sink;

  VideoBloc();

  void dispose() {
    _videoListStreamControler.close();
  }
}
