import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class NavigatorVB extends StatelessWidget {
  NavigatorVB({super.key, required this.child});

  final Widget child;



  @override
  Widget build(BuildContext context) {
    bool isDesktop =  MediaQuery.of(context).size.width > 700;
    final navButtons = [
      Button.outline(
        style: ButtonStyle(variance: ButtonVariance.text),
        child: Column(children: [Icon(Icons.home),  !isDesktop ? Text("Home") : SizedBox()]),
        onPressed: () => context.go('/app')
      ),
      Button.outline(
          style: ButtonStyle(variance: ButtonVariance.text),
          child: Column(children: [Icon(Icons.leaderboard),  !isDesktop ? Text("Leaderboard") : SizedBox()]),
          onPressed: () => context.go('/app/leaderboard')
      ),
      Button.outline(
        style: ButtonStyle(variance: ButtonVariance.text),
        child: Column(children: [Icon(Icons.account_circle_rounded), !isDesktop ? Text("Account") : SizedBox()]),
        onPressed: () => context.go('/app/account'),
      ),
      Button.outline(
        style: ButtonStyle(variance: ButtonVariance.text),
        child: Column(children: [Icon(Icons.info), !isDesktop ? Text("Info") : SizedBox()]),
        onPressed: () => context.go('/info'),
      ),
      Button.outline(
        style: ButtonStyle(variance: ButtonVariance.text),
        child: Column(children: [Icon(Icons.key), !isDesktop ? Text("Database") : SizedBox()]),
        onPressed: () => context.go('/info'),
      ),
    ];
    return isDesktop
        ? Row(
          children: [
            Column(
                children: navButtons,
              ),
            Expanded(child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: child,
            ))
          ],
        )
        : Column(
            children: [
              Expanded(child: child),
              Container(color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                    children: navButtons),
              ),
            ],
          );
  }
}
