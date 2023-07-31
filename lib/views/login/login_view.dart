library login_view;

import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:vrouter/vrouter.dart';
import 'login_view_model.dart';

part 'login_mobile.dart';
part 'login_tablet.dart';
part 'login_desktop.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () => LoginViewModel(),
      onModelReady: (viewModel) {
        // Do something once your viewModel is initialized
      },
      builder: (BuildContext context, LoginViewModel viewModel, Widget? child) {
        return ScreenTypeLayout.builder(
          mobile: (BuildContext context) =>  _LoginMobile(viewModel),
          desktop: (BuildContext context) =>  _LoginDesktop(viewModel),
          tablet: (BuildContext context) =>  _LoginMobile(viewModel),
        );
      }
    );
  }
}
