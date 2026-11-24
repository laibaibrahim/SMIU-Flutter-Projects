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
      title: 'SMIU Student Registration',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 28, 8, 58),
        ),
      ),
      home: const RegistrationScreen(),
    );
  }
}

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String? selectedDepartment;
  String? selectedSemester;
  bool labDeclaration = false;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3EFF8),

      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.school_outlined, size: 26),
            SizedBox(width: 8),
            Text(
              'SMIU Student Registration',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 28, 8, 58),
        foregroundColor: Colors.white,
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Card(
            color: Colors.white,
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),

            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Text(
                        'Student Registration Form',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 28, 8, 58),
                        ),
                      ),
                    ),

                    const SizedBox(height: 25),

                    const Text('Full Name'),
                    const SizedBox(height: 8),

                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'e.g. Laiba Ibrahim',
                        prefixIcon: Icon(
                          Icons.person_outline,
                          color: Color.fromARGB(255, 28, 8, 58),
                        ),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Full name is required';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 20),

                    const Text('Student ID'),
                    const SizedBox(height: 8),

                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'e.g. BSE-24S-065',
                        prefixIcon: Icon(
                          Icons.badge_outlined,
                          color: Color.fromARGB(255, 28, 8, 58),
                        ),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Student ID is required';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 20),

                    const Text('Email Address'),
                    const SizedBox(height: 8),

                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: 'e.g. laibaibrahim26@gmail.com',
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: Color.fromARGB(255, 28, 8, 58),
                        ),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Email is required';
                        }

                        if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$')
                            .hasMatch(value.trim())) {
                          return 'Please enter a valid email';
                        }

                        return null;
                      },
                    ),

                    const SizedBox(height: 20),

                    // Department Dropdown
                    const Text('Department'),
                    const SizedBox(height: 8),

                    DropdownButtonFormField<String>(
                      initialValue: selectedDepartment,
                      isExpanded: true,
                      decoration: const InputDecoration(
                        hintText: 'Select Department',
                        prefixIcon: Icon(
                          Icons.account_balance_outlined,
                          color: Color.fromARGB(255, 28, 8, 58),
                        ),
                        border: OutlineInputBorder(),
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: 'Software Engineering',
                          child: Text('Software Engineering'),
                        ),
                        DropdownMenuItem(
                          value: 'Computer Science',
                          child: Text('Computer Science'),
                        ),
                        DropdownMenuItem(
                          value: 'Data Science',
                          child: Text('Data Science'),
                        ),
                        DropdownMenuItem(value: 'AI', child: Text('AI')),
                      ],
                      onChanged: (value) {
                        setState(() {
                          selectedDepartment = value;
                        });
                      },
                    ),

                    const SizedBox(height: 20),

                    // Semester Selector
                    const Text('Semester'),
                    const SizedBox(height: 8),

                    DropdownButtonFormField<String>(
                      initialValue: selectedSemester,
                      isExpanded: true,
                      decoration: const InputDecoration(
                        hintText: 'Select Semester',
                        prefixIcon: Icon(
                          Icons.school_outlined,
                          color: Color.fromARGB(255, 28, 8, 58),
                        ),
                        border: OutlineInputBorder(),
                      ),
                      items: List.generate(8, (index) {
                        return DropdownMenuItem<String>(
                          value: 'Semester ${index + 1}',
                          child: Text('Semester ${index + 1}'),
                        );
                      }),
                      onChanged: (value) {
                        setState(() {
                          selectedSemester = value;
                        });
                      },
                    ),

                    const SizedBox(height: 15),

                    // Lab Declaration Checkbox
                    CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      controlAffinity: ListTileControlAffinity.leading,
                      activeColor: const Color.fromARGB(255, 28, 8, 58),
                      title: const Text(
                        'I have read and understood the lab instructions.',
                        style: TextStyle(fontSize: 14),
                      ),
                      value: labDeclaration,
                      onChanged: (value) {
                        setState(() {
                          labDeclaration = value ?? false;
                        });
                      },
                    ),

                    const SizedBox(height: 10),
                    const SizedBox(height: 20),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 28, 8, 58),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.all(15),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Registration successful!'),
                              ),
                            );
                          }
                        },
                        child: const Text(
                          'Submit',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

