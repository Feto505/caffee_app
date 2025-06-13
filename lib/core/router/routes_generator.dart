import 'package:coffee_app/core/router/pages_routes.dart';
import 'package:coffee_app/features/tabs_screen/home_screen/home_screen.dart';
import 'package:coffee_app/features/widgets/item_details.dart';
import 'package:coffee_app/features/map_folder/main_map_screen.dart';
import 'package:coffee_app/features/on_boarding/onboarding_screen.dart';
import 'package:coffee_app/features/order_screen.dart';
import 'package:flutter/material.dart';

import '../../features/map_folder/route_view.dart';
import '../../features/widgets/main_navigation_screen.dart';

class RoutesGenerator {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case PagesRoutes.onBoarding:
        return MaterialPageRoute(builder: (context) => OnboardingScreen(), settings: settings,);

      case PagesRoutes.homeScreen:
        return MaterialPageRoute(builder: (context) => HomeScreen(), settings: settings,);
      case PagesRoutes.itemDetailsScreen:
        return MaterialPageRoute(builder: (context) => ItemDetailsScreen(), settings: settings,);

      case PagesRoutes.orderScreen:return MaterialPageRoute(builder: (context) => OrderScreen(), settings: settings,);
      case PagesRoutes.mapScreen:return MaterialPageRoute(builder: (context) => MapScreen(), settings: settings,);
      case PagesRoutes.mainMapScreen:return MaterialPageRoute(builder: (context) => MainMapScreen(), settings: settings,);
      case PagesRoutes.layoutScreen:return MaterialPageRoute(builder: (context) => MainNavigationScreen(), settings: settings,);


      default:
        return unDefinedRoute();
    }
  }
}

Route<dynamic> unDefinedRoute() {
  return MaterialPageRoute(
    builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Un defined route"),
          centerTitle: true,
        ),
        body: const Center(child: Text("Un defined route")),
      );
    },
  );
}
