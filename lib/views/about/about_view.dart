library about_view;

import 'package:bdc_website_v2/models/about_us/resume_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../../components/my_footer.dart';
import '../../components/my_navigation_bar.dart';
import 'about_view_model.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

part 'about_mobile.dart';
part 'about_tablet.dart';
part 'about_desktop.dart';

class AboutView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AboutViewModel>.reactive(
        viewModelBuilder: () => AboutViewModel(),
        onModelReady: (viewModel) {
          // Do something once your viewModel is initialized
        },
        builder:
            (BuildContext context, AboutViewModel viewModel, Widget? child) {
          return ScreenTypeLayout.builder(
            mobile: (BuildContext context) => _AboutMobile(viewModel),
            desktop: (BuildContext context) => _AboutDesktop(viewModel),
            tablet: (BuildContext context) => _AboutMobile(viewModel),
          );
        });
  }
}
