import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import 'navigator.dart';

class NavigatorWeb extends StatelessWidget {
  const NavigatorWeb({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    bool isDesktop = MediaQuery.of(context).size.width > 700;
    return Column(
      children: [
        NavigationMenu(
          children: [
            NavigationMenuItem(
              onPressed: () => context.go('/info/'),
              child: const Text('Home'),
            ),
            NavigationMenuItem(
              onPressed: () => context.go('/info/authors'),
              child: const Text('Authors'),
            ),
            NavigationMenuItem(
              onPressed: () => context.go('/info/bunny-types'),
              child: const Text('Bunny Types'),
            ),
            NavigationMenuItem(
              onPressed: () => context.go('/info/about'),
              child: const Text('About'),
            ),
          ],
        ),
        Expanded(child: child),
        isDesktop ? InfoFooter() : Button.secondary(onPressed: () => {context.go('/app')}, child: Row(children: [Icon(Icons.play_arrow_outlined), Text("Play")],)),
        
      ],
    );
  }
}



class InfoFooter extends StatelessWidget {
  const InfoFooter({super.key});

  EdgeInsets _footerPadding(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return EdgeInsets.symmetric(
      horizontal: w * 0.06,
      vertical: h * 0.03,
    );
  }

  @override
  Widget build(BuildContext context) {
    final padding = _footerPadding(context);

    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.8),
            Theme.of(context).colorScheme.secondary.withOpacity(0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Links
          Wrap(
            spacing: 20,
            alignment: WrapAlignment.center,
            children: [
              _FooterLink(label: 'Home', path: '/info'),
              _FooterLink(label: 'Authors', path: '/info/authors'),
              _FooterLink(label: 'Bunny Types', path: '/info/bunny-types'),
              _FooterLink(label: 'About', path: '/info/about'),
            ],
          ),
          const SizedBox(height: 12),

          // Copyright
          Text(
            '© ${DateTime.now().year} Vacuum Bunnies. All rights reserved.',
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondaryForeground,
            ),
          ),
        ],
      ),
    );
  }
}

// Footer Link Widget
class _FooterLink extends StatelessWidget {
  final String label;
  final String path;

  const _FooterLink({required this.label, required this.path, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.go(path),
      child: Text(
        label,
        style: TextStyle(
          color: Theme.of(context).colorScheme.secondaryForeground,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}