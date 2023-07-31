// [ This is an auto generated file ]

import 'package:flutter/material.dart';
import 'package:bdc_website_v2/core/router_constants.dart';

import 'package:bdc_website_v2/views/create_bog/create_bog_view.dart' as view0;
import 'package:bdc_website_v2/views/home_page/home_page_view.dart' as view1;
import 'package:bdc_website_v2/views/about/about_view.dart' as view2;
import 'package:bdc_website_v2/views/login/login_view.dart' as view3;
import 'package:bdc_website_v2/views/blog/blog_view.dart' as view4;
import 'package:bdc_website_v2/views/contact/contact_view.dart' as view5;
import 'package:bdc_website_v2/views/create_content/create_content_view.dart' as view6;
import 'package:bdc_website_v2/views/admin_dashboard/admin_dashboard_view.dart' as view7;
import 'package:bdc_website_v2/views/error/error_view.dart' as view8;
import 'package:bdc_website_v2/views/blog_details/blog_details_view.dart' as view9;

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case createBogViewRoute:
        return MaterialPageRoute(builder: (_) => view0.CreateBogView());
      case homePageViewRoute:
        return MaterialPageRoute(builder: (_) => view1.HomePageView());
      case aboutViewRoute:
        return MaterialPageRoute(builder: (_) => view2.AboutView());
      case loginViewRoute:
        return MaterialPageRoute(builder: (_) => view3.LoginView());
      case blogViewRoute:
        return MaterialPageRoute(builder: (_) => view4.BlogView());
      case contactViewRoute:
        return MaterialPageRoute(builder: (_) => view5.ContactView());
      case createContentViewRoute:
        return MaterialPageRoute(builder: (_) => view6.CreateContentView());
      case adminDashboardViewRoute:
        return MaterialPageRoute(builder: (_) => view7.AdminDashboardView());
      case errorViewRoute:
        return MaterialPageRoute(builder: (_) => view8.ErrorView());
      case blogDetailsViewRoute:
        return MaterialPageRoute(builder: (_) => view9.BlogDetailsView());
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