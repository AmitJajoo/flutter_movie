
import 'package:flutter/material.dart';
import 'package:movie/constants.dart';
import 'package:movie/pages/fetch.dart';
import 'package:movie/pages/text_field_container.dart';

class DiabetesPage extends StatefulWidget {
  const DiabetesPage({Key? key}) : super(key: key);

  @override
  State<DiabetesPage> createState() => _DiabetesPageState();
}

class _DiabetesPageState extends State<DiabetesPage> {
  Future<FetchDiabetic>? _futureAlbum;
  // int? pregController
  //     gluController,
  //     bpController,
  //     skinController,
  //     insulinController,
  //     bmiController,
  //     dpfController,
  //     ageController;
  final TextEditingController pregController = new TextEditingController();
  final TextEditingController gluController = new TextEditingController();
  final TextEditingController bpController = new TextEditingController();
  final TextEditingController skinController = new TextEditingController();
  final TextEditingController insulinController = new TextEditingController();
  final TextEditingController bmiController = new TextEditingController();
  final TextEditingController dpfController = new TextEditingController();
  final TextEditingController ageController = new TextEditingController();
  bool loader = false;
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Diabetes Prediction"),
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
        child: Container(
          // color: Colors.amberAccent,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  offset: Offset(2, 2),
                  blurRadius: 10,
                  color: Color.fromRGBO(0, 0, 0, 0.16),
                )
              ]),
          margin: const EdgeInsets.symmetric(vertical: 10),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: (_futureAlbum == null)
              ? predDiabetes()
              : Center(child: buildFutureBuilder()),
        ),
      ),
    );
  }

  predDiabetes() {
    return Column(
      children: [
        TextFieldContainer(
          child: TextFormField(
            keyboardType: TextInputType.number,
            // onSaved: (newValue) => pregController = newValue! as int,
            controller: pregController,
            cursorColor: kPrimaryColor,
            decoration: const InputDecoration(
              hintText: 'Pregnancies',
              border: InputBorder.none,
            ),
          ),
        ),
        TextFieldContainer(
          child: TextFormField(
            keyboardType: TextInputType.number,
            // onSaved: (newValue) => gluController = newValue! as int,
            controller: gluController,
            cursorColor: kPrimaryColor,
            decoration: const InputDecoration(
              hintText: 'Glucose',
              border: InputBorder.none,
            ),
          ),
        ),
        TextFieldContainer(
          child: TextFormField(
            keyboardType: TextInputType.number,
            // onSaved: (newValue) => bpController = newValue! as int,
            controller: bpController,
            cursorColor: kPrimaryColor,
            decoration: const InputDecoration(
              hintText: 'Blood Pressure',
              border: InputBorder.none,
            ),
          ),
        ),
        TextFieldContainer(
          child: TextFormField(
            keyboardType: TextInputType.number,
            // onSaved: (newValue) => skinController = newValue! as int,
            controller: skinController,
            cursorColor: kPrimaryColor,
            decoration: const InputDecoration(
              hintText: 'SkinThickness',
              border: InputBorder.none,
            ),
          ),
        ),
        TextFieldContainer(
          child: TextFormField(
            keyboardType: TextInputType.number,
            // onSaved: (newValue) => insulinController = newValue! as int,
            controller: insulinController,
            cursorColor: kPrimaryColor,
            decoration: const InputDecoration(
              hintText: 'Insulin',
              border: InputBorder.none,
            ),
          ),
        ),
        TextFieldContainer(
          child: TextFormField(
            keyboardType: TextInputType.number,
            // onSaved: (newValue) => bmiController = newValue! as int,
            controller: bmiController,
            cursorColor: kPrimaryColor,
            decoration: const InputDecoration(
              hintText: 'BMI',
              border: InputBorder.none,
            ),
          ),
        ),
        TextFieldContainer(
          child: TextFormField(
            keyboardType: TextInputType.number,
            // onSaved: (newValue) => dpfController = newValue! as int,
            controller: dpfController,
            cursorColor: kPrimaryColor,
            decoration: const InputDecoration(
              hintText: 'DPF',
              border: InputBorder.none,
            ),
          ),
        ),
        TextFieldContainer(
          child: TextFormField(
            keyboardType: TextInputType.number,
            // onSaved: (newValue) => ageController = newValue! as int,
            controller: ageController,
            cursorColor: kPrimaryColor,
            decoration: const InputDecoration(
              hintText: 'Age',
              border: InputBorder.none,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        ElevatedButton(
            onPressed: () async {
              setState(() {
                _futureAlbum = createAlbum(
                    int.parse(pregController.text),
                    int.parse(gluController.text),
                    int.parse(bpController.text),
                    int.parse(skinController.text),
                    int.parse(insulinController.text),
                    int.parse(bmiController.text),
                    int.parse(dpfController.text),
                    int.parse(ageController.text));
              });
              // await buildFutureBuilder();
              //
            },
            child: const Text('Predict'),
            style: ElevatedButton.styleFrom(
                primary: kPrimaryColor,
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                textStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w500))),
      ],
    );
  }

  FutureBuilder<FetchDiabetic> buildFutureBuilder() {
    return FutureBuilder<FetchDiabetic>(
      future: _futureAlbum,
      builder: (context, snapshot) {
        print("data");
        if (snapshot.hasData) {
          return Center(
            heightFactor: 10,
            child: Text(
                '${snapshot.data!.isDiabetic == "0" ? "Not diabetic" : "diabetic"}'),
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return const CircularProgressIndicator();
      },
    );
  }
}
