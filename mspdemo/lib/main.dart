import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String baseUrl;
  String alldogBreeds;
  List<String> dogBreeds;
  int iterator;
  bool isLoading;

  @override
  void initState() {
    super.initState();
    baseUrl = "https://dog.ceo/api";
    alldogBreeds = baseUrl + "/breeds/list/all";
    dogBreeds = [];
    getData(alldogBreeds);
    isLoading = true;
    iterator = 0;
  }

  Future<void> getData(String finalUrl) async {
    Response response = await get(finalUrl);
    Map jsonData = jsonDecode(response.body);
    for (var val in jsonData["message"].keys) {
      this.dogBreeds.add(
            val.toString(),
          );
    }
    print(dogBreeds.length);
    hideLoading();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(
          "Dogs",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/doggo.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: isLoading == true
              ? Center(child: CircularProgressIndicator())
              : Column(
                  children: <Widget>[
                    SizedBox(
                      height: 370.0,
                    ),
                    Center(
                      child: Text(
                          '${dogBreeds[iterator][0].toUpperCase()}${dogBreeds[iterator].substring(1)}',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 35.0,
                              fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(height: 40.0),
                    RaisedButton(
                        highlightElevation: 10.0,
                        child:
                            Text("Proceed", style: TextStyle(fontSize: 20.0)),
                        onPressed: () {
                          setState(() {
                            if (iterator == dogBreeds.length - 1) {
                              iterator = 0;
                            }
                            iterator++;
                          });
                        })
                  ],
                )),
    ));
  }

  void hideLoading() {
    setState(() {
      isLoading = false;
    });
  }
}
