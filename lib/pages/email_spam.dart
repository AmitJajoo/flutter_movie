

import 'package:flutter/material.dart';
import 'package:movie/constants.dart';
import 'package:movie/pages/spamFetch.dart';
import 'package:movie/pages/text_field_container.dart';

class EmailSpam extends StatefulWidget {
  const EmailSpam({Key? key}) : super(key: key);

  @override
  State<EmailSpam> createState() => _EmailSpamState();
}

class _EmailSpamState extends State<EmailSpam> {
  Future<FetchSpam>? _futureAlbum;

  // @override
  // void initState() {
  //   super.initState();
  //   _futureAlbum = spammer(message);
  // }
  final TextEditingController _controller = TextEditingController();
  String message = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Spam Classifier"),
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
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                offset: Offset(2, 2),
                blurRadius: 10,
                color: Color.fromRGBO(0, 0, 0, 0.16),
              )
            ]),
        child: (_futureAlbum == null)
            ? buildPage()
            : Center(child: buildSpamData()),
      ),
    );
  }

  buildPage() {
    return Column(
      children: [
        TextFieldContainer(
          child: TextFormField(
            controller: _controller,
            // onSaved: (newValue) => message = newValue!,
            keyboardType: TextInputType.multiline,
            maxLines: 6,
            decoration: InputDecoration(border: InputBorder.none),
            // maxLength: 1000,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        ElevatedButton(
            onPressed: () {
              // print('${message}');
              print(_controller.text);
              setState(() {
                _futureAlbum = spammer(_controller.text);
              });
              // _futureAlbum = spammer(message);
            },
            child: const Text('Predict'),
            style: ElevatedButton.styleFrom(
                primary: kPrimaryColor,
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                textStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w500)))
      ],
    );
  }

  FutureBuilder<FetchSpam> buildSpamData() {
    return FutureBuilder<FetchSpam>(
      future: _futureAlbum,
      builder: (context, snapshot) {
        print("data");
        if (snapshot.hasData) {
          return Center(
            heightFactor: 10,
            child: Text(
                '${snapshot.data?.isEmailSpam == 1 ? "Spam" : "not spam"}'),
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return Center(
            heightFactor: 10, child: const CircularProgressIndicator());
      },
    );
  }
}
