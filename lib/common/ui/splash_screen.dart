import 'dart:async';
import 'package:battledotnet/screens/main_page.dart';
import 'package:flutter/material.dart';


class SplashScreen extends StatefulWidget{
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
            image: AssetImage('lib/assets/img/giphy.gif'),
            fit: BoxFit.contain
        ) ,
      ),
      // child: Center(
      //   child: CircularProgressIndicator(
      //     valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent),
      //   ),
      // ),
    );
  }

  Future<Timer> loadData() async {
    return new Timer(Duration(seconds: 5), onDoneLoading);
    // await loadDataAsset();
    // return await onDoneLoading();
  }

  onDoneLoading() async{
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MainImageList()));
  }
}

loadDataAsset() async {
  // await rootBundle.loadString('lib/assets/data/default_data.json');
  return true;
}