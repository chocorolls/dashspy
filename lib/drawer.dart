import 'package:dashspy/screens/player_list.dart';
import 'package:dashspy/screens/server_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
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
          ),
          ListTile(
            leading: Icon(Icons.computer),
            title: Text('Servers'),
            onTap: () {
              Get.back();
              Get.off(() => ServerListPage());
            },
          ),
          ListTile(
            leading: Icon(Icons.people),
            title: Text('Players'),
            onTap: () {
              Get.back();
              Get.off(() => PlayerListPage());
            },
          ),
          ListTile(
            leading: Icon(Icons.brightness_2),
            title: Text('Switch Light/Dark Theme'),
            onTap: () {
              Get.back();
              Get.changeTheme(
                  Get.isDarkMode ? ThemeData.light() : ThemeData.dark());
            },
          ),
        ],
      ),
    );
  }
}
