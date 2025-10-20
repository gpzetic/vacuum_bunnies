import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:flutter/widgets.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  final List<Map<String, dynamic>> _players = const [
    {'name': 'FluffyMaster', 'points': 2500, 'emoji': '🐇'},
    {'name': 'BunnyHunter', 'points': 2200, 'emoji': '🐰'},
    {'name': 'CarrotKing', 'points': 2000, 'emoji': '🥕'},
    {'name': 'Hoppy', 'points': 1800, 'emoji': '🐇'},
    {'name': 'Velvet', 'points': 1600, 'emoji': '🐰'},
    {'name': 'Snowball', 'points': 1500, 'emoji': '❄️'},
    {'name': 'Cottontail', 'points': 1400, 'emoji': '🐇'},
    {'name': 'Thumper', 'points': 1300, 'emoji': '🐰'},
    {'name': 'Caramel', 'points': 1200, 'emoji': '🐇'},
    {'name': 'BunBun', 'points': 1100, 'emoji': '🐰'},
  ];

  Color _getTopColor(int index) {
    switch (index) {
      case 0:
        return const Color(0xFFFFD700);
      case 1:
        return const Color(0xFFC0C0C0);
      case 2:
        return const Color(0xFFCD7F32);
      default:
        return const Color(0xFFF5F5F5);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Hero / Title
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
                  Text('Leaderboard').h1.modify,
                  const SizedBox(height: 12),
                  const SizedBox(height: 40),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.06),
                    child: Column(
                      children: List.generate(3, (index) {
                        final player = _players[index];
                        return Card(
                          fillColor: Colors.black,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: MediaQuery.of(context).size.height * 0.02,
                              horizontal: MediaQuery.of(context).size.width * 0.04,
                            ),
                            decoration: BoxDecoration(
                              color: _getTopColor(index),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              children: [
                                Avatar(
                                  initials: player['emoji'],
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Text(
                                    player['name'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Text(
                                  '${player['points']} pts',
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ).gap(20),
                  ),

                  const SizedBox(height: 30),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.06),
                    child: Column(
                      children: List.generate(_players.length - 3, (i) {
                        final player = _players[i + 3];
                        return Card(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: MediaQuery.of(context).size.height * 0.015,
                              horizontal: MediaQuery.of(context).size.width * 0.04,
                            ),
                            child: Row(
                              children: [
                                Avatar(
                                  initials: player['emoji'],
                                ),
                                const SizedBox(width: 16),
                                Expanded(child: Text(player['name'])),
                                Text('${player['points']} pts'),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  ),

                  const SizedBox(height: 60),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
