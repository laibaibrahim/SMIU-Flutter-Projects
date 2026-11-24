
import 'package:flutter/material.dart';

void main() {
  runApp(const CampusServicesApp());
}

class CampusServicesApp extends StatelessWidget {
  const CampusServicesApp({super.key});

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xFF8B1E3F);

    return MaterialApp(
      title: 'Campus Services',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primary,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFFAF5F6),
        appBarTheme: const AppBarTheme(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.white),
          actionsIconTheme: IconThemeData(color: Colors.white),
          centerTitle: true,
          elevation: 0,
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
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
      home: const CampusServicesScreen(),
    );
  }
}

//SERVICE DATA 

class Service {
  final String title;
  final String subtitle;
  final IconData icon;

  const Service({
    required this.title,
    required this.subtitle,
    required this.icon,
  });
}

const List<Service> services = [
  Service(
    title: 'Library',
    subtitle: 'Books and study rooms',
    icon: Icons.local_library_rounded,
  ),
  Service(
    title: 'Timetable',
    subtitle: 'Class schedule',
    icon: Icons.calendar_month_rounded,
  ),
  Service(
    title: 'Fee Portal',
    subtitle: 'Fee status and challan',
    icon: Icons.payments_rounded,
  ),
  Service(
    title: 'Attendance',
    subtitle: 'Track your attendance',
    icon: Icons.fact_check_rounded,
  ),
  Service(
    title: 'Transport',
    subtitle: 'Bus routes and timings',
    icon: Icons.directions_bus_rounded,
  ),
  Service(
    title: 'Results',
    subtitle: 'Exam results',
    icon: Icons.assessment_rounded,
  ),
];

//CAMPUS SERVICES SCREEN 

class CampusServicesScreen extends StatelessWidget {
  const CampusServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // MediaQuery: screen width and orientation
    final double screenWidth = MediaQuery.of(context).size.width;

    final bool isWide = screenWidth >= 600;

    final bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    // Values that change between narrow and wide screens
    final String title = isWide
        ? 'SMIU Campus Services Portal'
        : 'Campus Services';

    final double screenPadding =
        isLandscape ? 16 : (isWide ? 32 : 16);

    final double gridSpacing =
        isLandscape ? 12 : (isWide ? 24 : 14);

    debugPrint(
      'Width: $screenWidth | Wide: $isWide | Landscape: $isLandscape',
    );

    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.apps_rounded),
        title: Text(title),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_rounded),
            onPressed: () {
              debugPrint('Notifications tapped');
            },
          ),
          const SizedBox(width: 4),
        ],
      ),

      // SafeArea for landscape layout
      body: SafeArea(
        top: false,
        bottom: false,
        child: _ServicesGrid(
          padding: screenPadding,
          spacing: gridSpacing,
          isLandscape: isLandscape,
        ),
      ),
    );
  }
}

//SERVICES GRID WIDGET 

class _ServicesGrid extends StatelessWidget {
  final double padding;
  final double spacing;
  final bool isLandscape;

  const _ServicesGrid({
    required this.padding,
    required this.spacing,
    required this.isLandscape,
  });

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return LayoutBuilder(
      builder: (context, constraints) {
        // Decide columns from available width
        final double width = constraints.maxWidth;

        int columns;

        if (width < 600) {
          columns = 2;
        } else if (width < 900) {
          columns = 3;
        } else {
          columns = 4;
        }

        // Calculate flexible card dimensions
        final double cardWidth =
            (width -
                (padding * 2) -
                (spacing * (columns - 1))) / columns;

        final double responsiveAspectRatio =
            (cardWidth / (isLandscape ? 140 : 190))
                .clamp(0.75, 1.35)
                .toDouble();

        // Flexible CircleAvatar radius
        final double avatarRadius =
            (cardWidth * 0.14).clamp(20.0, 26.0).toDouble();

        debugPrint('Width: $width | Columns: $columns');

        return GridView.builder(
          padding: EdgeInsets.all(padding),
          itemCount: services.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            crossAxisSpacing: spacing,
            mainAxisSpacing: spacing,
            childAspectRatio: responsiveAspectRatio,
          ),
          itemBuilder: (context, index) {
            final service = services[index];

            return Card(
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${service.title} selected!'),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        radius: avatarRadius,
                        backgroundColor: primary.withValues(alpha: 0.12),
                        child: Icon(
                          service.icon,
                          size: avatarRadius * 1.08,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        service.title,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 27, 42, 65),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        service.subtitle,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
