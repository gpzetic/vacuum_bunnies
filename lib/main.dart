import 'package:get_it/get_it.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:vacuum_bunnies/data/services/api/api_client.dart';
import 'package:vacuum_bunnies/ui/app/account/widgets/account.dart';
import 'package:vacuum_bunnies/ui/app/auth/widgets/login.dart';
import 'package:vacuum_bunnies/ui/app/auth/widgets/register.dart';
import 'package:vacuum_bunnies/ui/app/leaderboard/widgets/leaderboard.dart';
import 'package:vacuum_bunnies/ui/app/home/view_models/home_view_model.dart';
import 'package:vacuum_bunnies/ui/app/home/widgets/home.dart';
import 'package:vacuum_bunnies/ui/core/navigator.dart';
import 'package:vacuum_bunnies/ui/core/navigator_web.dart';
import 'package:vacuum_bunnies/ui/info/about.dart';
import 'package:vacuum_bunnies/ui/info/authors.dart';
import 'package:vacuum_bunnies/ui/info/bunny_types.dart';
import 'package:vacuum_bunnies/ui/info/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final getIt = GetIt.instance;
  getIt.registerSingleton<ApiClient>(ApiClient());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDesktop = MediaQuery.of(context).size.width > 700;
    final router = GoRouter(
      initialLocation: isDesktop ? '/info/' : '/app/',
      routes: [
        ShellRoute(
          builder: (context, state, child) => NavigatorVB(child: child),
          routes: [
            GoRoute(
              path: '/app',
              builder: (context, state) =>
                  HomeScreen(viewModel: HomeViewModel()),
              routes: [
                GoRoute(
                  path: 'account',
                  builder: (context, state) => AccountScreen(),
                ),
                GoRoute(
                  path: 'register',
                  builder: (context, state) => Register(),
                ),
                GoRoute(path: 'login', builder: (context, state) => Login()),
                GoRoute(
                  path: 'leaderboard',
                  builder: (context, state) => LeaderboardScreen(),
                ),
              ],
            ),
          ],
        ),
        ShellRoute(
          builder: (context, state, child) => NavigatorWeb(child: child),
          routes: [
    GoRoute(path: '/', builder: (context, state) => InfoHome()),
            GoRoute(path: '/info', builder: (context, state) => InfoHome(),
                routes:[
                  GoRoute(
                    path: '/',
                    builder: (context, state) => const InfoHome(),
                  ),
                  GoRoute(
                    path: 'authors',
                    builder: (context, state) => const InfoAuthors(),
                  ),
                  GoRoute(
                    path: 'bunny-types',
                    builder: (context, state) => const InfoBunnyTypes(),
                  ),
                  GoRoute(
                    path: 'about',
                    builder: (context, state) => const InfoAbout(),
                  ),
                ] ),
          ],
        ),
      ],
    );

    return ShadcnApp.router(
      routerConfig: router,
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: ColorSchemes.lightViolet),
      background: Colors.white,

    );
  }
}
