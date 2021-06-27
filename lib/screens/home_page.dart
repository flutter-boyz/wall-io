import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:loading_indicator/loading_indicator.dart';
import '../models/image_model.dart';
import '../util/api_provider.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<PreloadPageController> controllers = [];
  List<Hits>? hits;
  // Hits? hit;

  _animatePage(int page, int index) {
    for (int i = 0; i < controllers.length; i++) {
      if (i != index) {
        controllers[i].animateToPage(page,
            duration: Duration(milliseconds: 300), curve: Curves.ease);
      }
    }
  }

  _loadImages() async {
    var imageModel = await ApiProvider().getImages(25);
    hits = imageModel.hits;
    setState(() {
      // hit = imageModel.hits![0];
    });
  }

  @override
  void initState() {
    _loadImages();
    controllers = [
      PreloadPageController(viewportFraction: 0.6, initialPage: 3),
      PreloadPageController(viewportFraction: 0.6, initialPage: 3),
      PreloadPageController(viewportFraction: 0.6, initialPage: 3),
      PreloadPageController(viewportFraction: 0.6, initialPage: 3),
      PreloadPageController(viewportFraction: 0.6, initialPage: 3),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: (hits != null)
          ? PreloadPageView.builder(
              controller:
                  PreloadPageController(viewportFraction: 0.7, initialPage: 3),
              itemCount: 5,
              preloadPagesCount: 5,
              itemBuilder: (context, mainIndex) {
                return PreloadPageView.builder(
                    itemCount: 5,
                    preloadPagesCount: 5,
                    controller: controllers[mainIndex],
                    scrollDirection: Axis.vertical,
                    physics: ClampingScrollPhysics(),
                    onPageChanged: (page) {
                      _animatePage(page, mainIndex);
                    },
                    itemBuilder: (context, index) {
                      var hitIndex = (mainIndex * 5) + index;
                      var hit;
                      if (hits != null) {
                        hit = hits![hitIndex];
                      }
                      return Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: CachedNetworkImage(
                            imageUrl: hit?.webformatURL,
                            // imageUrl:
                            //     "https://pixabay.com/get/gc5b5182455b4aabbb5fcc7fccd7faf84d112021938a7c92e0c14bbae3cbedb4094e75fc453bc6bc19abaddce57a0c29e5a93e3d3fbdfa250bc540704040bdedf_640.jpg",
                            fit: BoxFit.cover,
                          ));
                    });
              },
            )
          : LoadingIndicator(
              indicatorType: Indicator.ballScale,
              color: Colors.white,
            ),

      // child: CachedNetworkImage(
      //   imageUrl: hit!.webformatURL ??
      //       "https://pixabay.com/get/gc5b5182455b4aabbb5fcc7fccd7faf84d112021938a7c92e0c14bbae3cbedb4094e75fc453bc6bc19abaddce57a0c29e5a93e3d3fbdfa250bc540704040bdedf_640.jpg",
      //   fit: BoxFit.cover,
      // ),
    );
  }
}
