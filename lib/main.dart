import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie/home.dart';
import 'package:movie/movie.dart';
import 'package:movie/movie_details.dart';
import 'package:movie/pages/diabetes_page.dart';
import 'package:movie/pages/email_spam.dart';
import 'package:movie/search.dart';
import 'package:movie/top_rated_movie.dart';
import 'package:movie/upcoming_movies.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        // theme: ThemeData(
        //   // This is the theme of your application.
        //   //
        //   // Try running your application with "flutter run". You'll see the
        //   // application has a blue toolbar. Then, without quitting the app, try
        //   // changing the primarySwatch below to Colors.green and then invoke
        //   // "hot reload" (press "r" in the console where you ran "flutter run",
        //   // or simply save your changes to "hot reload" in a Flutter IDE).
        //   // Notice that the counter didn't reset back to zero; the application
        //   // is not restarted.
        //   primarySwatch: Colors.blue,
        // ),
        darkTheme: ThemeData.dark().copyWith(
            textTheme: ThemeData.dark().textTheme.apply(
                  fontFamily: 'Nunito',
                ),
            primaryTextTheme: ThemeData.dark().textTheme.apply(
                  fontFamily: 'Nunito',
                ),
            appBarTheme: AppBarTheme(
              backgroundColor: Color(0xFF222222),
              titleTextStyle:
                  const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
              systemOverlayStyle: const SystemUiOverlayStyle(
                  statusBarBrightness: Brightness.dark,
                  statusBarColor: Colors.white),
            ),
            buttonTheme: const ButtonThemeData(buttonColor: Colors.white),
            elevatedButtonTheme: ElevatedButtonThemeData(
                style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.black),
            )),
            scaffoldBackgroundColor: Colors.black,
            splashColor: Colors.black.withOpacity(0.0),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
                backgroundColor: Color(0xFF121212),
                selectedItemColor: Colors.white,
                unselectedItemColor: Colors.grey.shade700,
                selectedIconTheme: const IconThemeData(color: Colors.white),
                unselectedIconTheme: const IconThemeData(color: Colors.white)),
            primaryColor: Colors.black,
            dividerColor: Colors.white54,
            iconTheme: const IconThemeData(color: Colors.white),
            primaryIconTheme: const IconThemeData(color: Colors.black87)),
        home: Button());
  }
}

class Button extends StatelessWidget {
  const Button({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => DiabetesPage()));
              },
              child: Text("Diabetes Predication"),
              style: ElevatedButton.styleFrom(
                  primary: Colors.deepOrange,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  textStyle:
                      TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.deepOrange,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    textStyle:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => EmailSpam()));
                },
                child: Text("Spam Classification")),
          ),
          SizedBox(
            height: 30,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.deepOrange,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    textStyle:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => MyHomePage()));
                },
                child: Text("Movie Recommendation")),
          ),
        ],
      )),
    );
  }
}
