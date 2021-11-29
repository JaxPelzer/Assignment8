class Course {
  final String id;
  final String courseID;
  final String courseName;
  final String courseInstructor;
  final String courseCredits;

  Course._(this.id, this.courseID, this.courseName, this.courseInstructor,
      this.courseCredits);

  factory Course.fromJson(Map json) {
    final id = json['_id'];
    final courseID = json['CourseID'];
    final courseName = json['courseName'];
    final courseInstructor = json['courseInstructor'];
    final courseCredits = json['courseCredits'];

    return Course._(id, courseID, courseName, courseInstructor, courseCredits);
  }
}
