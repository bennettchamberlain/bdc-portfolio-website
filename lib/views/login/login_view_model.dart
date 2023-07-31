import 'package:bdc_website_v2/pages/add_page/add_page.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:bdc_website_v2/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class LoginViewModel extends BaseViewModel {
  late Logger log;

  LoginViewModel() {
   log = getLogger(runtimeType.toString());
  }

   final  providers = [EmailAuthProvider()]; 
    TextEditingController passwordController = TextEditingController();
    NavigationService _navigationService = NavigationService();




    navigateToPostLoginScreen() {
      _navigationService.navigateToView(const AddPage());
    }
}
