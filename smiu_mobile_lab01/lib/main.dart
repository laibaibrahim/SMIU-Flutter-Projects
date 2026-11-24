import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SMIU Student Card',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),
      home: const StudentCard(),
    );
  }
}

class StudentCard extends StatefulWidget {
  const StudentCard({super.key});

  @override
  State<StudentCard> createState() => _StudentCardState();
}

class _StudentCardState extends State<StudentCard> {
  String message = 'Welcome to my Student Card!';

  void showMessage() {
    setState(() {
      message = 'Hello! I am a SE Student.';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SMIU Student Card'),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.all(20),
          elevation: 8,
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'SMIU STUDENT CARD',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 25),

                const Text(
                  'Name: Laiba Ibrahim',
                  style: TextStyle(fontSize: 18),
                ),

                const SizedBox(height: 10),

                const Text(
                  'Student ID: BSE-24S-065',
                  style: TextStyle(fontSize: 18),
                ),

                const SizedBox(height: 10),

                const Text(
                  'Department: SE',
                  style: TextStyle(fontSize: 18),
                ),

                const SizedBox(height: 10),

                const Text(
                  'Semester: 6th',
                  style: TextStyle(fontSize: 18),
                ),

                const SizedBox(height: 10),

                const Text(
                  'Skill: Web Development',
                  style: TextStyle(fontSize: 18),
                ),

                const SizedBox(height: 25),

                ElevatedButton(
                  onPressed: showMessage,
                  child: const Text('Click Me'),
                ),

                const SizedBox(height: 15),

                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
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

