import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:vacuum_bunnies/screens/account.dart';
import 'package:vacuum_bunnies/screens/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => HomeScreen()),
      GoRoute(path: '/account', builder: (context, state) => AccountScreen()),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return ShadApp.router(
      routerConfig: _router,
      title: 'Flutter Demo',
      theme: ShadThemeData(
        colorScheme: ShadColorScheme.fromName('violet'), brightness: Brightness.light,
      ),
    );
  }
}

