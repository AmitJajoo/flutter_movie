import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie/details_description.dart';
import 'package:movie/modal/movie_modal.dart';
import 'package:movie/service/remote_service.dart';

class Recommadation extends StatefulWidget {
  final String movie_name;
  Recommadation({Key? key, required this.movie_name}) : super(key: key);

  @override
  State<Recommadation> createState() => _RecommadationState();
}

class _RecommadationState extends State<Recommadation> {
  List<MovieRecommadation>? movieName;
  var isLoaded = false;
  @override
  void initState() {
    // TODO: implement initState
    // refresh();
    super.initState();
    getData();
  }

  // refresh() async {
  //   String url = "https://apimovierecommadation.herokuapp.com/movie/" +
  //       widget.movie_name;
  //   http.Response response = await http.get(Uri.parse(url));
  //   debugPrint(response.body);
  //   var jsonResponse = convert.jsonDecode(response.body) as List<dynamic>;
  //   print("22211144 $jsonResponse");
  //   movieName = jsonResponse;
  //   setState(() {});
  // }

  getData() async {
    movieName = await RemoteService().getMovies(widget.movie_name);
    if (movieName != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.movie_name)),
        body: Visibility(
          replacement: Center(
            child: CircularProgressIndicator(color: Colors.deepPurpleAccent),
          ),
          visible: isLoaded,
          child: ListView.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: movieName?.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                Details(description: movieName![index])));
                  },
                  child: Card(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          padding: const EdgeInsets.all(8),
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: 150,
                          child: CachedNetworkImage(
                            imageUrl: movieName![index].poster!,
                            width: MediaQuery.of(context).size.width * 0.3,
                            height: MediaQuery.of(context).size.height * 0.2,
                            fit: BoxFit.fill,
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.6,
                              child: Text(
                                movieName![index].title!,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.6,
                              child: Text(
                                  "Released Date: ${movieName![index].released}"),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text("Time: ${movieName![index].runtime!}"),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                                "IMDB rating: ${movieName![index].imdbRating}"),
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                                width: MediaQuery.of(context).size.width * 0.6,
                                child: Text(
                                    "Director: ${movieName![index].director}")),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              }),
        ));
  }
}
