import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pakistan Student Services',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: const Color(0xFFF5F8F6),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // Service card
  Widget serviceCard(
      BuildContext context, String title, IconData icon, Color color) {
    return Expanded(
      child: Card(
        color: Colors.white,
        child: InkWell(
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('$title selected'),
                duration: const Duration(seconds: 2),
              ),
            );
          },
          child: Container(
            height: 105,
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(icon, color: color, size: 30),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Update list item
  Widget updateItem(
      String title, String description, IconData icon, Color color) {
    return Card(
      color: Colors.white,
      child: ListTile(
        leading: Icon(icon, color: color, size: 30),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(description),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: const Color(0xFF087A45),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.school,
                        color: Colors.white,
                        size: 35,
                      ),
                      Icon(
                        Icons.notifications_none,
                        color: Colors.white,
                        size: 28,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Pakistan Student Services',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Welcome back! Your campus essentials are right here.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // Student services heading
            const Text(
              'Student Services',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF18332A),
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              'Everything you need, all in one place',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 12),

            // First row
            Row(
              children: [
                serviceCard(
                  context,
                  'Scholarships',
                  Icons.school,
                  const Color(0xFF087A45),
                ),
                serviceCard(
                  context,
                  'Digital Library',
                  Icons.local_library,
                  Colors.blue,
                ),
              ],
            ),

            // Second row
            Row(
              children: [
                serviceCard(
                  context,
                  'Transport',
                  Icons.directions_bus,
                  Colors.orange,
                ),
                serviceCard(
                  context,
                  'Examinations',
                  Icons.fact_check,
                  Colors.purple,
                ),
              ],
            ),

            // Third row
            Row(
              children: [
                serviceCard(
                  context,
                  'Fee Services',
                  Icons.account_balance_wallet,
                  Colors.teal,
                ),
                serviceCard(
                  context,
                  'Internships',
                  Icons.work,
                  Colors.redAccent,
                ),
              ],
            ),

            const SizedBox(height: 25),

            // Important updates heading
            const Text(
              'Important Updates',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF18332A),
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              'The latest news for your campus life',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 12),

            // Six update items
            updateItem(
              'Scholarship Applications Open',
              'Apply for the need-based scholarship by 30 June.',
              Icons.campaign,
              Colors.green,
            ),

            updateItem(
              'Final Examination Timetable',
              'The updated timetable is now available to view.',
              Icons.event_note,
              Colors.blue,
            ),

            updateItem(
              'Library Hours Extended',
              'Study spaces are open until 10:00 pm this week.',
              Icons.menu_book,
              Colors.purple,
            ),

            updateItem(
              'Transport Pass Renewal',
              'Renew your student bus pass before the new term.',
              Icons.directions_bus,
              Colors.orange,
            ),

            updateItem(
              'Fee Payment Reminder',
              'Check your fee statement and payment due date.',
              Icons.payments,
              Colors.teal,
            ),

            updateItem(
              'Internship Opportunities',
              'New summer placements have been added to the portal.',
              Icons.work,
              Colors.redAccent,
            ),
          ],
        ),
      ),
    );
  }
}
