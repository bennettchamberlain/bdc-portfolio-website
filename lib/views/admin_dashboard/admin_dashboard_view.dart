library admin_dashboard_view;

import 'dart:html';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:vrouter/vrouter.dart';
import '../../pages/add_page/add_content_page.dart';
import 'admin_dashboard_view_model.dart';

part 'admin_dashboard_mobile.dart';
part 'admin_dashboard_tablet.dart';
part 'admin_dashboard_desktop.dart';

class AdminDashboardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AdminDashboardViewModel>.reactive(
        viewModelBuilder: () => AdminDashboardViewModel(),
        builder: (BuildContext context, AdminDashboardViewModel viewModel,
            Widget? child) {
          return ScreenTypeLayout.builder(
            mobile: (BuildContext context) => _AdminDashboardMobile(viewModel),
            tablet: (BuildContext context) => _AdminDashboardMobile(viewModel),
            desktop: (BuildContext context) =>
                _AdminDashboardDesktop(viewModel),
          );
        });
  }
}
