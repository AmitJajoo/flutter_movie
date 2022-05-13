import 'dart:async';
import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

String data = '';
FetchDiabetic fetchDiabeticFromJson(String str) =>
    FetchDiabetic.fromJson(json.decode(str));

String fetchDiabeticToJson(FetchDiabetic data) => json.encode(data.toJson());
Future<FetchDiabetic> createAlbum(int preg, int glucose, int bp, int skin,
    int insulin, int bmi, int dpf, int age) async {
  final response = await http.post(
    Uri.parse('https://flask-api-amit.herokuapp.com/api/v1/predict_diabetes'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, int>{
      "pregnancies": preg,
      "glucose": glucose,
      "bloodpressure": bp,
      "skinthickness": skin,
      "insulin": insulin,
      "bmi": bmi,
      "dpf": dpf,
      "age": age
    }),
  );
  print(response.body);
  print("object");
  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return fetchDiabeticFromJson(response.body);
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create album.');
  }
}

class FetchDiabetic {
  FetchDiabetic({
    required this.isDiabetic,
  });

  String isDiabetic;

  factory FetchDiabetic.fromJson(Map<String, dynamic> json) => FetchDiabetic(
        isDiabetic: json["isDiabetic"],
      );

  Map<String, dynamic> toJson() => {
        "isDiabetic": isDiabetic,
      };
}


// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   _MyAppState createState() {
//     return _MyAppState();
//   }
// }

// class _MyAppState extends State<MyApp> {
//   final TextEditingController _controller = TextEditingController();
//   Future<FetchDiabetic>? _futureAlbum;

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Fetch Data',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Fetch Data Demo'),
//         ),
//         body: Container(
//           alignment: Alignment.center,
//           padding: const EdgeInsets.all(8.0),
//           child: (_futureAlbum == null)
//               ? const DiabetesPage()
//               : buildFutureBuilder(),
//         ),
//       ),
//     );
//   }

//   FutureBuilder<FetchDiabetic> buildFutureBuilder() {
//     return FutureBuilder<FetchDiabetic>(
//       future: _futureAlbum,
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           return Text('${snapshot.data}');
//         } else if (snapshot.hasError) {
//           return Text('${snapshot.error}');
//         }

//         return const CircularProgressIndicator();
//       },
//     );
//   }
// }
