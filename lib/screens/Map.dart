import 'package:flutter/material.dart';

class Map extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Map")),
      body: Stack(
          children: <Widget>[
            Container(
              color: Colors.red
            ),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 20,
                    height: 20,
                    color: Colors.white
                  )
                ],
              ),
            )
          ],
        ),
      floatingActionButton: Container(
        child: Text("test"),
      ),
    );
  }
}