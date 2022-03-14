import 'package:flutter/material.dart';
import 'package:movie/modal/movie_modal.dart';

class Details extends StatefulWidget {
  final MovieRecommadation description;
  const Details({Key? key, required this.description}) : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(),
    );
  }
}
