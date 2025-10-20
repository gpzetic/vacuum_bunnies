// lib/ui/info/about.dart
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class InfoAbout extends StatelessWidget {
  const InfoAbout({super.key});

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
                  Text('About Vacuum Bunnies').h1,
                  const SizedBox(height: 16),
                  Text(
                    'Dive into the colorful, vibrant world where bunnies meet strategy, creativity, and fun!',
                  ).h2,
                ],
              ),
            ),

            const SizedBox(height: 40),

            // GAME STORY
            Container(
              width: double.infinity,
              padding: padding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Our Story').h2,
                  const SizedBox(height: 12),
                  Text(
                    'Vacuum Bunnies began as a small idea: create a playful and colorful virtual world where players could explore, catch bunnies, and evolve them. Our goal was to combine the joy of collecting with strategic gameplay, encouraging players to grow their bunny empire and interact with the community.',
                  ),
                  const SizedBox(height: 24),
                  Text('The World of Vacuum Bunnies').h3,
                  const SizedBox(height: 8),
                  Text(
                    'The game is set in a vibrant universe with diverse environments: grasslands, mountains, jungles, volcanoes, deserts, water regions, and icy tundras. Each environment hosts unique bunny species that players can catch, evolve, and combine to discover rare variations.',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // GAMEPLAY
            Container(
              width: double.infinity,
              padding: padding,
              color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Gameplay').h2,
                  const SizedBox(height: 12),
                  Text(
                    'Players start with a basic vacuum and explore different environments to capture bunnies. Once caught, bunnies can be combined or evolved to unlock more powerful or rare forms. As players progress, they can expand their bunny empire, decorate habitats, and compete in community events.',
                  ),
                  const SizedBox(height: 24),
                  Text('Features').h3,
                  const SizedBox(height: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('• Explore unique environments and ecosystems.'),
                      Text('• Catch, combine, and evolve bunnies.'),
                      Text('• Unlock rare bunnies and discover hidden species.'),
                      Text('• Compete in seasonal events and challenges.'),
                      Text('• Build and customize your bunny empire.'),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // DEVELOPMENT TEAM / MISSION
            Container(
              width: double.infinity,
              padding: padding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Our Mission').h2,
                  const SizedBox(height: 12),
                  Text(
                    'We aim to create a joyful, creative, and engaging environment for players of all ages. Our mission is to combine beautiful, vibrant art with playful mechanics and a strong community focus. Players should feel rewarded for exploration, creativity, and collaboration.',
                  ),
                  const SizedBox(height: 24),
                  Text('Meet the Team').h3,
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: const [
                      _TeamMember(name: 'Grayson Zetic', role: 'Lead Designer'),
                      _TeamMember(name: 'Amit Gurung', role: 'Lead Engineer'),
                      _TeamMember(name: 'Cameron Lapp', role: 'Backend'),
                      _TeamMember(name: 'Ntungwe Nkwelle', role: 'Gameplay'),
                      _TeamMember(name: 'Matthew Contaldi', role: 'Artist'),
                      _TeamMember(name: 'Oleg Zenderman', role: 'DevOps'),
                      _TeamMember(name: 'Samuel Diaz-Amparo', role: 'Producer'),
                    ],
                  ),
                ],
              ),
            ),


            const SizedBox(height: 60),

            // CTA / FINAL
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
                  Text('Start Your Adventure Today!').h2,
                  const SizedBox(height: 12),
                  Text(
                    'Dive into the vibrant world of Vacuum Bunnies and start catching, evolving, and building your bunny empire now!',
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

// TEAM MEMBER CARD
class _TeamMember extends StatelessWidget {
  final String name;
  final String role;

  const _TeamMember({required this.name, required this.role, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.03,
          vertical: MediaQuery.of(context).size.height * 0.02,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Avatar(
              initials: name.isNotEmpty ? name[0] : '?',
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name).h3,
                const SizedBox(height: 4),
                Text(role),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
