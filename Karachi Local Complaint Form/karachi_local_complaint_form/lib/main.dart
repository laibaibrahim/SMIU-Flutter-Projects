
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
      title: 'Karachi Complaint Form',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 11, 49, 31),
        ),
        useMaterial3: true,
      ),
      home: const ComplaintScreen(),
    );
  }
}

class ComplaintScreen extends StatefulWidget {
  const ComplaintScreen({super.key});

  @override
  State<ComplaintScreen> createState() =>
      _ComplaintScreenState();
}

class _ComplaintScreenState extends State<ComplaintScreen> {
  final _formKey = GlobalKey<FormState>();

  String? selectedComplaint;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F7F4),

      appBar: AppBar(
        title: const Text(
          'Karachi Complaints',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 11, 49, 31),
        foregroundColor: Colors.white,
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Report a Local Issue',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 11, 49, 31),
                ),
              ),

              const SizedBox(height: 6),

              const Text(
                'Fill in the details to report a problem in your area.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),

              const SizedBox(height: 22),

              Card(
                color: Colors.white,
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Your Information',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 18),

                      // Name
                      const Text('Full Name'),
                      const SizedBox(height: 7),
                      TextFormField(
                        decoration: _decoration(
                          'Enter your full name',
                          Icons.person_outline,
                        ),
                        validator: (value) {
                          if (value == null ||
                              value.trim().isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 16),

                      // Email
                      const Text('Email Address'),
                      const SizedBox(height: 7),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: _decoration(
                          'Enter your email',
                          Icons.email_outlined,
                        ),
                        validator: (value) {
                          if (value == null ||
                              value.trim().isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!RegExp(
                            r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
                          ).hasMatch(value.trim())) {
                            return 'Enter a valid email address';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 16),

                      // Address
                      const Text('Address / Area'),
                      const SizedBox(height: 7),
                      TextFormField(
                        decoration: _decoration(
                          'e.g. Gulshan-e-Iqbal, Karachi',
                          Icons.location_on_outlined,
                        ),
                        validator: (value) {
                          if (value == null ||
                              value.trim().isEmpty) {
                            return 'Please enter your address';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 16),

                      // Phone Number
                      const Text('Phone Number'),
                      const SizedBox(height: 7),
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        decoration: _decoration(
                          'Enter your 11-digit phone number',
                          Icons.phone_outlined,
                        ),
                        validator: (value) {
                          if (value == null ||
                              value.trim().isEmpty) {
                            return 'Please enter your phone number';
                          }
                          if (!RegExp(r'^[0-9]{11}$')
                              .hasMatch(value.trim())) {
                            return 'Enter an 11-digit phone number';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 22),

                      const Text(
                        'Complaint Details',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Complaint Dropdown
                      const Text('Complaint Type'),
                      const SizedBox(height: 7),
                      DropdownButtonFormField<String>(
                        initialValue: selectedComplaint,
                        isExpanded: true,
                        decoration: _decoration(
                          'Select complaint type',
                          Icons.report_problem_outlined,
                        ),
                        items: const [
                          DropdownMenuItem(
                            value: 'Street-light',
                            child: Text('Street-light'),
                          ),
                          DropdownMenuItem(
                            value: 'Garbage',
                            child: Text('Garbage'),
                          ),
                          DropdownMenuItem(
                            value: 'Water',
                            child: Text('Water'),
                          ),
                          DropdownMenuItem(
                            value: 'Road Issue',
                            child: Text('Road Issue'),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            selectedComplaint = value;
                          });
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Please select a complaint type';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 24),

                      // Submit Button
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.send),
                          label: const Text(
                            'Submit Complaint',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 11, 49, 31),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!
                                .validate()) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Complaint submitted successfully!',
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              const Center(
                child: Text(
                  'Helping make Karachi a better place.',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _decoration(
    String hint,
    IconData icon,
  ) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(
        icon,
        color: const Color.fromARGB(255, 11, 49, 31),
      ),
      filled: true,
      fillColor: const Color.fromARGB(255, 247, 250, 248),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 14,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: Color.fromARGB(255, 220, 229, 222),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: Color.fromARGB(255, 11, 49, 31),
          width: 1.5,
        ),
      ),
    );
  }
}
