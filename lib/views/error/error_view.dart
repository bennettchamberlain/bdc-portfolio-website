library error_view;

import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:stacked/stacked.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../../components/my_footer.dart';
import '../../components/my_navigation_bar.dart';
import 'error_view_model.dart';

part 'error_mobile.dart';
part 'error_tablet.dart';
part 'error_desktop.dart';

class ErrorView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ErrorViewModel>.reactive(
      viewModelBuilder: () => ErrorViewModel(),
      onModelReady: (viewModel) {
        // Do something once your viewModel is initialized
      },
      builder: (BuildContext context, ErrorViewModel viewModel, Widget? child) {
        return ScreenTypeLayout.builder(
          mobile: (BuildContext context) => _ErrorMobile(viewModel),
          desktop: (BuildContext context) => _ErrorDesktop(viewModel),
          tablet: (BuildContext context) => _ErrorMobile(viewModel),
        );
      }
    );
  }
}
