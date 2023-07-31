library contact_view;

import 'package:bdc_website_v2/components/my_footer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../../components/my_navigation_bar.dart';
import 'contact_view_model.dart';

part 'contact_mobile.dart';
part 'contact_tablet.dart';
part 'contact_desktop.dart';

class ContactView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ContactViewModel>.reactive(
      viewModelBuilder: () => ContactViewModel(),
      onModelReady: (viewModel) {
        // Do something once your viewModel is initialized
      },
      builder: (BuildContext context, ContactViewModel viewModel, Widget? child) {
        return ScreenTypeLayout.builder(
          mobile: (BuildContext context) => _ContactMobile(viewModel),
          tablet: (BuildContext context) => _ContactMobile(viewModel),
          desktop: (BuildContext context) => _ContactDesktop(viewModel),
        );
      }
    );
  }
}
