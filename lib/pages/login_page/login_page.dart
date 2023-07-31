import 'package:flutter/material.dart';

import '../add_page/add_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Login"),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(20),
              constraints: const BoxConstraints(maxWidth: 300),
              child: Column(
                children: [
                  TextField(
                    controller: passwordController,
                    decoration: const InputDecoration(
                        hintStyle: TextStyle(color: Colors.purple),
                        hintText: "Password"),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Access the entered text using _textEditingController.text
                      String enteredText = passwordController.text;
                      // Do something with the entered text
                      print('Entered text: $enteredText');

                      if (enteredText == "password") {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddPage(),
                            ));
                      }
                    },
                    child: Text('Submit'),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
