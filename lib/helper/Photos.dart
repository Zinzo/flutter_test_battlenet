import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class Photo {
  // final int albumId;
  // final int id;
  // final String url;
  final String title;
  final String thumbnailUrl;
  final String date;

  // Photo({this.albumId, this.id, this.title, this.url, this.thumbnailUrl});
  Photo({this.thumbnailUrl,this.title, this.date});

  factory Photo.fromJson(Map<String, dynamic> json) {
  return Photo(
    //  albumId: json['albumId'] as int,
    //  id: json["id"] as int,
    //  url: json['url'] as String,
     title: json["snippet"]["title"] as String,
     thumbnailUrl: json["snippet"]["thumbnails"]["high"]["url"] as String,
     date: json["snippet"]["publishedAt"].substring(0,10) as String
   );
  }
}

Future<List<Photo>> fetchPhotos(http.Client client, String data) async {
  String url = "https://www.googleapis.com/youtube/v3/search?part=snippet&key=AIzaSyAR1YOc4WpYMiEJ7XKHHdZmoXzKYzEvdfU&maxResults=10&q=${data}";
  final response = await client.get(url);
  return compute(parsePhotos, response.body);
}

List<Photo> parsePhotos(String responseBody) {
  final parsed = json.decode(responseBody)["items"].cast<Map<String, dynamic>>();
  return parsed.map<Photo>((json) => Photo.fromJson(json)).toList();
}