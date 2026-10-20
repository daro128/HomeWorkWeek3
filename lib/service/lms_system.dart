
import '../model/student.dart';
import '../model/course.dart';
import '../model/enrollment.dart';
import '../model/result.dart';

class LmsSystem {
  final List<Student> students = [];
  final List<Course> courses = [];
  final List<Enrollment> enrollments = [];
  final List<Result> results =[];

 
  void addStudent({required String studentId, required String studentName}) {
    // ! Student shall not exist already
    Student? student = _findStudentOrNull(studentId);
    if (student != null) {
      throw Exception('Student $student already exists');
    }

    students.add(Student(id: studentId, name: studentName));
  }
 
 
  void removeStudent({required String studentId}) {
    Student? student = _findStudentOrNull(studentId);
    if (student == null) {
      throw Exception('Student $studentId not found');
    }
    // 1- Remove student from the students list
    students.removeWhere((student) => student.id == studentId);
 
  }

  Student? _findStudentOrNull(String studentId) {
    for (Student s in students) {
      if (s.id == studentId) {
        return s;
      }
    }
    return null; // not found
  }



  void addCourse({required String courseId,required String courseName}){
    if(_findCourseOrNull(courseId) != null){
      throw Exception("The courseID ${courseId} already exists>.");
    }
    courses.add(Course(id: courseId, name: courseName));
  }

  void removeCourse({required String courseId}){
    if(_findCourseOrNull(courseId) == null){
      throw Exception("The courseID ${courseId} not found>.");
    }

    final hasEnrollment = enrollments.any((e)=>e.courseId == courseId);
    final hasResult = results.any((e)=>e.courseId == courseId);
    
    if(hasEnrollment || hasResult){
      throw Exception("cannot remove course that has studdent enroll or result>.");
    }
    courses.removeWhere((c)=>c.id==courseId);

  }
  
  Course? _findCourseOrNull(String courseId){
    for(var course in courses){
      if(course.id==courseId){
        return course;
      }
    }
      return null;
  }

  void enrollStudent({required String studentId,required String courseId}) {
    if(_findStudentOrNull(studentId)== null){
      throw Exception("The Student ID ${studentId} is not found>.");
    }

    if(_findCourseOrNull(courseId)== null){
      throw Exception("The Course is not found>.");
    }

    final hasEnrollment = enrollments.any((e)=> e.studentId == studentId && e.courseId == studentId);
    if(hasEnrollment){
        throw Exception("Student already Enroll>.");
    }

    enrollments.add(Enrollment(studentId: studentId, courseId: courseId));   
  }

  void discardStudentFromCourse({required String studentId,required String courseId}) {
    if(_findCourseOrNull(courseId) == null){
      throw Exception("The student is not exist>.");
    }

    if(_findStudentOrNull(studentId) == null){
      throw Exception("The course is not exist>.");
    }

    final hasEnrolled = enrollments.any((e)=> e.courseId == courseId && e.studentId == studentId);
    if(!hasEnrolled){
      throw Exception("Enroll not found>.");
    }

    final hasResult = results.any((r)=> r.courseId == courseId && r.studentId == studentId);
    if(hasResult){
      throw Exception("Need to remove the score before discard Student from course>.");
    }

    enrollments.removeWhere((e)=>e.courseId == courseId && e.studentId == studentId);
  }


  void addResult({required String resultId,required String studentId,required String courseId,required double score}) {
    if(_findCourseOrNull(courseId) == null){
      throw Exception("The student is not exist>.");
    }

    if(_findStudentOrNull(studentId) == null){
      throw Exception("The course is not exist>.");
    }

    final hasEnrolled = enrollments.any((e)=> e.courseId == courseId && e.studentId == studentId);
    if(!hasEnrolled){
      throw Exception("Enroll not found>.");
    }

    if(score< 0 && score> 100){
      throw Exception("score must be between 0 to 100");
    }

    final hasResult = results.any((r)=> r.courseId == courseId && r.studentId == studentId);
    if(hasResult){
      throw Exception("result already has in this course>.");
    }

    results.add(Result(id:resultId, studentId: studentId, courseId: courseId, score: score));

  }

  void removeResult({ required String resultId}){
    final exist = results.any((e)=> e.id == resultId);
    if(!exist){
      throw Exception("result is not found >.");
    }

    results.removeWhere((e)=> e.id == resultId);
  }

}

