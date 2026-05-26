library contact_view;

import 'package:bdc_website_v2/components/my_footer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stacked/stacked.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../components/my_navigation_bar.dart';
import 'contact_view_model.dart';

part 'contact_desktop.dart';
part 'contact_mobile.dart';
part 'contact_tablet.dart';

class ContactView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ContactViewModel>.reactive(
      viewModelBuilder: () => ContactViewModel(),
      onModelReady: (viewModel) {},
      builder:
          (BuildContext context, ContactViewModel viewModel, Widget? child) {
        return ScreenTypeLayout.builder(
          mobile: (BuildContext context) => _ContactMobile(viewModel),
          tablet: (BuildContext context) => _ContactMobile(viewModel),
          desktop: (BuildContext context) => _ContactDesktop(viewModel),
        );
      },
    );
  }
}

/// A styled card that invites visitors to book a 15-minute call.
/// Opens the Google Calendar appointment scheduling page in a new tab.
class _CalendarBookingWidget extends StatelessWidget {
  static const String _bookingUrl =
      'https://calendar.app.google/jqssrh7DXJjift1r9';

  const _CalendarBookingWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration:
          BoxDecoration(border: Border.all(color: Colors.black, width: 8)),
      padding: const EdgeInsets.all(28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Book a 15-Minute Call',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w900,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            "Want to connect? Pick a time that works for you — it goes straight onto my calendar.",
            style: TextStyle(fontSize: 16, color: Colors.black87, height: 1.5),
          ),
          const SizedBox(height: 24),
          InkWell(
            onTap: () => launchUrl(
              Uri.parse(_bookingUrl),
              mode: LaunchMode.externalApplication,
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.zero,
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.calendar_today, color: Colors.white, size: 18),
                  SizedBox(width: 10),
                  Text(
                    'Schedule a Call',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


