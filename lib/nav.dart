import 'package:dashspy/screens/player_list.dart';
import 'package:dashspy/screens/server_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'screens/about.dart';
import 'controllers/server_list_ctrl.dart';

class NavPage extends StatefulWidget {
  NavPage({Key? key}) : super(key: key);

  @override
  _NavPageState createState() => _NavPageState();
}

class _NavPageState extends State<NavPage> {
  var index = 0;

  var contents = [
    ServerListPage(),
    PlayerListPage(),
    //TagListPage(),
    AboutPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DashSpy'),
        actions: [
          IconButton(
            onPressed: () {
              Get.find<ServerListCtrl>().fetchData();
            },
            icon: Icon(Icons.refresh),
          )
        ],
      ),
      body: contents[index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (val) {
          setState(() {
            index = val;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.computer_rounded),
            label: 'Servers',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Players',
          ),
          /*BottomNavigationBarItem(
            icon: Icon(Icons.tag),
            label: 'Tags',
          ),*/
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'Info',
          ),
        ],
      ),
    );
  }
}
