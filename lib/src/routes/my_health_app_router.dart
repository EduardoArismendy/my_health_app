import 'package:go_router/go_router.dart';
import 'package:my_health_app/src/feature/screens/age_screen.dart';
import 'package:my_health_app/src/feature/screens/bmi_screen.dart';
import 'package:my_health_app/src/feature/screens/home_screen.dart';
import 'package:my_health_app/src/feature/screens/zodiac_screen.dart';

class MyHealthAppRouter {
  // Router implementation goes here
  static final GoRouter router = GoRouter(
    routes: [
      // Define your routes here
      GoRoute(path: '/', builder: (context, state) => HomeScreen()),
      GoRoute(path: '/age', builder: (context, state) => AgeScreen()),
      GoRoute(path: '/bmi', builder: (context, state) => BmiScreen()),
      GoRoute(path: '/zodiac', builder: (context, state) => ZodiacScreen()),
    ],
  );
}
