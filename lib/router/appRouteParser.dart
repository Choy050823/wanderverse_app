import 'package:flutter/material.dart';
import 'package:wanderverse_app/router/appState.dart';

class AppRouteParser extends RouteInformationParser<AppStateData> {
  @override
  Future<AppStateData> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location);

    // Extract path from regular path or hash fragment
    String path;
    if (uri.fragment.isNotEmpty) {
      path = uri.fragment.startsWith('/') ? uri.fragment : '/${uri.fragment}';
    } else {
      path = uri.path.isEmpty ? '/auth' : uri.path;
    }

    print('Parsing URL: ${routeInformation.location}');
    print('Extracted path: $path');

    // Special handling for invalid routes
    // Make sure this check is separate from authentication check
    if (!AppStateData().isValidRoute(path) && path != AppStateData.unknown) {
      print('Invalid route detected: $path');
      return AppStateData(route: AppStateData.unknown);
    }

    return AppStateData(route: path);
  }

  @override
  RouteInformation restoreRouteInformation(AppStateData configuration) {
    print('Restoring URL to: ${configuration.route}');
    return RouteInformation(location: configuration.route);
  }
}
