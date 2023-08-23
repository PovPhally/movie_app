import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  var image = Get.arguments;
  var title = Get.arguments;
  var overview = Get.arguments;
  var backdropPath = Get.arguments;
  var voteAverage = Get.arguments;
  var releaseDate = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: CachedNetworkImageProvider(
              'https://image.tmdb.org/t/p/w500${image['image']}'),
          opacity: 0.5,
          filterQuality: FilterQuality.high,
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text(
            'Movie Wheel',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
          ),
          centerTitle: true,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(
                  10,
                ),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: CachedNetworkImage(
                          placeholder: (context, url) => Center(
                            child: LoadingAnimationWidget.flickr(
                              leftDotColor: Colors.black,
                              rightDotColor: Colors.red,
                              size: 30,
                            ),
                          ),
                          height: 250,
                          width: 300,
                          alignment: Alignment.centerLeft,
                          imageUrl:
                              'https://image.tmdb.org/t/p/w500${image['image']}',
                          imageBuilder: (context, image) => Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: image,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.05,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${title['title']}',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01,
                            ),
                            RichText(
                                text: TextSpan(
                              children: [
                                TextSpan(
                                  text: '${voteAverage['vote']}',
                                  style: const TextStyle(
                                    color: Colors.yellow,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const WidgetSpan(
                                  child: Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                  ),
                                ),
                              ],
                            )),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01,
                            ),
                            Text('${releaseDate['date']}',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Text('${overview['description']}',
                      textAlign: TextAlign.start,
                      textScaleFactor: 1,
                      style: const TextStyle(
                        height: 1.5,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        decorationColor: Colors.black,
                        fontSize: 19,
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
