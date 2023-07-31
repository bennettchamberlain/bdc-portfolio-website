part of contact_view;

class _ContactMobile extends StatefulWidget {
  final ContactViewModel viewModel;

  _ContactMobile(this.viewModel);

  @override
  State<_ContactMobile> createState() => _ContactMobileState();
}

class _ContactMobileState extends State<_ContactMobile> {
  bool selectedNavigation = false;
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  TextEditingController namecontroller = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  String _name = '';
  String _email = '';
  String _phone = '';
  String _message = '';

  sendEmail(String sendEmailTo, String subject, String emailBody) async {
    final mailAdmin = FirebaseFirestore.instance.collection('mail');
    await mailAdmin.doc().set(
      {
        'to': sendEmailTo,
        'message': {
          'subject': subject,
          //'text': emailBody,
          'html': '<html><body><h4>$emailBody</h4></body></html>'
        },
      },
    );
  }

  _submitForm() async {
    if (_formKey.currentState!.validate()) {
      sendEmail(
          "chamberlain.bennett@gmail.com",
          "New message from ${namecontroller.text}",
          "Message from: ${namecontroller.text} <br> phone number: ${phoneController.text} <br> email: ${emailController.text} <br> Message: ${messageController.text}");

      sendEmail(emailController.text, "Thanks for your message",
          "Hi ${namecontroller.text}, <br> I recieved your message and will respond within 48 hours. <br> Looking forward to connect, <br> Bennett Chamberlain \n ");
      namecontroller.text = '';
      emailController.text = '';
      phoneController.text = '';
      messageController.text = '';
    }
  }

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 0)).then((value) => setState(() {
          widget.viewModel.selectedNavigation = true;
        }));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                      height: 65,
                    ),

                    //PUT EVERYTIHING HERE
                    Container(
                        height: 460,
                        decoration: BoxDecoration(border: Border.all(width: 8)),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextFormField(
                                      controller: namecontroller,
                                      decoration: InputDecoration(
                                          labelText: 'Name',
                                          labelStyle: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w900)),
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
                                      controller: emailController,
                                      decoration: InputDecoration(
                                          labelText: 'Email',
                                          labelStyle: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w900)),
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
                                      controller: phoneController,
                                      decoration: InputDecoration(
                                          labelText: 'Phone (optional)',
                                          labelStyle: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w900)),
                                      onChanged: (value) {
                                        _phone = value;
                                      },
                                    ),
                                    SizedBox(height: 16),
                                    TextFormField(
                                      controller: messageController,
                                      decoration: InputDecoration(
                                        labelText: 'Message',
                                        labelStyle: TextStyle(
                                            fontSize: 20,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w900),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.all(Radius.zero),
                                            borderSide: BorderSide(
                                                color: Colors.black, width: 8)),
                                      ),
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
                                    Container(
                                      padding: EdgeInsets.only(
                                          left: 15,
                                          right: 15,
                                          top: 15,
                                          bottom: 12),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 8, color: Colors.black)),
                                      child: TextButton(
                                        onPressed: _submitForm,
                                        child: Text(
                                          'Submit',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w900,
                                              color: Colors.black),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )),
                    const SizedBox(height: 20),
                    MyFooter(mobile: true)
                  ],
                ),
                const MyNavigationBar(mobile: true),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
