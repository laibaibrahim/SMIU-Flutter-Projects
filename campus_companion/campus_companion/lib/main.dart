import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final savedDark = prefs.getBool('isDarkMode') ?? false;
  final savedDepartment =
      prefs.getString('department') ?? 'Software Engineering';
  runApp(
    CampusCompanion(
      initialDarkMode: savedDark,
      initialDepartment: savedDepartment,
    ),
  );
}

class CampusCompanion extends StatefulWidget {
  final bool initialDarkMode;
  final String initialDepartment;

  const CampusCompanion({
    super.key,
    required this.initialDarkMode,
    required this.initialDepartment,
  });

  @override
  State<CampusCompanion> createState() => _CampusCompanionState();
}

class _CampusCompanionState extends State<CampusCompanion> {
  late bool isDarkMode = widget.initialDarkMode;

  Future<void> saveDarkMode(bool value) async {
    setState(() => isDarkMode = value);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', value);
  }

  void resetDarkMode() {
    setState(() => isDarkMode = false);
  }

  @override
  Widget build(BuildContext context) {
    const seed = Color(0xFF14522E);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SMIU Campus Companion',
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,

      // LIGHT THEME
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: seed,
          brightness: Brightness.light,
          surface: Colors.white,
        ),
        scaffoldBackgroundColor: const Color(0xFFF1F5F1),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF14522E),
          foregroundColor: Colors.white,
        ),
        switchTheme: SwitchThemeData(
          thumbColor: WidgetStateProperty.resolveWith(
            (s) => s.contains(WidgetState.selected)
                ? Colors.white
                : Colors.grey.shade600,
          ),
          trackColor: WidgetStateProperty.resolveWith(
            (s) => s.contains(WidgetState.selected)
                ? const Color(0xFF14522E)
                : Colors.grey.shade300,
          ),
        ),
      ),

      // DARK THEME
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: seed,
          brightness: Brightness.dark,
          surface: const Color(0xFF24352B),
        ),
        scaffoldBackgroundColor: const Color(0xFF121C16),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1B3928),
          foregroundColor: Colors.white,
        ),
        switchTheme: SwitchThemeData(
          thumbColor: WidgetStateProperty.resolveWith(
            (s) => s.contains(WidgetState.selected)
                ? Colors.white
                : Colors.grey.shade400,
          ),
          trackColor: WidgetStateProperty.resolveWith(
            (s) => s.contains(WidgetState.selected)
                ? const Color(0xFF3FA66B)
                : const Color(0xFF3A4A40),
          ),
        ),
      ),

      home: SettingsScreen(
        isDarkMode: isDarkMode,
        onThemeChanged: saveDarkMode,
        initialDepartment: widget.initialDepartment,
        onCleared: resetDarkMode,
      ),
    );
  }
}

class SettingsScreen extends StatefulWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;
  final String initialDepartment;
  final VoidCallback onCleared;

  const SettingsScreen({
    super.key,
    required this.isDarkMode,
    required this.onThemeChanged,
    required this.initialDepartment,
    required this.onCleared,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final List<String> departments = [
    'Software Engineering',
    'Computer Science',
    'Business Administration',
  ];

  late String selectedDepartment = widget.initialDepartment;

  // Preferred department is saved locally
  Future<void> saveDepartment(String value) async {
    setState(() => selectedDepartment = value);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('department', value);
  }

  Future<void> clearPreferences() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Clear Preferences?'),
        content: const Text(
          'All saved settings will be deleted and reset to default. '
          'Are you sure?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Clear'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      widget.onCleared();
      if (!mounted) return;
      setState(() => selectedDepartment = 'Software Engineering');
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Preferences cleared')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Campus Companion',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'App Settings',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 20),

            // Dark Mode
            Card(
              child: SwitchListTile(
                title: const Text(
                  'Dark Mode',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                subtitle: const Text('Change app appearance'),
                value: widget.isDarkMode,
                onChanged: widget.onThemeChanged,
                secondary: const Icon(Icons.dark_mode),
              ),
            ),
            const SizedBox(height: 10),

            // Department
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.school),
                        SizedBox(width: 12),
                        Text(
                          'Preferred Department',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    DropdownButton<String>(
                      isExpanded: true,
                      value: selectedDepartment,
                      items: departments
                          .map(
                            (d) => DropdownMenuItem(value: d, child: Text(d)),
                          )
                          .toList(),
                      onChanged: (value) {
                        if (value != null) {
                          saveDepartment(value);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Clear Preferences
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: clearPreferences,
                icon: const Icon(Icons.delete),
                label: const Text('Clear Preferences'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: isDark
                      ? const Color(0xFF8C2B2B)
                      : const Color(0xFFB3261E),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.all(14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
