import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/image_model.dart';
import '../util/api_provider.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Hits>? hits;
  Hits? hit;

  _loadImages() async {
    var imageModel = await ApiProvider().getImages(5);
    setState(() {
      hits = imageModel.hits;
      hit = imageModel.hits![0];
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
        child: CachedNetworkImage(
          imageUrl: hit!.webformatURL ??
              "https://pixabay.com/get/gc5b5182455b4aabbb5fcc7fccd7faf84d112021938a7c92e0c14bbae3cbedb4094e75fc453bc6bc19abaddce57a0c29e5a93e3d3fbdfa250bc540704040bdedf_640.jpg",
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
