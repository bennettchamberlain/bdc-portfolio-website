library about_view;

import 'dart:html' as html;
import 'dart:ui_web' as ui_web;

import 'package:bdc_website_v2/models/about_us/resume_model.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stacked/stacked.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../components/my_footer.dart';
import '../../components/my_navigation_bar.dart';
import 'about_view_model.dart';

part 'about_desktop.dart';
part 'about_mobile.dart';
part 'about_tablet.dart';

class AboutView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AboutViewModel>.reactive(
        viewModelBuilder: () => AboutViewModel(),
        onModelReady: (viewModel) {},
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

/// Shared PDF viewer using a local pdf.js renderer (no browser toolbar or
/// thumbnail panel). The iframe height is calculated from the US Letter
/// aspect ratio so there is zero internal scroll — page scroll drives
/// navigation through the whole site.
class _ResumePdfSection extends StatefulWidget {
  final Future<Resume?> resumeFuture;
  final double containerWidth;

  const _ResumePdfSection(
      {required this.resumeFuture, required this.containerWidth});

  @override
  State<_ResumePdfSection> createState() => _ResumePdfSectionState();
}

class _ResumePdfSectionState extends State<_ResumePdfSection> {
  static bool _factoryRegistered = false;

  // US Letter: 612 × 792 pts — gives the exact height for a 1-page resume
  static const double _letterAspect = 792.0 / 612.0;

  @override
  Widget build(BuildContext context) {
    final double pdfHeight = widget.containerWidth * _letterAspect;

    return FutureBuilder<Resume?>(
      future: widget.resumeFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
            height: pdfHeight,
            child: const Center(child: CircularProgressIndicator()),
          );
        }
        if (!snapshot.hasData || snapshot.data == null) {
          return SizedBox(
            height: pdfHeight,
            child: const Center(child: Text('Resume unavailable')),
          );
        }

        final url = snapshot.data!.url;
        final viewerUrl =
            '/pdf_viewer.html?url=${Uri.encodeComponent(url)}';
        final viewType = 'resume-pdf-iframe';

        if (!_factoryRegistered) {
          ui_web.platformViewRegistry.registerViewFactory(
            viewType,
            (int id) => html.IFrameElement()
              ..src = viewerUrl
              ..style.border = 'none'
              ..style.width = '100%'
              ..style.height = '100%'
              // Disable iframe pointer capture so page scroll is not blocked
              ..style.pointerEvents = 'none',
          );
          _factoryRegistered = true;
        }

        return Stack(
          children: [
            SizedBox(
              height: pdfHeight,
              width: double.infinity,
              child: HtmlElementView(viewType: viewType),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: Tooltip(
                message: 'Download Resume',
                child: InkWell(
                  onTap: () => launchUrl(Uri.parse(url),
                      mode: LaunchMode.externalApplication),
                  borderRadius: BorderRadius.circular(4),
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.6),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Icon(Icons.download_rounded,
                        color: Colors.white, size: 18),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}


