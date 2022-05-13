import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<FetchSpam> spammer(String spam) async {
  final response = await http.post(
    Uri.parse('https://flask-api-amit.herokuapp.com/api/v1/email_spam'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{"messageString": spam}),
  );
  print(response.statusCode);
  // print("object");
  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return FetchSpam.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create album.');
  }
}

class FetchSpam {
  int? isEmailSpam;

  FetchSpam({this.isEmailSpam});

  FetchSpam.fromJson(Map<String, dynamic> json) {
    isEmailSpam = json['isEmailSpam'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isEmailSpam'] = this.isEmailSpam;
    return data;
  }
}


