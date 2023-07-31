library blog_details_view;

import 'package:bdc_website_v2/components/my_footer.dart';
import 'package:bdc_website_v2/core/models/ui_element.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ad_manager_web/flutter_ad_manager_web.dart';
import 'package:stacked/stacked.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../../models/blog/blog_model.dart';
import 'blog_details_view_model.dart';
part 'blog_details_mobile.dart';
part 'blog_details_tablet.dart';
part 'blog_details_desktop.dart';

class BlogDetailsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BlogDetailsViewModel>.reactive(
        viewModelBuilder: () => BlogDetailsViewModel(context),
        builder: (BuildContext context, BlogDetailsViewModel viewModel,
            Widget? child) {
          return ScreenTypeLayout.builder(
            mobile: (BuildContext context) => _BlogDetailsMobile(viewModel),
            desktop: (BuildContext context) => _BlogDetailsDesktop(viewModel),
            tablet: (BuildContext context) => _BlogDetailsMobile(viewModel),
          );
        });
  }
}
