import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';

class StreamDemo extends StatefulWidget {
  @override
  _StreamDemoState createState() => _StreamDemoState();
}

class _StreamDemoState extends State<StreamDemo> {
  List<dynamic> dataList = [];
  StreamController streamController;

  @override
    void initState() {
      streamController = StreamController.broadcast();
      setupData();
      super.initState();
    }

  setupData() async {
    Stream stream = await getData()
    ..pipe(streamController);
    stream.listen((data) { setState(() {
       dataList.add(data[0]);
       dataList.add(data[1]);
       });
    });
  }
@override
  void dispose() {
    super.dispose();
    streamController?.close();
    streamController = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Multi-Item List"),
      ),
      body: ListView.builder(
        itemCount: dataList.length,
        itemBuilder: (context, index) {
          final item = dataList[index];
          if(item is Photo){
            return ListTile(
              title: Text(item.title),
              subtitle: Image.network(
                item.url,
                scale: 0.5,
              ),
            );
          }
          if(item is Post){
            return ListTile(
              title: Text("Title: ${item.title}"),
              subtitle: Text("Body: ${item.body}"),

            );
          }
        },
      ),
    );
  }
}


class Photo {
  final String url;
  final String title;
  Photo({this.url, this.title});

  Photo.fromJson(Map json)
      :url = json["url"],
      title = json["title"];
}

class Post {
  final String title;
  final String body;
  Post({this.title, this.body});

  Post.fromJson(Map json)
  :title = json["title"],
  body = json["body"];
}

Future<Stream> getData() async {
  final client = http.Client();
  Stream streamOne = LazyStream(() async => await getPhotos(client));
  Stream streamTwo = LazyStream(() async => await getPosts(client));

  return StreamGroup.merge([streamOne, streamTwo]).asBroadcastStream();
}

Future<Stream> getPhotos(http.Client client) async {
  final url = "https://jsonplaceholder.typicode.com/photos";
  final req = http.Request('get', Uri.parse(url));

  http.StreamedResponse streamedResponse = await client.send(req);

  return streamedResponse.stream
          .transform(utf8.decoder)
          .transform(json.decoder)
          .expand((e) => e)
          .map((map) => Photo.fromJson(map));
}

Future<Stream> getPosts(http.Client client) async {
  final url = "https://jsonplaceholder.typicode.com/posts";
  final req = http.Request('get', Uri.parse(url));

  http.StreamedResponse streamedResponse = await client.send(req);

  return streamedResponse.stream
          .transform(utf8.decoder)
          .transform(json.decoder)
          .expand((e) => e)
          .map((map) => Post.fromJson(map));
}