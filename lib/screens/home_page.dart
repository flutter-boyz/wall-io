import 'package:flutter/material.dart';
import '../models/image_model.dart';
import '../util/api_provider.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Hits> hits;

  _loadImages() async {
    var imageModel = await ApiProvider().getImages(5);
    setState(() {
      hits = imageModel.hits;
    });
  }

  @override
  void initState() {
    _loadImages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wall-io'),
      ),
      body: Center(
        child: hits.length > 0
            ? Image(
                image: hits.first.pageUrl,
              )
            : null,
      ),
    );
  }
}
