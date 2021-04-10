import 'package:dashspy/screens/server_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/server_list_ctrl.dart';
import '../models/player.dart';
import '../models/server.dart';

class PlayerTile extends StatelessWidget {
  const PlayerTile({
    Key? key,
    required this.player,
  }) : super(key: key);

  final Player player;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
          leading: SizedBox(
              width: 50,
              child: Chip(
                label: Text(
                  '${player.level ?? ''}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                backgroundColor: Colors.orange,
              )),
          title: player.tag != null
              ? Row(children: [
                  Text(
                    player.tag! + ' ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  Text(player.name?.trim() ?? ''),
                ])
              : Text(player.name?.trim() ?? ''),
          subtitle: Text(player.serverName ?? ''),
          onTap: () {
            var ctrl = Get.find<ServerListCtrl>();
            Server? s = ctrl.servers.firstWhere(
                (srv) => srv.name == player.serverName,
                orElse: null);

            if (s != null) {
              Get.to(ServerViewPage(server: s));
            }
          }
          // trailing: Text(srv['mode']),
          //onTap: () {
          //  Get.to(() =>
          //      ServerViewPage(name: servers[index], server: srv));
          //},
          ),
    );
  }
}
