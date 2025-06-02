import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../presentation/pages/counter/counter_page.dart';

/// Application router configuration
class AppRouter {
  static const String counterRoute = '/counter';
  static const String homeRoute = '/';

  /// Router configuration
  static final GoRouter router = GoRouter(
    initialLocation: homeRoute,
    routes: [
      GoRoute(
        path: homeRoute,
        name: 'home',
        builder: (context, state) => const CounterPage(),
      ),
      GoRoute(
        path: counterRoute,
        name: 'counter',
        builder: (context, state) => const CounterPage(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(title: const Text('Error')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              'Page not found: ${state.uri}',
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go(homeRoute),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    ),
  );
}
