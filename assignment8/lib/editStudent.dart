// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:assignment8/api.dart';
import 'package:assignment8/main.dart';
import 'package:flutter/material.dart';

class editStudent extends StatefulWidget {
  final String id, fname, lname;

  final CourseApi api = CourseApi();

  editStudent(this.id, this.fname, this.lname);

  @override
  _editStudentState createState() => _editStudentState(id, fname, lname);
}

class _editStudentState extends State<editStudent> {
  final String id, fname, lname;
  List students = [];
  bool _dbLoaded = false;

  void initState() {
    super.initState();
    widget.api.getStudents().then((data) {
      setState(() {
        students = data;
        _dbLoaded = true;
      });
    });
  }

  void _changeStudentFName(id, fname) {
    setState(() {
      widget.api.editStudent(id, fname);
    });
  }

  TextEditingController studentController = TextEditingController();

  _editStudentState(this.id, this.fname, this.lname);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit " + widget.fname + " " + widget.lname),
      ),
      body: Center(
        child: _dbLoaded
            ? Column(children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        controller: studentController,
                      ),
                      ElevatedButton(
                          onPressed: () => {
                                _changeStudentFName(
                                    widget.id, studentController.text),
                                Navigator.pop(context),
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MyHomePage())),
                              },
                          child: Text("Change Students First Name"))
                    ],
                  ),
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
