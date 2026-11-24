import 'package:flutter/material.dart';

void main() {
  runApp(const TravelApp());
}

// App colors
const Color kPrimary = Color(0xFF0F5C5C);
const Color kGold = Color(0xFFE0A526);
const Color kBackground = Color(0xFFF6F3EC);
const Color kTextDark = Color(0xFF1B2A41);

class TravelApp extends StatelessWidget {
  const TravelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pakistan Travel Places',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: kPrimary,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: kBackground,
        appBarTheme: const AppBarTheme(
          backgroundColor: kPrimary,
          foregroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.white),
          actionsIconTheme: IconThemeData(color: Colors.white),
          centerTitle: true,
          elevation: 0,
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.4,
            color: Colors.white,
          ),
        ),
        cardTheme: CardThemeData(
          elevation: 2,
          color: Colors.white,
          clipBehavior: Clip.antiAlias,
          shadowColor: Colors.black26,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      home: const TravelPlacesScreen(),
    );
  }
}

//CITY DATA

class City {
  final String name;
  final String province;
  final String famousPlace;
  final String description;
  final String bestTime;
  final IconData icon;
  final Color color;

  const City({
    required this.name,
    required this.province,
    required this.famousPlace,
    required this.description,
    required this.bestTime,
    required this.icon,
    required this.color,
  });

  LinearGradient get gradient => LinearGradient(
    colors: [color, Color.lerp(color, Colors.black, 0.28)!],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

const List<City> cities = [
  City(
    name: 'Karachi',
    province: 'Sindh',
    famousPlace: 'Clifton Beach and Quaid\'s Mausoleum',
    description: 'Karachi is the largest city of Pakistan and its main port. It is known for its sea beaches, busy markets, food streets and the Mazar-e-Quaid.',
    bestTime: 'November to February',
    icon: Icons.beach_access_rounded,
    color: Color(0xFF1E6FA8),
  ),
  City(
    name: 'Lahore',
    province: 'Punjab',
    famousPlace: 'Badshahi Mosque and Lahore Fort',
    description: 'Lahore is the cultural capital of Pakistan. It is famous for Mughal architecture, the old walled city, gardens and traditional food.',
    bestTime: 'October to March',
    icon: Icons.mosque_rounded,
    color: Color(0xFFB5473A),
  ),
  City(
    name: 'Islamabad',
    province: 'Islamabad Capital Territory',
    famousPlace: 'Faisal Mosque and Margalla Hills',
    description: 'Islamabad is the capital of Pakistan. It is a clean, green and planned city at the foot of the Margalla Hills, with parks and hiking trails.',
    bestTime: 'March to May and September to November',
    icon: Icons.landscape_rounded,
    color: Color(0xFF2E7D4F),
  ),
  City(
    name: 'Multan',
    province: 'Punjab',
    famousPlace: 'Shrine of Shah Rukn-e-Alam',
    description: 'Multan is known as the City of Saints. It is famous for its shrines, blue tile work, handicrafts, mangoes and sweet Sohan Halwa.',
    bestTime: 'October to March',
    icon: Icons.temple_buddhist_rounded,
    color: Color(0xFF2C8C99),
  ),
  City(
    name: 'Peshawar',
    province: 'Khyber Pakhtunkhwa',
    famousPlace: 'Qissa Khwani Bazaar and Bala Hisar Fort',
    description: 'Peshawar is one of the oldest living cities in South Asia. It is known for its historic bazaars, museum, fort and traditional food.',
    bestTime: 'October to April',
    icon: Icons.storefront_rounded,
    color: Color(0xFF7B5EA7),
  ),
  City(
    name: 'Quetta',
    province: 'Balochistan',
    famousPlace: 'Hanna Lake and Hazarganji National Park',
    description: 'Quetta is called the Fruit Garden of Pakistan. It is surrounded by mountains and is known for its cool weather, orchards and lakes.',
    bestTime: 'April to October',
    icon: Icons.terrain_rounded,
    color: Color(0xFFC2751A),
  ),
];

//TRAVEL PLACES SCREEN
class TravelPlacesScreen extends StatelessWidget {
  const TravelPlacesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isWide = screenWidth >= 600;

    final String title = isWide ? 'Pakistan Travel Places' : 'Travel Places';

    debugPrint('Width: $screenWidth | Wide: $isWide | Landscape: $isLandscape');

    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.explore_rounded),
        title: Text(title),
        actions: const [Icon(Icons.map_rounded), SizedBox(width: 16)],
      ),
      body: SafeArea(
        top: false,
        bottom: false,
        child: _CityGrid(isLandscape: isLandscape),
      ),
    );
  }
}

// ADAPTIVE GRID

class _CityGrid extends StatelessWidget {
  final bool isLandscape;

  const _CityGrid({required this.isLandscape});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double width = constraints.maxWidth;

        // Columns depend on the available width
        int columns;
        if (width < 600) {
          columns = 2;
        } else if (width < 900) {
          columns = 3;
        } else {
          columns = 4;
        }

        final double padding = isLandscape ? 12 : 16;
        final double bottomInset = MediaQuery.of(context).padding.bottom;
        final double spacing = isLandscape ? 10 : 14;

        // Card height depends on orientation and the text scale,
        final double textScale = MediaQuery.textScalerOf(context).scale(1.0);
        final double scale = textScale < 1 ? 1 : textScale;
        final double cardHeight = (isLandscape ? 116 : 218) * scale;

        debugPrint('Grid width: $width | Columns: $columns');

        return CustomScrollView(
          slivers: [
            if (!isLandscape)
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(padding, padding, padding, 0),
                  child: const _Banner(),
                ),
              ),
            SliverPadding(
              padding: EdgeInsets.fromLTRB(
                padding,
                padding,
                padding,
                padding + bottomInset,
              ),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  (context, index) =>
                      _CityCard(city: cities[index], isLandscape: isLandscape),
                  childCount: cities.length,
                ),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: columns,
                  crossAxisSpacing: spacing,
                  mainAxisSpacing: spacing,
                  mainAxisExtent: cardHeight,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

//BANNER

class _Banner extends StatelessWidget {
  const _Banner();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [kPrimary, Color(0xFF1F8A7A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Discover Pakistan',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Tap a city to see famous places and the best time to visit.',
                  style: TextStyle(color: Colors.white70, fontSize: 13),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: kGold.withValues(alpha: 0.25),
            ),
            child: const Icon(
              Icons.travel_explore_rounded,
              size: 34,
              color: kGold,
            ),
          ),
        ],
      ),
    );
  }
}

//CITY CARD

class _CityCard extends StatelessWidget {
  final City city;
  final bool isLandscape;

  const _CityCard({required this.city, required this.isLandscape});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => _showDetails(context, city),
        child: isLandscape ? _landscapeContent() : _portraitContent(),
      ),
    );
  }

  // Portrait: colored header on top, text below
  Widget _portraitContent() {
    return Column(
      children: [
        Container(
          height: 80,
          width: double.infinity,
          decoration: BoxDecoration(gradient: city.gradient),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                right: -10,
                bottom: -14,
                child: Icon(
                  city.icon,
                  size: 76,
                  color: Colors.white.withValues(alpha: 0.15),
                ),
              ),
              CircleAvatar(
                radius: 26,
                backgroundColor: Colors.white.withValues(alpha: 0.25),
                child: Icon(city.icon, size: 28, color: Colors.white),
              ),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  city.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: kTextDark,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  city.province,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: city.color,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  city.famousPlace,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 12, color: Colors.black54),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Landscape: colored block on the left, text on the right
  Widget _landscapeContent() {
    return Row(
      children: [
        Container(
          width: 84,
          height: double.infinity,
          decoration: BoxDecoration(gradient: city.gradient),
          child: Center(
            child: CircleAvatar(
              radius: 26,
              backgroundColor: Colors.white.withValues(alpha: 0.25),
              child: Icon(city.icon, size: 28, color: Colors.white),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  city.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: kTextDark,
                  ),
                ),
                Text(
                  city.province,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: city.color,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  city.famousPlace,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 12, color: Colors.black54),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// CITY DETAILS

void _showDetails(BuildContext context, City city) {
  debugPrint('Opened details: ${city.name}');

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    constraints: const BoxConstraints(maxWidth: 640),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    clipBehavior: Clip.antiAlias,
    builder: (context) {
      return SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Gradient header
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 20),
                decoration: BoxDecoration(gradient: city.gradient),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white.withValues(alpha: 0.25),
                      child: Icon(city.icon, size: 32, color: Colors.white),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            city.name,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            city.province,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 18, 24, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      city.description,
                      style: const TextStyle(fontSize: 15, height: 1.5),
                    ),
                    const SizedBox(height: 16),
                    _InfoBox(
                      icon: Icons.place_rounded,
                      label: 'Famous places',
                      value: city.famousPlace,
                      color: city.color,
                    ),
                    const SizedBox(height: 10),
                    _InfoBox(
                      icon: Icons.wb_sunny_rounded,
                      label: 'Best time to visit',
                      value: city.bestTime,
                      color: city.color,
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close_rounded),
                        label: const Text('Close'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

class _InfoBox extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _InfoBox({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 22, color: color),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(fontSize: 12, color: Colors.black54),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
