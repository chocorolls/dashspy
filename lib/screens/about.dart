import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'DashSpy',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('rev. 3'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Made with <3 by Marisol'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('API by Zed'),
          ),
        ],
      ),
    );
  }
}
