import "package:dio/dio.dart";

import './models/courses.dart';

const String localhost = "http://10.0.2.2:1200/";

class CourseApi {
  final _dio = Dio(BaseOptions(baseUrl: localhost));

  Future<List> getCourses() async {
    final response = await _dio.get('/sortCourses');

    return response.data['courses'];
  }

  Future<List> getStudents() async {
    final response = await _dio.get('/getAllStudents');

    return response.data['students'];
  }

  Future editStudent(String id, String name) async {
    final response =
        await _dio.post('/editStudentById', data: {'id': id, 'fname': name});
  }

  Future deleteCourse(String id) async {
    final response = await _dio.post('/deleteCourseById', data: {'_id': id});
  }
}
