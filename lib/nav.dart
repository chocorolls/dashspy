import 'package:dashspy/screens/favorite_list.dart';
import 'package:dashspy/screens/player_list.dart';
import 'package:dashspy/screens/server_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'screens/about.dart';
import 'controllers/server_list_ctrl.dart';
import 'screens/clan_list.dart';

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
    ClanListPage(),
    FavoriteListPage(),
    AboutPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
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
        type: BottomNavigationBarType.fixed,
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
          BottomNavigationBarItem(
            icon: Icon(Icons.military_tech),
            label: 'Clans',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'Info',
          ),
        ],
      ),
    );
  }
}
