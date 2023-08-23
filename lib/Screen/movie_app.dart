import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controller/PopularController.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'Screen Detail/detail_screen.dart';

class MovieApp extends StatefulWidget {
  const MovieApp({super.key});

  @override
  State<MovieApp> createState() => _MovieAppState();
}

class _MovieAppState extends State<MovieApp> {
  final popularController = Get.put(PopularMovieController());
  final pageController = PageController(viewportFraction: 0.4);

  int currentPage = 0;
  @override
  void initState() {
    Timer.periodic(const Duration(seconds: 3), (timer) {
      if (currentPage < popularController.getMovies.results!.length - 1) {
        currentPage++;
      } else {
        currentPage = 0;
      }
      pageController.animateToPage(currentPage,
          duration: const Duration(milliseconds: 300),
          curve: Curves.decelerate);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Movie Wheel',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
        ),
        centerTitle: true,
      ),
      body: popularController.obx(
        (state) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                "Now Showing",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
              child: PageView.builder(
                controller: pageController,
                itemCount: popularController.getMovies.results?.length ?? 0,
                itemBuilder: (context, index) {
                  final movies = popularController.getMovies.results?[index];
                  return GestureDetector(
                    onTap: () {
                      Get.to(
                        () => const DetailScreen(),
                        arguments: {
                          'title': movies.title ?? '',
                          'description': movies.overview ?? '',
                          'image': movies.posterPath ?? '',
                          'background': movies.backdropPath ?? '',
                          'vote': movies.voteAverage ?? '',
                          'date': movies.releaseDate ?? '',
                        },
                      );
                    },
                    child: Card(
                        child:
                            Stack(alignment: Alignment.bottomCenter, children: [
                      CachedNetworkImage(
                        placeholder: (context, url) => Center(
                            child: LoadingAnimationWidget.flickr(
                          leftDotColor: Colors.black,
                          rightDotColor: Colors.red,
                          size: 30,
                        )),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        imageUrl:
                            'https://image.tmdb.org/t/p/w500${movies?.posterPath}',
                        imageBuilder: (context, image) => Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(9),
                            image: DecorationImage(
                              image: image,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(9),
                            bottomRight: Radius.circular(9),
                          ),
                        ),
                        height: 50,
                        child: Text(
                          movies!.title ?? '',
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ])),
                  );
                },
              ),
            ),
            Center(
              child: SmoothPageIndicator(
                  controller: pageController,
                  count: popularController.getMovies.results!.length,
                  effect: const SwapEffect(
                      type: SwapType.yRotation,
                      dotColor: Colors.white,
                      activeDotColor: Colors.deepOrange,
                      dotHeight: 8,
                      dotWidth: 8)),
            ),
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                'Popular Movies',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            Expanded(
              child: GridView.builder(
                  padding: const EdgeInsets.all(10),
                  physics: const BouncingScrollPhysics(),
                  itemCount: popularController.getMovies.results?.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 0.8,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    final movies = popularController.getMovies.results?[index];
                    return GestureDetector(
                      onTap: () {
                        Get.to(
                          () => const DetailScreen(),
                          arguments: {
                            'title': movies.title ?? '',
                            'description': movies.overview ?? '',
                            'image': movies.posterPath ?? '',
                            'background': movies.backdropPath ?? '',
                            'vote': movies.voteAverage ?? '',
                            'date': movies.releaseDate ?? '',
                          },
                        );
                      },
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          CachedNetworkImage(
                            placeholder: (context, url) => Center(
                                child: LoadingAnimationWidget.flickr(
                                    leftDotColor: Colors.black,
                                    rightDotColor: Colors.red,
                                    size: 30)),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                            imageUrl:
                                'https://image.tmdb.org/t/p/w500${movies?.posterPath}',
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(9),
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              color: Colors.black54,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(9),
                                bottomRight: Radius.circular(9),
                              ),
                            ),
                            height: 50,
                            child: Text(
                              movies!.title ?? '',
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
          ],
        ),
        onLoading: Center(
          child: LoadingAnimationWidget.dotsTriangle(
              color: Colors.white, size: 40),
        ),
        onError: (error) => Center(
          child: Text(error ?? ''),
        ),
        onEmpty: const Center(
          child: Text('No Data'),
        ),
      ),
    );
  }
}
