import 'package:bdc_website_v2/views/about/about_view.dart';
import 'package:bdc_website_v2/views/admin_dashboard/admin_dashboard_view.dart';
import 'package:bdc_website_v2/views/blog/blog_view.dart';
import 'package:bdc_website_v2/views/blog_details/blog_details_view.dart';
import 'package:bdc_website_v2/views/contact/contact_view.dart';
import 'package:bdc_website_v2/views/create_bog/create_bog_view.dart';
import 'package:bdc_website_v2/views/create_content/create_content_view.dart';
import 'package:bdc_website_v2/views/error/error_view.dart';
import 'package:bdc_website_v2/views/home_page/home_page_view.dart';
import 'package:bdc_website_v2/views/login/login_view.dart';
import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vrouter/vrouter.dart';
import 'core/locator.dart';
import 'firebase_options.dart';
import 'pages/project_page/project_page_layout.dart';

void main() async {
  await LocatorInjector.setUpLocator();
  await FastCachedImageConfig.init(clearCacheAfter: const Duration(days: 15));
  await GetStorage.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: VRouter(
          mode: VRouterMode.history,
          debugShowCheckedModeBanner: false,
          routes: [
            VGuard(
              beforeEnter: (vRedirector) async {
                final isLoggedIn = FirebaseAuth.instance.currentUser != null;
                // Check if the user is logged in
                if (!isLoggedIn) {
                  // If not, redirect to /login
                  vRedirector.to('/login');
                }
              },
              stackedRoutes: [
                VWidget(
                  path: '/createBlog/:type',
                  widget: const CreateBogView(),
                ),
                VWidget(
                  path: '/createContent/:type',
                  widget: const CreateContentView(),
                ),
                VWidget(
                  path: '/adminDashboard',
                  widget: AdminDashboardView(),
                ),
              ],
            ),
            VWidget(
              path: '/',
              widget: HomePageView(),
            ),
            VWidget(
              path: '/about',
              widget: AboutView(),
            ),

            VWidget(
              path: '/content/:type',
              widget: BlogView(),
            ),
            VWidget(
              path: '/content/:type/:Id',
              widget: BlogDetailsView(),
            ),
            VWidget(
              path: '/contact',
              widget: ContactView(),
            ),
            //Wrong page route and wildcard route redirect
            VWidget(
              path: '/404',
              widget: ErrorView(),
            ),
            VWidget(path: "/login", widget: LoginView()),

            //-----------------------ALL of the blog posts------------------

            // VWidget(
            //   path: '/blog/post-1',
            //   widget: const UniqueBlogPageLayout(post: BlogPosts.BlogPost1),
            // ),
            // VWidget(
            //   path: '/blog/post-2',
            //   widget: const UniqueBlogPageLayout(post: BlogPosts.BlogPost1),
            // ),

            // //-----------------------ALL of the project posts------------------

            // VWidget(
            //   path: '/projects/project-1',
            //   widget:
            //       const UniqueProjectPageLayout(post: ProjectPosts.ProjectPost1),
            // ),
            // VWidget(
            //   path: '/projects/project-2',
            //   widget:
            //       const UniqueProjectPageLayout(post: ProjectPosts.ProjectPost2),
            // ),

            VRouteRedirector(path: '*', redirectTo: '/404')
          ],
          title: 'BDC - KIP',
          theme: ThemeData(
            fontFamily: 'Helvetica',
            primarySwatch: Colors.grey,
          )),
    );
  }
}
