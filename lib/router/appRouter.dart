import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:go_router/go_router.dart';
import 'package:notescan/features/text_scanner/view/capture_view.dart';
import 'package:notescan/features/text_scanner/view/result_view.dart';
import 'package:flutter/material.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

late final AppLinks _appLinks;
  // ignore: unused_field, unused_element
  StreamSubscription<Uri>? _linkSubscription;

final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'capture',
      builder: (context, state) => const CaptureView(),
      routes: [
        GoRoute(
          path: 'result', // ✅ no slash
          name: 'result',
          builder: (context, state) {
            final text = state.extra as String;
            return ResultView(text: text);
          },
        ),
      ],
    ),
  ],
);

Future<void> initDeepLinks() async {
    _appLinks = AppLinks();

    // Handle the initial deep link, if any
    final initialUri = await _appLinks.getInitialLink();
    if (initialUri != null) {
      _handleDeepLink(initialUri);
    }

    // Subscribe to the stream for subsequent links
    _linkSubscription = _appLinks.uriLinkStream.listen((uri) {
      debugPrint('Received deep link: $uri');
      _handleDeepLink(uri);
    }, onError: (err) {
      debugPrint('Failed to handle deep link: $err');
    });
  }

  void _handleDeepLink(Uri uri) {
    // Example: Extract the path from the deep link and navigate
    if (uri.path.isNotEmpty) {
      final route = uri.path;
      _rootNavigatorKey.currentState?.pushNamed(route);
    }
  }
