// lib/ui/info/authors.dart
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class InfoAuthors extends StatelessWidget {
  const InfoAuthors({super.key});

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

    final authors = const [
      {'name': 'Grayson Zetic', 'role': 'Lead Designer'},
      {'name': 'Amit Gurung', 'role': 'Lead Engineer'},
      {'name': 'Cameron Lapp', 'role': 'Backend'},
      {'name': 'Ntungwe Nkwelle', 'role': 'Gameplay'},
      {'name': 'Matthew Contaldi', 'role': 'Artist'},
      {'name': 'Oleg Zenderman', 'role': 'DevOps'},
      {'name': 'Samuel Diaz-Amparo', 'role': 'Producer'},
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
                  Text('Meet the Creators').h1,
                  const SizedBox(height: 12),
                  Text(
                    'The talented team behind Vacuum Bunnies, bringing the colorful world to life.',
                  ).h2,
                ],
              ),
            ),

            const SizedBox(height: 40),

            // AUTHORS GRID / CARDS
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
                  children: authors.map((author) {
                    final width =
                        (available - (16 * (crossAxisCount - 1))) /
                            crossAxisCount;
                    return SizedBox(
                      width: width.clamp(180.0, 320.0),
                      child: _AuthorCard(
                        name: author['name']!,
                        role: author['role']!,
                      ),
                    );
                  }).toList(),
                );
              }),
            ),

            const SizedBox(height: 60),

            // ABOUT TEAM / CTA SECTION
            Container(
              width: double.infinity,
              padding: padding,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.secondary,
                    Theme.of(context).colorScheme.primaryForeground,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Want to join the team?').h2,
                  const SizedBox(height: 12),
                  Text(
                    'We are always looking for creative developers and artists to expand the world of Vacuum Bunnies!',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  PrimaryButton(
                    onPressed: () {
                      context.go('/info/about');
                    },
                    child: const Text('Learn More'),
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

// AUTHOR CARD
class _AuthorCard extends StatelessWidget {
  final String name;
  final String role;

  const _AuthorCard({required this.name, required this.role, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.03,
          vertical: MediaQuery.of(context).size.height * 0.02,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
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
                  const SizedBox(height: 4),
                  Text(role),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
