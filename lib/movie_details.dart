import 'package:cached_network_image/cached_network_image.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie/modal/cast_modal.dart';
import 'package:movie/service/remote_service.dart';

import 'package:shimmer/shimmer.dart';

class DetailView extends StatefulWidget {
  const DetailView({
    Key? key,
    required this.movieId,
  }) : super(key: key);

  final int movieId;

  @override
  State<DetailView> createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  late CastModel movieName;
  bool isLoaded = false;
  List<String?> poster = [];
  List<String> actorName = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() async {
    movieName = (await RemoteService().getCastOfMovies())!;
    for (var i = 0; i < movieName.cast.length; i++) {
      poster.add(movieName.cast[i].profilePath);
      // releaseDate.add("${movieName.results[i].releaseDate}");
    }
    for (var i = 0; i < movieName.cast.length; i++) {
      if (poster[i] != null) {
        actorName.add(movieName.cast[i].originalName);
      }
    }
    poster.removeWhere((value) => value == null);
    print("111222 ${poster.length} ${actorName.length}");
    if (movieName != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final currencyFormatter = NumberFormat();

    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                Stack(
                  children: [
                    Shimmer.fromColors(
                      baseColor: Colors.white,
                      highlightColor: Colors.white54,
                      child: AspectRatio(
                          aspectRatio: 3 / 2,
                          child: Container(
                              decoration: const BoxDecoration(
                            color: Colors.black12,
                          ))),
                    ),
                    AspectRatio(
                        aspectRatio: 3 / 2,
                        child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: "https://image.tmdb.org/t/p/original/" +
                                "d3l7kgFJyLTTQSrR4ysCk5yeVyW.jpg")), //TODO
                  ],
                ),
                AspectRatio(
                  aspectRatio: 3 / 2,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(0.2),
                          Colors.black.withOpacity(1.0)
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: const [0, 1],
                      ),
                    ),
                  ),
                ),
                Positioned(
                    bottom: 0.0,
                    left: 10.0,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              Shimmer.fromColors(
                                baseColor: Colors.white10,
                                highlightColor: Colors.white30,
                                enabled: true,
                                child: SizedBox(
                                  height: 120.0,
                                  child: AspectRatio(
                                      aspectRatio: 2 / 3,
                                      child: Container(
                                          decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        color: Colors.black12,
                                      ))),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.0)),
                                height: 120.0,
                                child: AspectRatio(
                                    aspectRatio: 2 / 3,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(5.0),
                                      child: CachedNetworkImage(
                                          imageUrl:
                                              "https://image.tmdb.org/t/p/w200" +
                                                  "/5P0qKnCgOOuIBYHshSXDW4dU8Rh.jpg"), //TODO
                                    )),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 140,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "RRR",
                                  style: const TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Release date: " + "2022-04-01", //TODO
                                      style: const TextStyle(
                                          fontSize: 12.0,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w200),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
                Positioned(
                  left: 5.0,
                  child: SafeArea(
                      child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.arrow_back,
                            size: 25.0,
                          ))),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10.0,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      EvaIcons.clockOutline,
                      size: 15.0,
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      "3h 2min", //TODO //runtime
                      style: const TextStyle(
                          fontSize: 11.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: Container(
                        height: 40.0,
                        padding: const EdgeInsets.only(right: 10.0),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 3, //TODO //genre
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 5.0),
                              child: Center(
                                child: Container(
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(30.0)),
                                      color: Colors.black.withOpacity(0.3)),
                                  child: Text(
                                    "Comedy", //TODO  // genre type
                                    maxLines: 2,
                                    style: const TextStyle(
                                        height: 1.4,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 9.0),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Text("OVERVIEW",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                        color: Colors.black.withOpacity(0.5))),
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                    "Andy Stitzer has a pleasant life with a nice apartment and a job stamping invoices at an electronics store. But at age 40, there's one thing Andy hasn't done, and it's really bothering his sex-obsessed male co-workers: Andy is still a virgin. Determined to help Andy get laid, the guys make it their mission to de-virginize him. But it all seems hopeless until Andy meets small business owner Trish, a single mom.", //TODO Overview
                    style: const TextStyle(
                        height: 1.5,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w300)),
              ],
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Container(
            height: 250,
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.05)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("CASTS",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                        color: Colors.black.withOpacity(0.5))),
                const SizedBox(
                  height: 10.0,
                ),
                //ADD Cast here
                Visibility(
                  replacement: Center(child: CircularProgressIndicator()),
                  visible: isLoaded,
                  child: Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: poster.length,
                        itemBuilder: (context, index) {
                          return Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              SizedBox(
                                width: 140,
                                height: 200,
                                child: CachedNetworkImage(
                                    imageUrl:
                                        "https://image.tmdb.org/t/p/w200/" +
                                            poster[index]!,
                                    width: 90,
                                    height: 120,
                                    filterQuality: FilterQuality.high,
                                    fit: BoxFit.contain,
                                    color: Color.fromRGBO(0, 0, 0, 0.2),
                                    colorBlendMode: BlendMode.darken),
                              ),
                              Container(
                                  alignment: Alignment.bottomCenter,
                                  width: 90,
                                  height: 120,
                                  child: Text(
                                    actorName[index],
                                    style: TextStyle(
                                        color: Colors.white.withOpacity(0.9),
                                        fontFamily: "Nunito",
                                        fontWeight: FontWeight.bold),
                                  )),
                            ],
                          );
                        }),
                  ),
                )

                // RepositoryProvider.value(
                //   value: movieRepository,
                //   child: MovieCasts(
                //     themeController: themeController,
                //     movieRepository: movieRepository,
                //     movieId: movieId,
                //   ),
                // )
              ],
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text("ABOUT MOVIE",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                    color: Colors.black.withOpacity(0.5))),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Status:",
                        style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.black.withOpacity(0.5))),
                    Text("Released", //TODO status
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                        ))
                  ],
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Budget:",
                        style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.black.withOpacity(0.5))),
                    Text(
                        "\$" + currencyFormatter.format(260000), //TODO //Bugdet
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                        ))
                  ],
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Revenue:",
                        style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.black.withOpacity(0.5))),
                    Text(
                        "\$" +
                            currencyFormatter.format(177378645), //TODO revenue
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                        ))
                  ],
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Container(
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.05)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 10.0),
                  child: Text("SIMILAR MOVIES",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                          color: Colors.black.withOpacity(0.5))),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                // Padding(
                //   padding: const EdgeInsets.only(left: 2.0),
                //   child: RepositoryProvider.value(
                //     value: movieRepository,
                //     child: SimilarMoviesWidget(
                //       themeController: themeController,
                //       movieRepository: movieRepository,
                //       movieId: movieId,
                //     ),
                //   ),
                // )
              ],
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
        ],
      ),
    );
  }
}