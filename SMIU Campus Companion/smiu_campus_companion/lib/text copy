import 'package:flutter/material.dart';

void main() {
  runApp(const SmiuCampusApp());
}

class SmiuCampusApp extends StatelessWidget {
  const SmiuCampusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SMIU Campus Companion',
      debugShowCheckedModeBanner: false,

      // TASK 7: Apply a simple and consistent theme
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 20, 82, 46),
        ),
        cardTheme: const CardThemeData(
          elevation: 3,
        ),
      ),

      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SMIU Campus Companion'),
        backgroundColor: const Color.fromARGB(255, 20, 82, 46),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Profile clicked!')),
              );
            },
          ),
        ],
      ),

      // TASK 6: Layout widgets - SafeArea keeps content within the safe screen area,
      // and ListView makes the screen scrollable.
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),

          // TASK 7: Removed const because Library has an onTap callback.
          children: [
            const WelcomeCard(),

            const SizedBox(height: 20),

            const Text(
              'Services',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            // Row + Expanded: cards are in equal width
            Row(
              children: [
                const Expanded(
                  child: ServiceCard(
                    icon: Icons.apartment,
                    label: 'Departments',
                  ),
                ),

                Expanded(
                  child: ServiceCard(
                    icon: Icons.local_library,
                    label: 'Library',

                    // Library card tappable
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Library service is selected!'),
                        ),
                      );
                    },
                  ),
                ),

                const Expanded(
                  child: ServiceCard(
                    icon: Icons.campaign,
                    label: 'Campus Notices',
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            const Text(
              'Latest Updates',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            const Card(
              child: ListTile(
                leading: Icon(
                  Icons.edit_note,
                  color: Color.fromARGB(255, 20, 82, 46),
                ),
                title: Text('Exam Notice'),
                subtitle: Text(
                  'Mid-term exams start from Monday. Check the date sheet.',
                ),
              ),
            ),

            const Card(
              child: ListTile(
                leading: Icon(
                  Icons.access_time,
                  color: Color.fromARGB(255, 20, 82, 46),
                ),
                title: Text('Library Timing'),
                subtitle: Text('Library timings: 8:30 AM to 5:00 PM.'),
              ),
            ),

            const Card(
              child: ListTile(
                leading: Icon(
                  Icons.payments,
                  color: Color.fromARGB(255, 20, 82, 46),
                ),
                title: Text('Fee Reminder'),
                subtitle: Text(
                  'Remember to submit your fee challan before the deadline.',
                ),
              ),
            ),

            const Card(
              child: ListTile(
                leading: Icon(
                  Icons.directions_bus,
                  color: Color.fromARGB(255, 20, 82, 46),
                ),
                title: Text('Transport Update'),
                subtitle: Text('Check the latest university bus schedule.'),
              ),
            ),

            const Card(
              child: ListTile(
                leading: Icon(
                  Icons.event,
                  color: Color.fromARGB(255, 20, 82, 46),
                ),
                title: Text('Campus Event'),
                subtitle: Text(
                  'Attend the upcoming campus seminar and activities.',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WelcomeCard extends StatelessWidget {
  const WelcomeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      color: Color.fromARGB(255, 20, 82, 46),
      elevation: 3,
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.school, color: Colors.white, size: 32),
                SizedBox(width: 10),
                Flexible(
                  child: Text(
                    'Welcome to SMIU',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 12),

            Text(
              'Hello, Laiba Ibrahim! Welcome to your 6th semester at SMIU. '
              'Explore campus services, stay updated with important notices, '
              'and make the most of your university journey!',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white70, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}

class ServiceCard extends StatelessWidget {
  final IconData icon;
  final String label;

  // TASK 7: Optional callback for tapping a service card
  final VoidCallback? onTap;

  const ServiceCard({
    super.key,
    required this.icon,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: SizedBox(
          height: 120,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 6,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  size: 32,
                  color: const Color.fromARGB(255, 20, 82, 46),
                ),

                const SizedBox(height: 8),

                Text(
                  label,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
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
}
