library blog_view;

import 'package:bdc_website_v2/models/blog/blog_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:vrouter/vrouter.dart';
import '../../components/blog_card.dart';
import '../../components/my_footer.dart';
import '../../components/my_navigation_bar.dart';
import '../../pages/blog_page/blog_posts_enums.dart';
import 'blog_view_model.dart';

part 'blog_mobile.dart';
part 'blog_tablet.dart';
part 'blog_desktop.dart';

class BlogView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BlogViewModel>.reactive(
        viewModelBuilder: () => BlogViewModel(context),
        onModelReady: (viewModel) {
          // Do something once your viewModel is initialized
        },
        builder:
            (BuildContext context, BlogViewModel viewModel, Widget? child) {
          return ScreenTypeLayout.builder(
            mobile: (BuildContext context) => _BlogMobile(viewModel),
            tablet: (BuildContext context) => _BlogMobile(viewModel),
            desktop: (BuildContext context) => _BlogDesktop(viewModel),
          );
        });
  }
}
