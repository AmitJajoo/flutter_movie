import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie/home.dart';
import 'package:movie/movie.dart';
import 'package:movie/movie_details.dart';
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
      home: MyHomePage(),
    );
  }
}
