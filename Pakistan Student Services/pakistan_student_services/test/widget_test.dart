import 'package:flutter_test/flutter_test.dart';
import 'package:pakistan_student_services/main.dart';

void main() {
  testWidgets('Dashboard shows services and responds to a service tap',
      (WidgetTester tester) async {
    await tester.pumpWidget(const PakistanStudentServicesApp());

    expect(find.text('Pakistan Student Services'), findsOneWidget);
    expect(find.text('Welcome back! Your campus essentials are right here.'),
        findsOneWidget);

    for (final service in [
      'Scholarships',
      'Digital Library',
      'Transport',
      'Examinations',
      'Fee Services',
      'Internships',
    ]) {
      expect(find.text(service), findsOneWidget);
    }

    await tester.tap(find.text('Scholarships'));
    await tester.pump();
    expect(find.text('Scholarships selected'), findsOneWidget);

    for (final update in [
      'Scholarship applications open',
      'Final examination timetable',
      'Library hours extended',
      'Transport pass renewal',
      'Fee payment reminder',
      'Internship opportunities',
    ]) {
      expect(find.text(update), findsOneWidget);
    }
  });
}
