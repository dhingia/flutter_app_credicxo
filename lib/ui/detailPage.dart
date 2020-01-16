import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_credicxo/DataLayer/movie.dart';
import 'package:flutter_app_credicxo/DataLayer/movieClient.dart';
import 'package:flutter_app_credicxo/DataLayer/video.dart';
import 'package:flutter_app_credicxo/blocs/videoBloc.dart';

import 'package:youtube_player/youtube_player.dart';

class DetailPage extends StatefulWidget {
  final Movie movie;

  DetailPage(this.movie, {Key key}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final VideoBloc videoBloc = VideoBloc();
  @override
  void initState() {
    if (widget.movie.id.toString() != null) {
      videoBloc.fetchAllVideos(widget.movie.id.toString());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.movie.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.amberAccent,
              width: double.infinity,
              child: Image.network(
                MovieClinetApi.getHeaderUrl(widget.movie.backdrop_path),
                fit: BoxFit.fitWidth,
              ),
            ),
            Card(
              margin: EdgeInsets.all(8),
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Center(
                        child: Image.network(
                          MovieClinetApi.getPosterUrl(widget.movie.poster_path),
                        ),
                      ),
                      flex: 1,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              widget.movie.title,
                              style: TextStyle(
                                fontSize: 30.0,
                              ),
                            ),
                            Text(
                              widget.movie.overview,
                            ),
                          ],
                        ),
                      ),
                      flex: 2,
                    )
                  ],
                ),
              ),
            ),
            Container(
              child: StreamBuilder<List<Video>>(
                stream: videoBloc.videoListStream,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  print(snapshot.data);
                  if (snapshot.data == null) {
                    return Container(child: Center(child: Text("Loading...")));
                  } else if (snapshot.data.isEmpty) {
                    return Container(
                        child: Center(child: Text("NO data found")));
                  } else {
                    return Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: YoutubePlayer(
                        source: snapshot.data[0].key,
                        quality: YoutubeQuality.HD,
                        aspectRatio: 16 / 9,
                        showThumbnail: true,
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
