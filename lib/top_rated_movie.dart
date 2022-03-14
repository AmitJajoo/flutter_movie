import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie/modal/top_rated_modal.dart';
import 'package:movie/service/remote_service.dart';

class TopRated extends StatefulWidget {
  const TopRated({Key? key}) : super(key: key);

  @override
  State<TopRated> createState() => _TopRatedState();
}

class _TopRatedState extends State<TopRated> {
  late TopRatedMovieModel movieName;
  bool isLoaded = false;
  List<String> poster = [];
  List<String> releaseDate = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() async {
    movieName = (await RemoteService().getTopRatedMovies())!;
    for (var i = 0; i < movieName.results.length; i++) {
      poster.add(movieName.results[i].posterPath);
      releaseDate.add("${movieName.results[i].releaseDate}");
    }
    print("111222 $releaseDate");
    if (movieName != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: poster.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return SizedBox(
              // color: Colors.green,
              width: 140,
              height: 200,
              child: CachedNetworkImage(
                imageUrl:
                    "https://image.tmdb.org/t/p/original/" + poster[index],
                filterQuality: FilterQuality.high,
                fit: BoxFit.contain,
              ),
            );
          }),
    );
  }
}
