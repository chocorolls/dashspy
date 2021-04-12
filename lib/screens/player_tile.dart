import 'package:dashspy/controllers/favorites_ctrl.dart';
import 'package:dashspy/screens/server_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/server_list_ctrl.dart';
import '../models/player.dart';
import '../models/server.dart';

class PlayerTile extends StatefulWidget {
  PlayerTile({
    Key? key,
    required this.player,
  }) : super(key: key);

  final Player player;

  @override
  _PlayerTileState createState() => _PlayerTileState();
}

class _PlayerTileState extends State<PlayerTile> {
  final ctrl = Get.find<FavoritesCtrl>();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SizedBox(
          width: 50,
          child: Chip(
            label: Text(
              '${widget.player.level ?? ''}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: Colors.orange,
          )),
      title: widget.player.tag != null
          ? Row(children: [
              Text(
                widget.player.tag! + ' ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              Text(widget.player.name?.trim() ?? ''),
            ])
          : Text(widget.player.name?.trim() ?? ''),
      subtitle: Text(widget.player.serverName ?? ''),
      onTap: () {
        var ctrl = Get.find<ServerListCtrl>();
        Server? s = ctrl.servers.firstWhere(
            (srv) => srv.name == widget.player.serverName,
            orElse: null);

        if (s != null) {
          Get.to(ServerViewPage(server: s));
        }
      },
      onLongPress: () {
        showModalBottomSheet(
            context: context,
            builder: (context) {
              return Wrap(
                children: [
                  if (ctrl.favorites.contains(widget.player.baseName))
                    ListTile(
                      leading: Icon(
                        Icons.favorite,
                      ),
                      title: Text('Remove from Favorites'),
                      onTap: () {
                        Get.back();
                        ctrl.removePlayer(widget.player.baseName);
                        setState(() {});
                      },
                    ),
                  if (!ctrl.favorites.contains(widget.player.baseName))
                    ListTile(
                      leading: Icon(
                        Icons.favorite,
                        color: Colors.pink,
                      ),
                      title: Text('Add to Favorites'),
                      onTap: () {
                        Get.back();
                        ctrl.addPlayer(widget.player.baseName);
                        setState(() {});
                      },
                    ),
                ],
              );
            });
      },
      trailing: ctrl.favorites.contains(widget.player.baseName)
          ? IconButton(
              onPressed: () {
                //
              },
              icon: Icon(
                Icons.favorite,
                color: Colors.pink,
              ))
          : null,
    );

    // trailing: Text(srv['mode']),
    //onTap: () {
    //  Get.to(() =>
    //      ServerViewPage(name: servers[index], server: srv));
  }
}
