import 'dart:io';

import 'package:android_intent/android_intent.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movies/data/models/actor.dart';
import 'package:flutter_movies/data/movie_db_api.dart';
import 'package:flutter_movies/ui/loading_indicator_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class CrewDetailPage extends StatelessWidget {
  final int crewId;
  final String crewName;
  final String heroImageURL;
  final String heroImageTag;

  CrewDetailPage(
      this.crewId, this.crewName, this.heroImageURL, this.heroImageTag);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: CustomScrollView(slivers: <Widget>[
      SliverAppBar(
          expandedHeight: 300.0,
          floating: false,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(
              crewName,
            ),
            background: Hero(
                tag: heroImageTag,
                child: CachedNetworkImage(
                  imageUrl: heroImageURL,
                  fit: BoxFit.fitWidth,
                )),
          )),
      SliverList(
          delegate: SliverChildListDelegate([
        Container(
            margin: EdgeInsets.all(10), child: _CrewInfoWidget(this.crewId))
      ]))
    ])));
  }
}

class _CrewInfoWidget extends StatefulWidget {
  final int crewId;

  _CrewInfoWidget(this.crewId);

  @override
  _CrewInfoWidgetState createState() {
    return new _CrewInfoWidgetState();
  }
}

class _CrewInfoWidgetState extends State<_CrewInfoWidget> {
  Actor actor;

  @override
  void initState() {
    super.initState();
    var call = MovieDB.getInstance().getActorById(widget.crewId);
    call.then((data) {
      setState(() {
        actor = data;
      });
    });
  }

  void _launchWeb(String url) async {
    if(Platform.isAndroid){
      AndroidIntent intent = new AndroidIntent(
          action: 'action_view',
          data: url
      );
      await intent.launch();
    }
    else{
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (actor == null) {
      return LoadingIndicatorWidget();
    }

    var widgets = <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          GestureDetector(
              onTap: () => _launchWeb(
                  "https://www.imdb.com/name/${actor.imdb_id}"),
              child: Image.asset("assets/images/imdb.png",
                  height: 100, width: 100))
        ],
      )
    ];

    if(actor.birthday != null){
      widgets.add(Container(
        margin: EdgeInsets.all(10),
        child: Text("Birthday: ${actor.birthday}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ));
    }

    widgets.add(Container(
      margin: EdgeInsets.all(10),
      child: Text(actor.biography, style: TextStyle(fontSize: 16)),
    ));

    return Flex(
        direction: Axis.vertical,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: widgets);
  }
}
