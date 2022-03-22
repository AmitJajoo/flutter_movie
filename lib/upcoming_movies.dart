import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:movie/service/remote_service.dart';
import 'package:shimmer/shimmer.dart';
import 'package:movie/modal/upcoming_movie_modal.dart';
import 'dart:typed_data';

class UpcomingMovieUi extends StatefulWidget {
  const UpcomingMovieUi({Key? key}) : super(key: key);

  @override
  State<UpcomingMovieUi> createState() => _UpcomingMovieUiState();
}

class _UpcomingMovieUiState extends State<UpcomingMovieUi> {
  late UpcomingMovie movieName;
  bool isLoaded = false;
  List<String?> poster = [];
  List<String> releaseDate = [];
  // List<String> title = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() async {
    movieName = (await RemoteService().getUpcomingMovies())!;
    for (var i = 0; i < movieName.results.length; i++) {
      poster.add(movieName.results[i].posterPath);
      releaseDate.add("${movieName.results[i].releaseDate}");
      // title.add(movieName.results[i].title);
    }
    poster.removeWhere((value) => value == null);
    print("111222 $releaseDate");
    if (movieName != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
        replacement: Center(
            child: CircularProgressIndicator(
          color: Colors.brown,
        )),
        visible: isLoaded,
        child: Stack(
          children: [
            CarouselSlider.builder(
                itemCount: poster.length,
                options: CarouselOptions(
                    autoPlay: true,
                    scrollDirection: Axis.horizontal,
                    viewportFraction: 1.0,
                    enlargeCenterPage: false,
                    height: MediaQuery.of(context).size.height),
                itemBuilder: (BuildContext context, int itemIndex,
                        int pageViewIndex) =>
                    // poster.map((item) =>
                    Stack(
                      children: [
                        Stack(
                          children: [
                            // Shimmer.fromColors(
                            //   baseColor: Colors.grey,
                            //   highlightColor: Colors.white54,
                            //   enabled: true,
                            //   child: SizedBox(
                            //     width: MediaQuery.of(context).size.width,
                            //     height: MediaQuery.of(context).size.height,
                            //     child: Icon(
                            //       Icons.abc_o,
                            //       color: Colors.blue,
                            //       size: 40.0,
                            //     ),
                            //   ),
                            // ),
                            ClipRRect(
                                borderRadius: BorderRadius.circular(5.0),
                                child: CachedNetworkImage(
                                  fit: BoxFit.fill,
                                  alignment: Alignment.center,
                                  placeholder: (context, url) =>
                                      LoadingAnimationWidget.fourRotatingDots(
                                          color: Colors.grey, size: 50),
                                  imageUrl:
                                      "https://image.tmdb.org/t/p/original/" +
                                          poster[itemIndex]!,
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height,
                                )),
                          ],
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                stops: const [
                                  0.0,
                                  0.4,
                                  0.4,
                                  1.0
                                ],
                                colors: [
                                  Colors.black.withOpacity(0.3),
                                  Colors.black.withOpacity(0.3),
                                  Colors.black.withOpacity(0.3),
                                  Colors.black.withOpacity(0.3),
                                ]),
                          ),
                        ),
                        Positioned(
                            top: 5.0,
                            right: 10.0,
                            child: SafeArea(
                              child: Column(
                                children: [
                                  const Text(
                                    "Release date: ",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12.0,
                                    ),
                                  ),
                                  Text(
                                    "${releaseDate[itemIndex]}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12.0,
                                        color: Colors.grey),
                                  ),
                                ],
                              ),
                            )),
                      ],
                    )),
            Positioned(
                left: 10.0,
                top: 10.0,
                child: SafeArea(
                  child: Text(
                    "Upcoming movies",
                    style: TextStyle(
                        fontFamily: 'NunitoBold',
                        fontSize: 18.0,
                        color: Colors.white.withOpacity(0.5)),
                  ),
                )),
          ],
        ));
  }
}
