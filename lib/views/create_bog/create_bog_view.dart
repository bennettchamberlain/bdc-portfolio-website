library create_bog_view;

import 'dart:convert';
import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_dynamic_widget/json_dynamic_widget.dart';
import 'package:line_icons/line_icons.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:quds_popup_menu/quds_popup_menu.dart';
import 'package:quill_html_editor/quill_html_editor.dart';
import 'package:stacked/stacked.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../../services/storage_handler.dart';
import 'create_bog_view_model.dart';

part 'create_bog_mobile.dart';
part 'create_bog_tablet.dart';
part 'create_bog_desktop.dart';

class CreateBogView extends StatelessWidget {
  const CreateBogView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CreateBogViewModel>.reactive(
        viewModelBuilder: () => CreateBogViewModel(context),
        onViewModelReady: (viewModel) {
          // Do something once your viewModel is initialized
        },
        builder: (BuildContext context, CreateBogViewModel viewModel,
            Widget? child) {
          return ScreenTypeLayout.builder(
            mobile: (BuildContext context) => _CreateBogMobile(viewModel),
            desktop: (BuildContext context) => _CreateBogDesktop(viewModel),
            tablet: (BuildContext context) => _CreateBogTablet(viewModel),
          );
        });
  }
}
