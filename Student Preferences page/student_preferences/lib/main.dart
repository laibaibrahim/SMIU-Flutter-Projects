import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Load saved preferences before the app starts
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  runApp(StudentPreferencesApp(prefs: prefs));
}

class StudentPreferencesApp extends StatelessWidget {
  final SharedPreferences prefs;

  const StudentPreferencesApp({super.key, required this.prefs});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student Preferences',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 79, 52, 187),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF4F2FB),
      ),
      home: StudentPreferencesPage(prefs: prefs),
    );
  }
}

class StudentPreferencesPage extends StatefulWidget {
  final SharedPreferences prefs;

  const StudentPreferencesPage({super.key, required this.prefs});

  @override
  State<StudentPreferencesPage> createState() =>
      _StudentPreferencesPageState();
}

class _StudentPreferencesPageState extends State<StudentPreferencesPage> {
  static const String defaultDepartment = 'Software Engineering';
  static const String defaultLanguage = 'English';
  static const bool defaultNotifications = true;

  final List<String> departments = [
    'Software Engineering',
    'Computer Science',
    'Business Administration',
  ];
  final List<String> languages = ['English', 'Urdu', 'Sindhi'];

  // Values currently selected on screen
  late String department;
  late String language;
  late bool notifications;

  // Values currently saved in storage
  late String savedDepartment;
  late String savedLanguage;
  late bool savedNotifications;

  @override
  void initState() {
    super.initState();
    // Load saved values when the page opens
    savedDepartment =
        widget.prefs.getString('stu_department') ?? defaultDepartment;
    savedLanguage = widget.prefs.getString('stu_language') ?? defaultLanguage;
    savedNotifications =
        widget.prefs.getBool('stu_notifications') ?? defaultNotifications;

    if (!departments.contains(savedDepartment)) {
      savedDepartment = defaultDepartment;
    }
    if (!languages.contains(savedLanguage)) {
      savedLanguage = defaultLanguage;
    }

    department = savedDepartment;
    language = savedLanguage;
    notifications = savedNotifications;
  }

  // Save all three preferences
  Future<void> savePreferences() async {
    await widget.prefs.setString('stu_department', department);
    await widget.prefs.setString('stu_language', language);
    await widget.prefs.setBool('stu_notifications', notifications);

    if (!mounted) return;
    setState(() {
      savedDepartment = department;
      savedLanguage = language;
      savedNotifications = notifications;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Preferences saved successfully')),
    );
  }

  // Reset to default values (with confirmation)
  Future<void> resetPreferences() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Reset Preferences?'),
        content: const Text('All saved preferences will be removed.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Reset'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await widget.prefs.clear();
      if (!mounted) return;
      setState(() {
        department = defaultDepartment;
        language = defaultLanguage;
        notifications = defaultNotifications;
        savedDepartment = defaultDepartment;
        savedLanguage = defaultLanguage;
        savedNotifications = defaultNotifications;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preferences reset')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        top: false, // header status bar ke peeche tak rahe
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Gradient header
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(24, 64, 24, 32),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF5B3FD0), Color(0xFF8E6CF0)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(32),
                    bottomRight: Radius.circular(32),
                  ),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.person_pin, color: Colors.white, size: 48),
                    SizedBox(height: 12),
                    Text(
                      'Student Preferences',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Personalize your campus experience',
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Department
                    _sectionCard(
                      icon: Icons.school,
                      title: 'Preferred Department',
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: department,
                        items: departments
                            .map((d) =>
                                DropdownMenuItem(value: d, child: Text(d)))
                            .toList(),
                        onChanged: (v) {
                          if (v != null) setState(() => department = v);
                        },
                      ),
                    ),

                    // Notifications
                    _sectionCard(
                      icon: Icons.notifications_active,
                      title: 'Notifications',
                      child: SwitchListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(notifications ? 'Enabled' : 'Disabled'),
                        subtitle: const Text('Receive campus updates'),
                        value: notifications,
                        onChanged: (v) => setState(() => notifications = v),
                      ),
                    ),

                    // Language
                    _sectionCard(
                      icon: Icons.language,
                      title: 'Language Preference',
                      child: Wrap(
                        spacing: 8,
                        children: languages.map((l) {
                          return ChoiceChip(
                            label: Text(l),
                            selected: language == l,
                            onSelected: (_) => setState(() => language = l),
                          );
                        }).toList(),
                      ),
                    ),

                    const SizedBox(height: 8),

                    // Save button
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        onPressed: savePreferences,
                        icon: const Icon(Icons.save),
                        label: const Text('Save Preferences'),
                        style: FilledButton.styleFrom(
                          padding: const EdgeInsets.all(14),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Reset button
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: resetPreferences,
                        icon: const Icon(Icons.restart_alt),
                        label: const Text('Reset Preferences'),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.all(14),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Saved summary
                    Card(
                      color: scheme.primaryContainer,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Saved Preferences',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: scheme.onPrimaryContainer,
                              ),
                            ),
                            const SizedBox(height: 10),
                            _summaryRow('Department', savedDepartment),
                            _summaryRow(
                              'Notifications',
                              savedNotifications ? 'On' : 'Off',
                            ),
                            _summaryRow('Language', savedLanguage),
                          ],
                        ),
                      ),
                    ),

                    // Neeche extra space taake card cut na ho
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionCard({
    required IconData icon,
    required String title,
    required Widget child,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            child,
          ],
        ),
      ),
    );
  }

  Widget _summaryRow(String label, String value) {
    final color = Theme.of(context).colorScheme.onPrimaryContainer;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: color)),
          Text(
            value,
            style: TextStyle(fontWeight: FontWeight.bold, color: color),
          ),
        ],
      ),
    );
  }
}