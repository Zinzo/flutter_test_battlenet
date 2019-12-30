import 'dart:convert';

import 'package:battledotnet/screens/Image_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MainImageList();
  }
}

class MainImageList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: choices.length,
      child: Scaffold(
        appBar:AppBar(
          title:Text("KPOP"),
          bottom: TabBar(
            tabs: choices.map((Choice choice) {
              return Tab(
                text: choice.title,
              );
            }).toList(),
          ),
        ),
        body: 
        TabBarView(
          children: choices.map((Choice choice) {
            return Padding(
              padding: const EdgeInsets.all(0),
              child: ChoiceCard(choice: choice)
            );
          }).toList(),
        ),
      ),
    );
  }
}

class Choice {
  const Choice({this.title, this.icon, this.type});
  final String title;
  final IconData icon;
  final String type;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'Male Group', icon: Icons.directions_car, type: 'male'),
  const Choice(title: 'Female Group', icon: Icons.directions_bike, type: 'female'),
  const Choice(title: 'Entertainment', icon: Icons.directions_boat, type: 'ent')
];

class ChoiceCard extends StatelessWidget {
  const ChoiceCard({Key key, this.choice}) : super(key: key);

  final Choice choice;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Center(
      child: Container(
        child: FutureBuilder(
        key: key,
        future: loadAsset(choice),
        builder: (context, snapshot){
          if (snapshot.connectionState == ConnectionState.waiting || snapshot.data == null) {
            return Center(child: Container(
              child: CircularProgressIndicator(),
            ));
          }
          return ListView.builder(
            key: key,
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
            var testq = snapshot.data[index];
            return GestureDetector(
                onTap: (){goToImageList(context, snapshot.data[index]);},
                child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Column(
                children: <Widget>[
                  AspectRatio(
                    aspectRatio: 4/3,
                      child: Image.asset(testq['img'],
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom:24.0),
                          child: Padding(
                            padding: const EdgeInsets.only(top:8.0),
                            child: Text("${testq["title"]}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                          ),
                        ),
                      ],
                    ),
                  )
                ],)
              ),
            );}
          );
        })
      ),
    ));
  }
}

goToImageList(BuildContext context, data) {
  Navigator.push(context, MaterialPageRoute(builder: (context)=>Photos(data['keyword'])));
}

Future<List> loadAsset(Choice data) async {
  String test = await getList();
  List testq = await jsonDecode(test);
  List testqw;
  testq.forEach((good){
    if(good["type"] == data.type){
        testqw = good['data'];
    }
  });
  return testqw;
}

Future<String> getList() async {
  String test =  await rootBundle.loadString('lib/assets/data/default_main_list_data.json');
  return test;
}