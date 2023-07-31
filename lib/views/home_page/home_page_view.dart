library home_page_view;

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:bdc_website_v2/components/my_footer.dart';
import 'package:bdc_website_v2/components/my_marquee.dart';
import 'package:bdc_website_v2/components/my_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'home_page_view_model.dart';

part 'home_page_mobile.dart';
part 'home_page_tablet.dart';
part 'home_page_desktop.dart';

class HomePageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomePageViewModel>.reactive(
      viewModelBuilder: () => HomePageViewModel(),
      onViewModelReady: (viewModel) {
        // Do something once your viewModel is initialized
      },
      builder: (BuildContext context, HomePageViewModel viewModel, Widget? child) {
        return ScreenTypeLayout.builder(
          mobile: (BuildContext context) =>  _HomePageMobile(viewModel),
          desktop: (BuildContext context) =>  _HomePageDesktop(viewModel),
          tablet: (BuildContext context) =>  _HomePageMobile(viewModel),  
        );
      }
    );
  }
}
