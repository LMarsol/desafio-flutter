import 'package:flutter/material.dart';
import 'package:star_wars_wiki/ui/views/character_view.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case 'character':
        Map args = settings.arguments as Map;
        return MaterialPageRoute(
          builder: (_) => CharacterView(
            character: args['character'],
          ),
          settings: settings,
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
