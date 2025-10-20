import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:vacuum_bunnies/models/bunny.dart';
import 'package:vacuum_bunnies/ui/app/home/view_models/home_view_model.dart';
import '../../../../data/services/api/api_client.dart';

class HomeScreen extends StatefulWidget {
  final HomeViewModel viewModel;

  const HomeScreen({super.key, required this.viewModel});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final api = GetIt.instance<ApiClient>();
  late Future<List<Bunny>> _bunniesFuture;

  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, dynamic>> _bunnyTypes = [
    {'name': 'Grass', 'color': 0xFF8BC34A},
    {'name': 'Mountain', 'color': 0xFF795548},
    {'name': 'Jungle', 'color': 0xFF4CAF50},
    {'name': 'Volcano', 'color': 0xFFF44336},
    {'name': 'Water', 'color': 0xFF2196F3},
    {'name': 'Desert', 'color': 0xFFFFC107},
    {'name': 'Ice', 'color': 0xFF00BCD4},
  ];

  final List<String> _featuredItems = ['Booster', 'Rare Bunny', 'Egg', 'Potion', 'Trap'];

  @override
  void initState() {
    super.initState();
    _bunniesFuture = api.fetchBunnies();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      child: SingleChildScrollView(
        child: Column(
          children: [
            // TOP CAROUSEL
            SizedBox(
              height: height * 0.3,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  PageView.builder(
                    controller: _pageController,
                    itemCount: _bunnyTypes.length,
                    onPageChanged: (index) => setState(() => _currentPage = index),
                    itemBuilder: (context, index) {
                      final type = _bunnyTypes[index];
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: width * 0.06, vertical: height * 0.02),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(type['color']).withOpacity(0.8),
                              Color(type['color']).withOpacity(0.5),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: Color(type['color']).withOpacity(0.4),
                              blurRadius: 12,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          type['name'],
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      );
                    },
                  ),
                  Positioned(
                    bottom: height * 0.02,
                    child: SmoothPageIndicator(
                      controller: _pageController,
                      count: _bunnyTypes.length,
                      effect: ExpandingDotsEffect(
                        activeDotColor: Colors.white,
                        dotColor: Color(0xFFFFFF8A),
                        dotHeight: 8,
                        dotWidth: 8,
                        expansionFactor: 3,
                        spacing: 6,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // MIDDLE HORIZONTAL FEATURE LIST
            SizedBox(
              height: height * 0.1,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                itemCount: _featuredItems.length,
                separatorBuilder: (_, __) => SizedBox(width: width * 0.04),
                itemBuilder: (context, index) {
                  return  Container(
                      width: width * 0.28,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Theme.of(context).colorScheme.primary.withOpacity(0.4),
                            Theme.of(context).colorScheme.primary.withOpacity(0.4),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        _featuredItems[index],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),

                  );
                },
              ),
            ),

            const SizedBox(height: 24),

            // FUTUREBUILDER BUNNIES LIST
            Text("Your bunnies").h3
            ,const SizedBox(height: 10,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.05),
              child: FutureBuilder<List<Bunny>>(
                future: _bunniesFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Column(
                      children: List.generate(
                        5,
                            (index) => Padding(
                          padding: EdgeInsets.symmetric(vertical: height * 0.012),
                          child: ShimmerCard(width: width, height: height * 0.08),
                        ),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return api.client.auth.currentUser == null ? Center(child: Text("Please log in to see your bunnies")) : Text('Error loading bunnies: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Text('No bunnies found');
                  }

                  final bunnies = snapshot.data!;
                  // print(bunnies);
                  return Column(
                    children: bunnies.map((bunny) {
                      return Card(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: height * 0.015,
                            horizontal: width * 0.04,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(bunny.type ?? 'Unknown').h3,
                              Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  color: bunny.color   ?? Color(0xFFCCCCCC),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

/// Shimmer/fake loader for bunnies
class ShimmerCard extends StatelessWidget {
  final double width;
  final double height;

  const ShimmerCard({required this.width, required this.height, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
