// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:assignment8/api.dart';
import 'package:assignment8/main.dart';
import 'package:flutter/material.dart';

class EditCourse extends StatefulWidget {
  final String id, courseID, courseName, courseInstructor, courseCredits;

  final CourseApi api = CourseApi();

  EditCourse(this.id, this.courseID, this.courseName, this.courseInstructor,
      this.courseCredits);

  @override
  _EditCourseState createState() => _EditCourseState(
      id, courseID, courseName, courseInstructor, courseCredits);
}

class _EditCourseState extends State<EditCourse> {
  final String id, courseID, courseName, courseInstructor, courseCredits;
  List students = [];
  bool _dbLoaded = false;

  void initState() {
    super.initState();
    widget.api.getStudents().then((data) {
      setState(() {
        students = data;
        students.sort((a, b) => a.length.compareTo(b.length));
        _dbLoaded = true;
      });
    });
  }

  void _changeCourseInstructor(id, name) {
    setState(() {
      widget.api.editCourse(id, name);
    });
  }

  void _deleteCourse(id) {
    setState(() {
      widget.api.deleteCourse(id);
    });
  }

  TextEditingController instructorController = TextEditingController();

  _EditCourseState(this.id, this.courseID, this.courseName,
      this.courseInstructor, this.courseCredits);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit " + widget.courseName),
      ),
      body: Center(
        child: _dbLoaded
            ? Column(children: [
                ElevatedButton(
                  child: Icon(Icons.delete),
                  onPressed: () {
                    _deleteCourse(widget.id);
                    Navigator.pop(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MyHomePage()));
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                ),
                Expanded(
                  child: ListView(
                      shrinkWrap: true,
                      padding: EdgeInsets.all(15.0),
                      children: [
                        ...students
                            .map<Widget>(
                              (student) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 30),
                                child: ListTile(
                                  leading: CircleAvatar(
                                    radius: 25,
                                    child: Text(
                                      student['studentID'],
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  ),
                                  title: Text(
                                    (student['fname'] +
                                        "  " +
                                        student['lname']),
                                    style: TextStyle(fontSize: 20),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => MyHomePage()));
        },
        child: const Icon(Icons.home),
        backgroundColor: Colors.green,
      ),
    );
  }
}
