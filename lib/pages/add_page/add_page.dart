import 'package:flutter/material.dart';

import 'add_content_page.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Admin Dashboard")),
      body: SingleChildScrollView(
          child: Container(
        child: Center(
            child: Column(children: [
          SizedBox(height: 20),
          TextButton(
            child: Text("Add a new Blog"),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddContentPage(type: "blog"),
                  ));
            },
          ),
          SizedBox(height: 20),
          TextButton(
            child: Text("Add a new Project"),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddContentPage(type: "project"),
                  ));
            },
          ),
          SizedBox(height: 20),
          TextButton(
              child: Text("replace resume on about page"),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Placeholder(),
                    ));
              })
        ])),
      )),
    );
  }
}
