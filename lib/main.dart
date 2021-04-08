import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:star_wars_wiki/ui/utils/router.dart';
import 'package:star_wars_wiki/ui/views/home_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Star Wiki',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        textTheme: GoogleFonts.robotoTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: HomeView(),
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
