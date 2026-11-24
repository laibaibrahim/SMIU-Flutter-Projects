import 'package:flutter/material.dart';

void main() {
  runApp(const CampusApp());
}

class CampusApp extends StatelessWidget {
  const CampusApp({super.key});

  @override
  Widget build(BuildContext context) {
    const primary = Color.fromARGB(255, 5, 86, 98);

    return MaterialApp(
      title: 'Campus App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primary,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF7F9FC),
        appBarTheme: const AppBarTheme(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
          titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primary,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        cardTheme: CardThemeData(
          elevation: 1,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        iconTheme: const IconThemeData(color: primary),
      ),
      home: const HomeScreen(),
    );
  }
}

//  HOME SCREEN 

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Fee status: false = Pending, true = Paid
  bool feePaid = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 30),
            const Icon(Icons.account_balance_rounded, size: 60),
            const SizedBox(height: 22),
            const Text(
              'SMIU Campus App',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(255, 27, 42, 65),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Welcome to the SMIU Campus Application.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Color.fromARGB(255, 80, 80, 80),
              ),
            ),
            const SizedBox(height: 32),

            // Card 1: Student Profile
            Card(
              child: ListTile(
                leading: const Icon(Icons.person_rounded),
                title: const Text('Student Profile'),
                subtitle: const Text('View student information'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () async {
                  debugPrint('Opening Profile (push)');
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      settings: const RouteSettings(name: 'Student Profile'),
                      builder: (context) => const StudentProfileScreen(
                        name: 'Laiba Ibrahim',
                        department: 'Software Engineering',
                      ),
                    ),
                  );
                  debugPrint('Back on Home (Profile popped)');
                },
              ),
            ),

            // Card 2: Campus Notices
            Card(
              child: ListTile(
                leading: const Icon(Icons.campaign_rounded),
                title: const Text('Campus Notices'),
                subtitle: const Text('Read latest notices'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () async {
                  debugPrint('Opening Notices (push)');
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      settings: const RouteSettings(name: 'Notice List'),
                      builder: (context) => const NoticeScreen(),
                    ),
                  );
                  debugPrint('Back on Home (Notices popped)');
                },
              ),
            ),

            // Card 3: Fee Details
            Card(
              child: ListTile(
                leading: const Icon(Icons.payments_rounded),
                title: const Text('Fee Details'),
                subtitle: Text(
                  feePaid ? 'Status: Paid' : 'Status: Pending',
                  style: TextStyle(
                    color: feePaid ? Colors.green : Colors.orange,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing: feePaid
                    ? const Icon(Icons.check_circle, color: Colors.green)
                    : const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () async {
                  debugPrint('Opening Fee Details (push)');
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      settings: const RouteSettings(name: 'Fee Details'),
                      builder: (context) => FeeDetailsScreen(
                        studentName: 'Laiba Ibrahim',
                        feeAmount: 45000,
                        isPaid: feePaid,
                      ),
                    ),
                  );
                  debugPrint('Fee result received: $result');

                  if (result == true) {
                    setState(() {
                      feePaid = true;
                    });
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
//STUDENT PROFILE SCREEN

class StudentProfileScreen extends StatelessWidget {
  final String name;
  final String department;

  const StudentProfileScreen({
    super.key,
    required this.name,
    required this.department,
  });

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return Scaffold(
      appBar: AppBar(title: const Text('Student Profile')),
      body: Column(
        children: [
          const SizedBox(height: 32),

          // Avatar and name
          CircleAvatar(
            radius: 46,
            backgroundColor: primary.withOpacity(0.12),
            child: const Icon(Icons.person_rounded, size: 56),
          ),
          const SizedBox(height: 16),
          Text(
            name,
            style: const TextStyle(
              color: Color.fromARGB(255, 27, 42, 65),
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Student',
            style: TextStyle(color: Colors.black54, fontSize: 14),
          ),

          const SizedBox(height: 28),

          // Details card
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Card(
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8,
                ),
                leading: const Icon(Icons.apartment_rounded, size: 30),
                title: const Text(
                  'Department',
                  style: TextStyle(fontSize: 13, color: Colors.black54),
                ),
                subtitle: Text(
                  department,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),

      // Back to Home button
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                debugPrint('Profile route popped');
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back),
              label: const Text('Back to Home'),
            ),
          ),
        ),
      ),
    );
  }
}

//CAMPUS NOTICE SCREEN

class NoticeScreen extends StatefulWidget {
  const NoticeScreen({super.key});

  @override
  State<NoticeScreen> createState() => _NoticeScreenState();
}

class _NoticeScreenState extends State<NoticeScreen> {
  // Sample notices (icon, message and read status included)
  final List<Map<String, dynamic>> notices = [
    {
      'title': 'Mid Term Exam Schedule',
      'category': 'Exams',
      'icon': Icons.edit_note_rounded,
      'message': 'Mid term exams will start from 15th December. Students are advised to collect their roll number slips from the examination office and report 15 minutes before the exam time.',
      'isRead': false,
    },
    {
      'title': 'Fee Submission Deadline',
      'category': 'Fees',
      'icon': Icons.payments_rounded,
      'message': 'The last date for fee submission is 30th November. Students who fail to submit their fee before the deadline will have to pay a late fee fine.',
      'isRead': false,
    },
    {
      'title': 'Sports Week Registration',
      'category': 'Events',
      'icon': Icons.emoji_events_rounded,
      'message': 'Registration for Sports Week is now open. Interested students can register at the sports office till 20th November. Cricket, football and badminton events will be held.',
      'isRead': false,
    },
    {
      'title': 'Library Timing Update',
      'category': 'General',
      'icon': Icons.menu_book_rounded,
      'message': 'From next week, the library will remain open from 8:00 AM to 6:00 PM on all working days. The library will stay closed on Sundays.',
      'isRead': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Campus Notices')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: notices.length,
        itemBuilder: (context, index) {
          final notice = notices[index];
          final bool isRead = notice['isRead'];

          return Card(
            child: ListTile(
              leading: Icon(notice['icon']),
              title: Text(notice['title']),
              subtitle: Text(
                isRead ? '${notice['category']}  •  Read' : notice['category'],
              ),
              trailing: isRead
                  ? const Icon(
                      Icons.check_circle,
                      color: Color.fromARGB(255, 2, 191, 191),
                    )
                  : const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () async {
                debugPrint('Opening notice: ${notice['title']}');

                // Wait for the result returned by the detail screen
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NoticeDetailScreen(
                      title: notice['title'],
                      category: notice['category'],
                      icon: notice['icon'],
                      message: notice['message'],
                    ),
                  ),
                );

                debugPrint('Result received: $result');

                // If user marked it as read, update the list
                if (result == true) {
                  setState(() {
                    notices[index]['isRead'] = true;
                  });
                }
              },
            ),
          );
        },
      ),

      // Back to Home button
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                debugPrint('Notice route popped');
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back),
              label: const Text('Back to Home'),
            ),
          ),
        ),
      ),
    );
  }
}

//NOTICE DETAIL SCREEN

class NoticeDetailScreen extends StatelessWidget {
  final String title;
  final String category;
  final IconData icon;
  final String message;

  const NoticeDetailScreen({
    super.key,
    required this.title,
    required this.category,
    required this.icon,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return Scaffold(
      appBar: AppBar(title: const Text('Notice Detail')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 24),
            CircleAvatar(
              radius: 40,
              backgroundColor: primary.withOpacity(0.12),
              child: Icon(icon, size: 44),
            ),
            const SizedBox(height: 20),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color.fromARGB(255, 27, 42, 65),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),

            // Category card
            Card(
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8,
                ),
                leading: Icon(icon, size: 30),
                title: const Text(
                  'Category',
                  style: TextStyle(fontSize: 13, color: Colors.black54),
                ),
                subtitle: Text(
                  category,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Notice message card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Notice',
                      style: TextStyle(fontSize: 13, color: Colors.black54),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      message,
                      style: const TextStyle(
                        fontSize: 16,
                        height: 1.5,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // Bottom buttons
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Mark as Read
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    debugPrint('Marked as read, returning true');
                    Navigator.pop(context, true);
                  },
                  icon: const Icon(Icons.done_all),
                  label: const Text('Mark as Read'),
                ),
              ),
              const SizedBox(height: 10),

              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    debugPrint('Notice detail route popped (no result)');
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Back to Notices'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
//FEE DETAILS SCREEN

class FeeDetailsScreen extends StatelessWidget {
  final String studentName;
  final int feeAmount;
  final bool isPaid;

  const FeeDetailsScreen({
    super.key,
    required this.studentName,
    required this.feeAmount,
    required this.isPaid,
  });

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    final statusColor = isPaid
        ? Colors.green
        : const Color.fromARGB(255, 234, 73, 25);

    return Scaffold(
      appBar: AppBar(title: const Text('Fee Details')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 32),

            // Icon and student name
            CircleAvatar(
              radius: 46,
              backgroundColor: primary.withOpacity(0.12),
              child: const Icon(Icons.payments_rounded, size: 52),
            ),
            const SizedBox(height: 16),
            Text(
              studentName,
              style: const TextStyle(
                color: Color.fromARGB(255, 27, 42, 65),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Student',
              style: TextStyle(color: Colors.black54, fontSize: 14),
            ),

            const SizedBox(height: 28),

            // Fee amount card
            Card(
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8,
                ),
                leading: const Icon(
                  Icons.account_balance_wallet_rounded,
                  size: 30,
                ),
                title: const Text(
                  'Fee Amount',
                  style: TextStyle(fontSize: 13, color: Colors.black54),
                ),
                subtitle: Text(
                  'Rs. $feeAmount',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Fee status card (Pending / Paid)
            Card(
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8,
                ),
                leading: Icon(
                  isPaid ? Icons.check_circle : Icons.hourglass_top_rounded,
                  size: 30,
                  color: statusColor,
                ),
                title: const Text(
                  'Status',
                  style: TextStyle(fontSize: 13, color: Colors.black54),
                ),
                subtitle: Text(
                  isPaid ? 'Paid' : 'Pending',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: statusColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      // Bottom buttons (fixed at bottom)
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Submit Fee: only shown while fee is pending
              if (!isPaid) ...[
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      debugPrint('Fee submitted, returning true');
                      Navigator.pop(context, true);
                    },
                    icon: const Icon(Icons.send_rounded),
                    label: const Text('Submit Fee'),
                  ),
                ),
                const SizedBox(height: 10),
              ],
              // Back to Home
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    debugPrint('Fee Details route popped');
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Back to Home'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
