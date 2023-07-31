import 'package:flutter/material.dart';

import '../../components/my_navigation_bar.dart';

class ContactPageDesktop extends StatefulWidget {
  const ContactPageDesktop({super.key});

  @override
  State<ContactPageDesktop> createState() => _ContactPageDesktopState();
}

class _ContactPageDesktopState extends State<ContactPageDesktop>
    with SingleTickerProviderStateMixin {
  bool selectedNavigation = false;
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _email = '';
  String _phone = '';
  String _message = '';

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Submit the form to your desired destination or perform actions here
      // For demonstration purposes, we will just print the form data.
      print('Name: $_name');
      print('Email: $_email');
      print('Phone: $_phone');
      print('Message: $_message');
    }
  }

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 0)).then((value) => setState(() {
          selectedNavigation = true;
        }));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Stack(
              children: [
                Column(
                  children: [
                    const SizedBox(
                      height: 110,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              decoration: InputDecoration(labelText: 'Name'),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your name';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                _name = value;
                              },
                            ),
                            SizedBox(height: 16),
                            TextFormField(
                              decoration: InputDecoration(labelText: 'Email'),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your email';
                                }
                                // You can add a more specific email validation logic here if needed.
                                return null;
                              },
                              onChanged: (value) {
                                _email = value;
                              },
                            ),
                            SizedBox(height: 16),
                            TextFormField(
                              decoration: InputDecoration(
                                  labelText: 'Phone (Optional)'),
                              onChanged: (value) {
                                _phone = value;
                              },
                            ),
                            SizedBox(height: 16),
                            TextFormField(
                              decoration: InputDecoration(labelText: 'Message'),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your message';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                _message = value;
                              },
                              maxLines: 4,
                            ),
                            SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: _submitForm,
                              child: Text('Submit'),
                            ),
                          ],
                        ),
                      ),
                    ),
                    //PUT EVERYTIHING HERE
                    Container(
                      height: 500,
                      decoration: BoxDecoration(border: Border.all(width: 8)),
                    ),
                    const SizedBox(height: 50),
                    MyNavigationBar(mobile: false)
                  ],
                ),
                const MyNavigationBar(mobile: false),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
