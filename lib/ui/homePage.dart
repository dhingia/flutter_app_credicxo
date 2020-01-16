import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_credicxo/DataLayer/movie.dart';
import 'package:flutter_app_credicxo/DataLayer/movieClient.dart';
import 'package:flutter_app_credicxo/blocs/movieBloc.dart';

import 'detailPage.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final MovieBloc movieBloc = MovieBloc();

  @override
  void dispose() {
    movieBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: StreamBuilder<List<Movie>>(
          stream: movieBloc.movieListStream,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            print(snapshot.data);
            if (snapshot.data == null) {
              return Center(child: Text("Loading"));
            } else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, int i) => Column(
                  children: [
                    new ListTile(
                      leading: CircleAvatar(
                        radius: 30.0,
                        backgroundImage: NetworkImage(
                            MovieClinetApi.getPosterUrl(
                                snapshot.data[i].poster_path)),
                        backgroundColor: Colors.transparent,
                      ),
                      title: new Text(snapshot.data[i].title),
                      subtitle: new Text("popularity : " +
                          snapshot.data[i].popularity.toString()),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    DetailPage(snapshot.data[i])));
                      },
                      onLongPress: () {
                        print(
                          Text("Long Pressed"),
                        );
                      },
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
