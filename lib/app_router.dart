import 'package:bdc_website_v2/views/about/about_view.dart';
import 'package:bdc_website_v2/views/admin_dashboard/admin_dashboard_view.dart';
import 'package:bdc_website_v2/views/blog/blog_view.dart';
import 'package:bdc_website_v2/views/blog_details/blog_details_view.dart';
import 'package:bdc_website_v2/views/contact/contact_view.dart';
import 'package:bdc_website_v2/views/content_editor/content_editor_view.dart';
import 'package:bdc_website_v2/views/error/error_view.dart';
import 'package:bdc_website_v2/views/home_page/home_page_view.dart';
import 'package:bdc_website_v2/views/login/login_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Keeps [GoRouter] redirect logic in sync with [FirebaseAuth] session changes.
class _AuthRefreshListenable extends ChangeNotifier {
  _AuthRefreshListenable() {
    FirebaseAuth.instance.authStateChanges().listen((_) => notifyListeners());
  }
}

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  refreshListenable: _AuthRefreshListenable(),
  redirect: (BuildContext context, GoRouterState state) {
    final user = FirebaseAuth.instance.currentUser;
    final path = state.uri.path;
    final isAdminRoute = path.startsWith('/editor') ||
        path == '/adminDashboard';
    if (isAdminRoute && user == null) {
      return '/login';
    }
    return null;
  },
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (context, state) => HomePageView(),
    ),
    GoRoute(
      path: '/about',
      builder: (context, state) => AboutView(),
    ),
    GoRoute(
      path: '/contact',
      builder: (context, state) => ContactView(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => LoginView(),
    ),
    GoRoute(
      path: '/404',
      builder: (context, state) => ErrorView(),
    ),
    GoRoute(
      path: '/content/:type',
      builder: (context, state) => BlogView(),
    ),
    GoRoute(
      path: '/content/:type/:Id',
      builder: (context, state) => BlogDetailsView(),
    ),
    GoRoute(
      path: '/editor/:type',
      builder: (context, state) => const ContentEditorView(),
    ),
    GoRoute(
      path: '/editor/:type/:id',
      builder: (context, state) => const ContentEditorView(),
    ),
    GoRoute(
      path: '/adminDashboard',
      builder: (context, state) => AdminDashboardView(),
    ),
  ],
  errorBuilder: (context, state) => ErrorView(),
);
