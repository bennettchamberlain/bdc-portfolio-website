library create_content_view;

import 'package:bdc_website_v2/components/upload_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:stacked/stacked.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:vrouter/vrouter.dart';
import '../../services/storage_handler.dart';
import 'create_content_view_model.dart';

part 'create_content_mobile.dart';
part 'create_content_tablet.dart';
part 'create_content_desktop.dart';

class CreateContentView extends StatelessWidget {
  const CreateContentView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CreateContentViewModel>.reactive(
      viewModelBuilder: () => CreateContentViewModel(context),
      
      builder: (BuildContext context, CreateContentViewModel viewModel, Widget? child) {
        return  ScreenTypeLayout.builder(
          mobile: (BuildContext context) => _CreateContentMobile(viewModel),
          tablet: (BuildContext context) => _CreateContentMobile(viewModel),
          desktop: (BuildContext context) => _CreateContentDesktop(viewModel), 
        );
      }
    );
  }
}
