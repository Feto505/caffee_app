import 'package:flutter/material.dart';

import 'core/router/pages_routes.dart';
import 'core/router/routes_generator.dart';
import 'core/services/screen_size_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ScreenSizeService.init(context);

    return MaterialApp(
      title: 'Coffee App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
        onGenerateRoute: RoutesGenerator.onGenerateRoute,
        initialRoute: PagesRoutes.homeScreen
    );
  }
}

