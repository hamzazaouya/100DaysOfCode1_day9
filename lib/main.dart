import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List posts = [];

  Future getPost() async {
    var url = Uri.parse("https://jsonplaceholder.typicode.com/posts");
    var response = await http.get(url);
    var responsebody = jsonDecode(response.body);
    setState(() {
      posts.addAll(responsebody);
    });
  }

  @override
  void initState() {
    getPost();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Day 9"),
          centerTitle: true,
        ),
        body: 
        posts == null || posts.isEmpty ? 
          Center(child: CircularProgressIndicator(),)
        :
        ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, i) {
              return Text("${posts[i]['id']}");
            }));
  }
}
