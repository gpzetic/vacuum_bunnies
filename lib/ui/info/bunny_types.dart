import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class InfoBunnyTypes extends StatelessWidget {
  const InfoBunnyTypes({super.key});

  EdgeInsets _pagePadding(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return EdgeInsets.symmetric(
      horizontal: w * 0.06,
      vertical: h * 0.04,
    );
  }

  @override
  Widget build(BuildContext context) {
    final padding = _pagePadding(context);

    final bunnyTypes = [
      {
        'name': 'Grass',
        'emoji': '🌿',
        'theme': [Theme.of(context).colorScheme.primary.withOpacity(0.6), Theme.of(context).colorScheme.secondary.withOpacity(0.3)],
        'description': 'Bunnies that thrive in lush green meadows.'
      },
      {
        'name': 'Mountain',
        'emoji': '⛰️',
        'theme': [Theme.of(context).colorScheme.primary.withOpacity(0.7), Theme.of(context).colorScheme.secondary.withOpacity(0.2)],
        'description': 'Hardy bunnies adapted to high rocky peaks.'
      },
      {
        'name': 'Jungle',
        'emoji': '🌴',
        'theme': [Theme.of(context).colorScheme.secondary.withOpacity(0.6), Theme.of(context).colorScheme.primary.withOpacity(0.3)],
        'description': 'Wild bunnies in dense, mysterious jungles.'
      },
      {
        'name': 'Volcano',
        'emoji': '🌋',
        'theme': [Colors.red.withOpacity(0.6), Colors.orange.withOpacity(0.3)],
        'description': 'Fiery bunnies that live near molten lava flows.'
      },
      {
        'name': 'Water',
        'emoji': '💧',
        'theme': [Colors.blue.withOpacity(0.6), Colors.cyan.withOpacity(0.3)],
        'description': 'Aquatic bunnies that swim and thrive in watery areas.'
      },
      {
        'name': 'Desert',
        'emoji': '🏜️',
        'theme': [Colors.orange.shade300.withOpacity(0.6), Colors.yellow.shade200.withOpacity(0.3)],
        'description': 'Bunnies adapted to hot, arid desert environments.'
      },
      {
        'name': 'Ice',
        'emoji': '❄️',
        'theme': [Colors.cyan.shade200.withOpacity(0.6), Colors.blue.shade100.withOpacity(0.3)],
        'description': 'Cold-loving bunnies that thrive in icy tundras.'
      },
    ];

    return Scaffold(
      child: SingleChildScrollView(
        child: Column(
          children: [
            // HERO SECTION
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * 0.08,
                horizontal: MediaQuery.of(context).size.width * 0.06,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.secondary,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Bunny Types').h1,
                  const SizedBox(height: 12),
                  Text(
                    'Discover all the colorful bunnies you can catch, combine, and evolve in Vacuum Bunnies!',
                  ).h2,
                ],
              ),
            ),

            const SizedBox(height: 40),

            Container(
              width: double.infinity,
              padding: padding,
              child: LayoutBuilder(builder: (context, constraints) {
                final available = constraints.maxWidth;
                final crossAxisCount = available > 1000
                    ? 4
                    : (available > 700 ? 3 : 2);

                return Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: bunnyTypes.map((bunny) {
                    final width =
                        (available - (16 * (crossAxisCount - 1))) /
                            crossAxisCount;
                    return _InteractiveBunnyCard(
                      name: bunny['name'] as String,
                      emoji: bunny['emoji'] as String,
                      description: bunny['description'] as String,
                      themeColors: bunny['theme'] as List<Color>,
                      width: width.clamp(180.0, 320.0),
                      onTap: () {
                        // Navigate to detailed bunny page (placeholder)
                        context.go('/info/bunny-types/${bunny['name']!}');
                      },
                    );
                  }).toList(),
                );
              }),
            ),

            const SizedBox(height: 60),

            // CTA / EXTRA INFO
            Container(
              width: double.infinity,
              padding: padding,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.secondary,
                    Theme.of(context).colorScheme.primary,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Master the Bunny World!').h2,
                  const SizedBox(height: 12),
                  Text(
                    'Catch, combine, and evolve bunnies from all types of environments. Build your empire and discover rare species!',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  PrimaryButton(
                    onPressed: () => context.go('/app'),
                    child: const Text('Play Now'),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class _InteractiveBunnyCard extends StatefulWidget {
  final String name;
  final String emoji;
  final String description;
  final List<Color> themeColors;
  final double width;
  final VoidCallback onTap;

  const _InteractiveBunnyCard({
    required this.name,
    required this.emoji,
    required this.description,
    required this.themeColors,
    required this.width,
    required this.onTap,
    super.key,
  });

  @override
  State<_InteractiveBunnyCard> createState() => _InteractiveBunnyCardState();
}

class _InteractiveBunnyCardState extends State<_InteractiveBunnyCard> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: widget.width,
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.03,
            vertical: MediaQuery.of(context).size.height * 0.02,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: widget.themeColors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: _hovering
                ? [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 24,
                offset: const Offset(0, 12),
              ),
            ]
                : [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          transform: _hovering ? Matrix4.skew(-0.01, 0.01) : Matrix4.identity(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // emoji / bunny placeholder
              Center(
                child: Text(
                  widget.emoji,
                  style: const TextStyle(fontSize: 48),
                ),
              ),
              const SizedBox(height: 12),
              Text(widget.name).h3,
              const SizedBox(height: 8),
              Text(widget.description),
              const SizedBox(height: 12),
              PrimaryButton(
                onPressed: widget.onTap,
                child: const Text('Explore'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
