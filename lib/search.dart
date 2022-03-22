import 'package:flutter/material.dart';
import 'package:movie/modal/search_movie_modal.dart';
import 'package:movie/movie_details.dart';
import 'package:movie/service/remote_service.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  // This holds a list of fiction users
  // You can use data fetched from a database or a server as well
  TextEditingController _controller = TextEditingController();
  late List<SearchMovie> _allUsers=[];
  String imdb_id="";
  FocusNode focusNode = new FocusNode();

  String movie_name="";
  // final List<Map<String, dynamic>> _allUsers = [
  //   {"id": 1, "name": "Andy", "age": 29},
  //   {"id": 2, "name": "Aragon", "age": 40},
  //   {"id": 3, "name": "Bob", "age": 5},
  //   {"id": 4, "name": "Barbara", "age": 35},
  //   {"id": 5, "name": "Candy", "age": 21},
  //   {"id": 6, "name": "Colin", "age": 55},
  //   {"id": 7, "name": "Audra", "age": 30},
  //   {"id": 8, "name": "Banana", "age": 14},
  //   {"id": 9, "name": "Caversky", "age": 100},
  //   {"id": 10, "name": "Becky", "age": 32},
  // ];

  // This list holds the data for the list view
  List<SearchMovie> _foundUsers = [];
  @override
  initState() {
    // at the beginning, all users are shown


    super.initState();
    _foundUsers = [];
    getData();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _controller.dispose();
    FocusScope.of(context).unfocus();
    super.dispose();
  }

  getData() async {
    _allUsers = (await RemoteService().getSearch())!;
  }

  // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword) {
    _foundUsers = _allUsers;
    List<SearchMovie> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      // results = _allUsers;
      results=[];
    } else {
      results = _allUsers
          .where((user) =>
          user.movie.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
// results = _allUsers.where((element) => element['title'])
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      _foundUsers = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 60,
                width: double.infinity,
                child: TextField(
                  cursorColor: Colors.black45,
                  controller: _controller,
                  onChanged: (value) => _runFilter(value),
                  decoration:  InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black26, width: 1.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black26, width: 1.0),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.black.withOpacity(0.3),
                          width: 1.0),
                    ),
                    labelStyle: TextStyle(
                        color: focusNode.hasFocus ? Color(0xff8a8984) : Color(0xff94938f)
                    ),
                    labelText: 'Search', suffixIcon:InkWell(

                      child: Icon(Icons.search,color: Colors.black54,),
                      onTap: () {


                        Navigator.push(context,MaterialPageRoute(builder: (context)=>DetailView(movieId:imdb_id, name: movie_name,))).then((value) {
                          _controller.clear();
                          FocusScope.of(context).unfocus();
                          _foundUsers=[];
                        });
                      },
                    ),

                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: _foundUsers.isNotEmpty
                    ? ListView.builder(
                  itemCount: _foundUsers.length,
                  itemBuilder: (context, index) => Card(
                    key: ValueKey(_foundUsers[index].movie),
                    color: Colors.deepOrange,
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(vertical: 2),
                    child: GestureDetector(
                      onTap: (){
                        setState(() {
                          _controller.text=_foundUsers[index].movie;
                          movie_name=_foundUsers[index].movie;
                          imdb_id = _foundUsers[index].imdb;

                        });
                      },
                      child: ListTile(
                        // leading: Text(
                        //   _foundUsers[index].imdb.toString(),
                        //   style: const TextStyle(fontSize: 24),
                        // ),
                        title: Text(_foundUsers[index].movie,style: TextStyle(color: Colors.white),),
                        // subtitle: Text(
                        //     '${_foundUsers[index].imdb.toString()} years old'),
                      ),
                    ),
                  ),
                )
                    : const Text(
                  '',
                  style: TextStyle(fontSize: 24),
                ),
              ),

            ],
          ),
        ),

      ],
    );
  }
}