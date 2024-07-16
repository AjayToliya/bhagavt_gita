import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<String> jsondata;

  @override
  void initState() {
    super.initState();
    jsondata = rootBundle.loadString("assets/Json/data.json");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Bhagavad Gita Chapters'),
        ),
        body: FutureBuilder(
          future: jsondata,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              String? datas = snapshot.data;

              List chapter = (datas == null) ? [] : jsonDecode(datas);

              return;
            } else if (snapshot.hasError) {
              return Center(
                child: Text("error"),
              );
            }
          },
        ));
  }
}
