// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:assignment8/editCourse.dart';
import 'package:flutter/material.dart';
import 'package:assignment8/api.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Assignment 8',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final CourseApi api = CourseApi();

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List courses = [];
  bool _dbLoaded = false;

  void initState() {
    super.initState();
    widget.api.getCourses().then((data) {
      setState(() {
        courses = data;
        _dbLoaded = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Assigment 8"),
      ),
      body: Center(
        child: _dbLoaded
            ? Column(children: [
                Expanded(
                  child: ListView(
                      shrinkWrap: true,
                      padding: EdgeInsets.all(15.0),
                      children: [
                        ...courses
                            .map<Widget>(
                              (course) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 30),
                                child: TextButton(
                                  onPressed: () => {
                                    Navigator.pop(context),
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => EditCourse(
                                                course['_id'],
                                                course['courseID'],
                                                course['courseName'],
                                                course['courseInstructor'],
                                                course['courseCredits']
                                                    .toString()))),
                                  },
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      radius: 25,
                                      child: Text(
                                        course['courseID'],
                                        style: TextStyle(fontSize: 10),
                                      ),
                                    ),
                                    title: Text(
                                      (course['courseName'] +
                                          " \nInstructor: " +
                                          course['courseInstructor'] +
                                          " \nCredits: " +
                                          course['courseCredits'].toString()),
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ]),
                )
              ])
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Database Loading",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  CircularProgressIndicator(),
                ],
              ),
      ),
    );
  }
}
