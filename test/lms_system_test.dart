import 'package:test/test.dart';
import '../lib/service/lms_system.dart';

void main() {
  test('creates a student', () {
    final lms = LmsSystem();

    // Create a student
    lms.addStudent(studentId: 'S1', studentName: "ronan");

    expect(lms.students.first.name, 'ronan');

    // Remove the student
    lms.removeStudent(studentId: 'S1');
    expect(lms.students.length, 0);
  });

  test('create course',(){
    final lms = LmsSystem();
    lms.addCourse(courseId: "C1", courseName: "Flutter");
    expect(lms.courses.length, 1);
    expect(lms.courses.first.name, "Flutter");

  });
  test('remove course',(){
    final lms = LmsSystem();
    lms.addCourse(courseId: "C1", courseName: "Flutter");
    lms.removeCourse(courseId: "C1");
    expect(lms.courses.length, 0);

  });
  test('enroll a student in a course',(){
    final lms = LmsSystem();
    lms.addStudent(studentId: 'S1', studentName: 'Ronan');
    lms.addCourse(courseId: 'C1', courseName: 'Dart');

    lms.enrollStudent(studentId: 'S1', courseId: 'C1');

    expect(lms.enrollments.length, 1);
    expect(lms.enrollments.first.studentId, 'S1');
    expect(lms.enrollments.first.courseId, 'C1');

  });
  test('remove a student from enrollment',(){
    final lms = LmsSystem();
    lms.addStudent(studentId: 'S1', studentName: 'Ronan');
    lms.addCourse(courseId: 'C1', courseName: 'Dart');

    lms.enrollStudent(studentId: 'S1', courseId: 'C1');
    lms.discardStudentFromCourse(studentId: 'S1', courseId: 'C1');
  
    expect(lms.enrollments.length, 0);
    expect(lms.students.length, 1);
    expect(lms.courses.length, 1);

  });
  test('add result',(){
    final lms = LmsSystem();
    lms.addStudent(studentId: 'S1', studentName: 'Ronan');
    lms.addCourse(courseId: 'C1', courseName: 'Dart');

    lms.enrollStudent(studentId: 'S1', courseId: 'C1');

    lms.addResult(resultId: 'R1', studentId: 'S1', courseId: 'C1', score: 90);
    expect(lms.results.length, 1);
    expect(lms.results.first.score, 90);

  });
  test('remove result',(){
    final lms = LmsSystem();
    lms.addStudent(studentId: 'S1', studentName: 'Ronan');
    lms.addCourse(courseId: 'C1', courseName: 'Dart');

    lms.enrollStudent(studentId: 'S1', courseId: 'C1');

    lms.addResult(resultId: 'R1', studentId: 'S1', courseId: 'C1', score: 90);

    lms.removeResult(resultId: 'R1');
    expect(lms.results.length, 0);
    expect(lms.students.length, 1);
    expect(lms.courses.length, 1);
    expect(lms.enrollments.length, 1);
  });

 }
