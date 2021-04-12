import 'dart:async';

import 'package:dashspy/controllers/favorites_ctrl.dart';
import 'package:dashspy/controllers/server_list_ctrl.dart';
import 'package:dashspy/models/server.dart';
import 'package:dashspy/screens/player_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoriteListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ServerListCtrl>(
      init: Get.find<ServerListCtrl>(),
      builder: (ctrl) {
        return ListView(
          children: [
            ListTile(title: Text('Online (${ctrl.onlineFavorites.length})')),
            ...ctrl.onlineFavorites.map((p) => PlayerTile(player: p)),
            ListTile(title: Text('Offline (${ctrl.offlineFavorites.length})')),
            ...ctrl.offlineFavorites.map(
              (name) => ListTile(
                leading: Chip(
                  label: Text('-'),
                ),
                title: Text(name),
                subtitle: Text('Offline'),
              ),
            ),
          ],
        );
      },
    );
  }
}
