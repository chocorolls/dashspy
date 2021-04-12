import 'package:dashspy/controllers/server_list_ctrl.dart';
import 'package:dashspy/screens/player_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClanListPage extends StatelessWidget {
  const ClanListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ServerListCtrl>(
      init: Get.find<ServerListCtrl>(),
      builder: (ctrl) {
        return ListView.builder(
          itemCount: ctrl.clans.length,
          itemBuilder: (context, index) {
            var clan = ctrl.clans[index];
            if (clan.players.length == 0) {
              return Container();
            }

            return Column(
              children: [
                ListTile(
                  title: Text(
                    '${clan.name} (${clan.players.length})',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Column(
                  children: clan.players.map((p) {
                    return PlayerTile(player: p);
                  }).toList(),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
