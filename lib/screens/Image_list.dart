import 'package:battledotnet/helper/Photos.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class Photos extends StatelessWidget {
  Photos(String data) : super(){
    this.data = data;
  }
  String data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title:Text('KPOP')),
        body: Column(
        children: <Widget>[
          Expanded(
            child: FutureBuilder<List<Photo>>(
              future: fetchPhotos(http.Client(),this.data),
              builder: (context, snapshot) {
                if (snapshot.hasError) print(snapshot.error);
                return snapshot.hasData ? PhotosList(photos: snapshot.data)
                : Center(child: CircularProgressIndicator());
              },
            )
          )
        ],
      ),
    );
  }
}

class PhotosList extends StatelessWidget {
  final List<Photo> photos;
  PhotosList({Key key,  this.photos}) : super(key: key);

  @override
  Widget build (BuildContext context) {
    return ListView.builder(
      itemCount:  photos.length,
      itemBuilder: (context, index) {
        return Card(
            child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex:1,
                  child: Image.network(photos[index].thumbnailUrl,fit:BoxFit.cover)
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(left:8.0),
                    child: Column(
                      children: <Widget>[
                        Text(
                          photos[index].title,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          photos[index].date,
                          textAlign: TextAlign.right,
                        )
                      ],
                    ),
                  )
                )
              ],
            ),
          ),
        );
      },
    );
  }
}