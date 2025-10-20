import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class InfoHome extends StatelessWidget {
  const InfoHome({super.key});

  EdgeInsets _pagePadding(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    double horizontal;
    try {
      final maybe = null;
      if (maybe != null && maybe.base != null) {
        horizontal = maybe.base! * 6;
      } else {
        horizontal = w * 0.06;
      }
    } catch (_) {
      horizontal = w * 0.06;
    }

    final h = MediaQuery.of(context).size.height;
    final vertical = h * 0.04;
    return EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical);
  }

  BoxDecoration _cardDecoration(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return BoxDecoration(
      color: cs.primaryForeground,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.06),
          blurRadius: 20,
          offset: const Offset(0, 8),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final padding = _pagePadding(context);

    return Scaffold(
      child: SingleChildScrollView(
        child: Column(
          children: [
            // HERO (vibrant gradient)
            LayoutBuilder(builder: (context, constraints) {
              final w = constraints.maxWidth;
              final isNarrow = w < 800;
              final heroHorizontal = EdgeInsets.symmetric(
                horizontal: w * 0.06,
                vertical: MediaQuery.of(context).size.height * 0.08,
              );

              return Container(
                width: double.infinity,
                padding: heroHorizontal,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Theme.of(context).colorScheme.primary,
                      Theme.of(context).colorScheme.secondary,
                    ],
                    stops: const [0.0, 1.0],
                  ),
                ),
                child: Column(
                  crossAxisAlignment:
                  isNarrow ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                  children: [
                    // Big title
                    DefaultTextStyle.merge(
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primaryForeground,
                      ),
                      child: Column(
                        crossAxisAlignment: isNarrow
                            ? CrossAxisAlignment.center
                            : CrossAxisAlignment.start,
                        children: [
                          Text('Vacuum Bunnies').h1,
                          const SizedBox(height: 12),
                          Text('Capture. Combine. Evolve. Build your bunny empire.').h2,
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // tagline + CTA row
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        PrimaryButton(
                          onPressed: () => context.go('/info/bunny-types'),
                          child: const Text('Explore Bunny Types'),
                        ),
                        const SizedBox(width: 12),
                        Button.outline(
                          onPressed: () => context.go('/info/about'),
                          child: const Text('Learn More'),
                        ),
                      ],
                    ),

                    const SizedBox(height: 28),

                    // mini features row (responsive)
                    Wrap(
                      spacing: 16,
                      runSpacing: 12,
                      alignment: isNarrow ? WrapAlignment.center : WrapAlignment.start,
                      children: [
                        _featureChip(
                          context,
                          icon: Icons.wind_power,
                          title: 'Collect',
                          subtitle: 'Catch colorful bunnies with your vacuum.',
                        ),
                        _featureChip(
                          context,
                          icon: Icons.auto_awesome,
                          title: 'Combine',
                          subtitle: 'Fuse bunnies to unlock rare evolutions.',
                        ),
                        _featureChip(
                          context,
                          icon: Icons.emoji_events,
                          title: 'Compete',
                          subtitle: 'Show off your empire and climb leaderboards.',
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),

            // GAME DESCRIPTION + SAMPLE BUNNIES
            Container(
              width: double.infinity,
              padding: padding,
              color: Theme.of(context).colorScheme.background,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 6),
                  Text('About the Game').h2,
                  const SizedBox(height: 12),
                  Text(
                    'Vacuum Bunnies drops you into a bright, colorful Roblox world where you '
                        'use a vacuum to capture adorable — and sometimes mischievous — bunnies. '
                        'Each bunny has unique traits and rarities. Combine them to evolve new forms, '
                        'discover hidden mechanics, and build a thriving bunny empire.',
                  ),
                  const SizedBox(height: 18),

                  // responsive bunny sample cards (wrap)
                  LayoutBuilder(builder: (context, constraints) {
                    final available = constraints.maxWidth;
                    final crossAxisCount = available > 1000 ? 4 : (available > 700 ? 3 : 2);
                    // We'll simply use a Wrap with sized children to simulate a responsive grid
                    return Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      children: List.generate(6, (i) {
                        final width = (available - (16 * (crossAxisCount - 1))) / crossAxisCount;
                        return SizedBox(
                          width: width.clamp(180.0, 360.0),
                          child: Card(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: MediaQuery.of(context).size.width * 0.03,
                                vertical: MediaQuery.of(context).size.height * 0.02,
                              ),
                              decoration: _cardDecoration(context),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // image placeholder (use your images here)
                                  Container(
                                    height: 110,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      gradient: LinearGradient(
                                        colors: [
                                          Theme.of(context).colorScheme.primary.withOpacity(0.15),
                                          Theme.of(context).colorScheme.secondary.withOpacity(0.12),
                                        ],
                                      ),
                                    ),
                                    child: Center(
                                      child: Text('Bunny ${i + 1}').h3,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    'Bunny ${i + 1}',
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    'Rarity: ${['Common', 'Uncommon', 'Rare', 'Epic', 'Legendary', 'Mythic'][i % 6]}',
                                    style: TextStyle(color: Theme.of(context).colorScheme.secondaryForeground),
                                    // style: Theme.of(context).textTheme.caption,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                    );
                  }),

                  const SizedBox(height: 28),

                  // CTA strip
                  Row(
                    children: [
                      Expanded(
                        child: Card(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: MediaQuery.of(context).size.height * 0.025,
                              horizontal: MediaQuery.of(context).size.width * 0.04,
                            ),
                            decoration: _cardDecoration(context),
                            child: Row(
                              children: [
                                Avatar(
                                  initials: 'VB',
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Start building your empire!').h3,
                                      const SizedBox(height: 6),
                                      Text(
                                        'Catch bunnies today and begin combining them into powerful evolutions.',
                                      ),
                                    ],
                                  ),
                                ),
                                PrimaryButton(
                                  onPressed: () => context.go('/app'),
                                  child: const Text('Play Now'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // AUTHORS / TEAM
            Container(
              width: double.infinity,
              padding: padding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Meet the Creators').h2,
                  const SizedBox(height: 12),
                  Text(
                    'A talented group of developers, artists and designers who built Vacuum Bunnies.',
                  ),
                  const SizedBox(height: 18),

                  Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: const [
                      _AuthorCard(name: 'Grayson Zetic', role: 'Lead Designer'),
                      _AuthorCard(name: 'Amit Gurung', role: 'Lead Engineer'),
                      _AuthorCard(name: 'Cameron Lapp', role: 'Backend'),
                      _AuthorCard(name: 'Ntungwe Nkwelle', role: 'Gameplay'),
                      _AuthorCard(name: 'Matthew Contaldi', role: 'Artist'),
                      _AuthorCard(name: 'Oleg Zenderman', role: 'DevOps'),
                      _AuthorCard(name: 'Samuel Diaz-Amparo', role: 'Producer'),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // FOOTER CTA band (secondary gradient)
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * 0.05,
                horizontal: MediaQuery.of(context).size.width * 0.06,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.secondary,
                    Theme.of(context).colorScheme.sidebarAccent,
                  ],
                ),
              ),
              child: Column(
                children: [
                  Text('Join the vacuuming fun!').h2,
                  const SizedBox(height: 8),
                  Text(
                    'Follow updates, join the community, and be the first to find new evolutions.',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      PrimaryButton(
                        onPressed: () => context.go('/info/authors'),
                        child: const Text('Team'),
                      ),
                      const SizedBox(width: 12),
                      Button.outline(
                        onPressed: () => context.go('/info/about'),
                        child: const Text('About & Roadmap'),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 36),
          ],
        ),
      ),
    );
  }

  // Small reusable feature chip used in hero
  Widget _featureChip(BuildContext context,
      {required IconData icon, required String title, required String subtitle}) {
    return Card(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.02,
          vertical: MediaQuery.of(context).size.height * 0.012,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryForeground,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 28, color: Theme.of(context).colorScheme.primary),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title).h3,
                const SizedBox(height: 2),
                Text(subtitle),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Author card widget
class _AuthorCard extends StatelessWidget {
  final String name;
  final String role;

  const _AuthorCard({required this.name, this.role = '', super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.28 > 280
            ? 280
            : MediaQuery.of(context).size.width * 0.42,
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.03,
          vertical: MediaQuery.of(context).size.height * 0.02,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.sidebarAccent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Avatar(
              initials: name.isNotEmpty ? name[0] : '?',
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name).h3,
                  if (role.isNotEmpty) ...[
                    const SizedBox(height: 6),
                    Text(role),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
