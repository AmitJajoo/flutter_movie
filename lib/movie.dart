import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:movie/recommadation.dart';
import 'package:movie/search.dart';
import 'package:movie/top_rated_movie.dart';
import 'package:movie/upcoming_movies.dart';
import 'package:textfield_search/textfield_search.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    //FocusScope.of(context).requestFocus(FocusNode());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Movie Recommendation"),
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                // begin: Alignment.topCenter,
                // end: Alignment.bottomCenter,
                colors: <Color>[Colors.orange, Colors.deepOrange]),
          ),
        ),
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(top: 100),
              child: Column(
                // mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.6,
                      child: UpcomingMovieUi()),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0, left: 16, bottom: 4),
                        child: Text(
                          "All Time Top Rated Movies",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                      SizedBox(height: 200, child: TopRated()),
                    ],
                  )
                ],
              ),
            ),
          ),
          Search(),
        ],
      ),
    );
  }
}
