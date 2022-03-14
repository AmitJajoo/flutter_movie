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
  List<dynamic> movieName = [];
  List newDataList = [];
  TextEditingController _textController = TextEditingController();
  TextEditingController myController = TextEditingController();

  Widget appBarTitle = new Text("AppBar Title");
  Icon actionIcon = new Icon(Icons.search);
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    myController.dispose();
    super.dispose();
  }

  refresh() async {
    String url = "https://apimovierecommadation.herokuapp.com/movies";
    http.Response response = await http.get(Uri.parse(url));
    debugPrint(response.body);
    var jsonResponse = convert.jsonDecode(response.body) as List<dynamic>;
    movieName = jsonResponse;
    newDataList = movieName;
    setState(() {});
  }

  onItemChanged(String value) {
    setState(() {
      newDataList = movieName
          .where((string) => string.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  final List<Map<String, dynamic>> _allUsers = [
    {"id": 1, "name": "Andy", "age": 29},
    {"id": 2, "name": "Aragon", "age": 40},
    {"id": 3, "name": "Bob", "age": 5},
    {"id": 4, "name": "Barbara", "age": 35},
    {"id": 5, "name": "Candy", "age": 21},
    {"id": 6, "name": "Colin", "age": 55},
    {"id": 7, "name": "Audra", "age": 30},
    {"id": 8, "name": "Banana", "age": 14},
    {"id": 9, "name": "Caversky", "age": 100},
    {"id": 10, "name": "Becky", "age": 32},
  ];
  List<Map<String, dynamic>> _foundUsers = [];

  @override
  void initState() {
    // TODO: implement initState
    _foundUsers = _allUsers;

    refresh();
    super.initState();
  }

  // This function is called whenever the text field changes
  _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = _allUsers;
    } else {
      results = _allUsers
          .where((user) =>
              user["name"].toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      _foundUsers = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    //FocusScope.of(context).requestFocus(FocusNode());
    return Scaffold(
      // appBar: AppBar(centerTitle: true, title: appBarTitle, actions: <Widget>[
      //   IconButton(
      //     icon: actionIcon,
      //     onPressed: () {
      //       setState(() {
      //         if (this.actionIcon.icon == Icons.search) {
      //           this.actionIcon = new Icon(Icons.close);
      //           this.appBarTitle = new TextField(
      //             controller: _textController,
      //             onChanged: onItemChanged,
      //             style: new TextStyle(
      //               color: Colors.white,
      //             ),
      //             decoration: new InputDecoration(
      //                 prefixIcon: new Icon(Icons.search, color: Colors.white),
      //                 hintText: "Search...",
      //                 hintStyle: new TextStyle(color: Colors.white)),
      //           );
      //         } else {
      //           this.actionIcon = new Icon(Icons.search);
      //           this.appBarTitle = new Text("AppBar Title");
      //         }
      //       });
      //     },
      //   ),
      // ]),

      // body: movieName.isEmpty
      // ? Center(
      //     child: CircularProgressIndicator(
      //     color: Colors.black,
      //   ))
      //     : ListView.builder(
      //         physics: ScrollPhysics(),
      //         shrinkWrap: true,
      //         itemCount: newDataList.length,
      //         itemBuilder: (context, index) {
      //           return GestureDetector(
      //             onTap: (){
      //               Navigator.push(context,MaterialPageRoute(builder: ((context) => Recommadation(movie_name:newDataList[index] ))));
      //             },
      //             child: ListTile(
      //               title: Text('${newDataList[index]}'),
      //             ),
      //           );
      //         })),
      // body: movieName.isEmpty
      //     ? Center(
      //         child: CircularProgressIndicator(
      //         color: Colors.black,
      //       ))
      //     : Column(
      //         children: [
      // Form(
      //   key: _formKey,
      //   child: TextFieldSearch(
      //       initialList: newDataList,
      //       label: "Movie name",
      //       decoration: InputDecoration(isDense: true),
      //       controller: myController),
      // ),
      //           ElevatedButton(
      //               onPressed: () {
      //                 Navigator.push(
      //                     context,
      //                     MaterialPageRoute(
      //                         builder: ((context) => Recommadation(
      //                             movie_name: myController.text))));
      //               },
      //               child: Text("Submit"))
      //         ],
      //       ),
      appBar: AppBar(
        title: Text("Pred App"),
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
      body: SingleChildScrollView(
        child: Column(mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Container(
            //     width: MediaQuery.of(context).size.width,
            //     height: 70,
            //     child: TextField(
            //       onChanged: (value) => _runFilter(value),
            //       decoration: InputDecoration(
            //         suffixIcon: Icon(
            //           Icons.search,
            //           color: Colors.grey,
            //         ),
            //         border: OutlineInputBorder(
            //           borderSide: new BorderSide(color: Colors.grey),
            //           gapPadding: 6.0,
            //         ),
            //         focusColor: Colors.grey,
            //         focusedBorder: OutlineInputBorder(
            //           borderSide: new BorderSide(color: Colors.grey),
            //         ),
            //         // labelText: 'Search Movie',
            //         hintText: 'Search Movie',
            //       ),
            //     ),
            //   ),
            // ),
            // SizedBox(
            //   height: 80,
            // ),
            //  Expanded(
            //   child: _foundUsers.isNotEmpty
            //       ? Container(

            //           height: 300,
            //           child: ListView.builder(
            //             itemCount: _foundUsers.length,
            //             itemBuilder: (context, index) => Card(
            //               key: ValueKey(_foundUsers[index]["id"]),
            //               color: Colors.amberAccent,
            //               elevation: 4,
            //               margin: const EdgeInsets.symmetric(vertical: 10),
            //               child: ListTile(
            //                 leading: Text(
            //                   _foundUsers[index]["id"].toString(),
            //                   style: const TextStyle(fontSize: 24),
            //                 ),
            //                 title: Text(_foundUsers[index]['name']),
            //                 subtitle: Text(
            //                     '${_foundUsers[index]["age"].toString()} years old'),
            //               ),
            //             ),
            //           ),
            //         )
            //       : const Text(
            //           'No results found',
            //           style: TextStyle(fontSize: 24),
            //         ),
            // ),
            Container(width: double.infinity,height: 300,child: Search()),
            SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.6,
                child: UpcomingMovieUi()),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(top: 20.0, left: 16, bottom: 4),
                  child: Text(
                    "All Time Top Rated Movies",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                SizedBox(height: 200, child: TopRated()),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class TestItem {
  String? label;
  dynamic value;
  TestItem({this.label, this.value});

  factory TestItem.fromJson(Map<String, dynamic> json) {
    return TestItem(label: json['label'], value: json['value']);
  }
}
