import 'package:dashspy/screens/player_tile.dart';
import 'package:dashspy/utils/debouncer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/server_list_ctrl.dart';

class PlayerListPage extends StatefulWidget {
  PlayerListPage({Key? key}) : super(key: key);

  @override
  _PlayerListPageState createState() => _PlayerListPageState();
}

class _PlayerListPageState extends State<PlayerListPage> {
  var searchCtrl = TextEditingController();
  final _debouncer = Debouncer(milliseconds: 500);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ServerListCtrl>(
      init: Get.find<ServerListCtrl>(),
      builder: (ctrl) {
        if (ctrl.loading) {
          return Center(child: CircularProgressIndicator());
        }

        var players = ctrl.players;
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: searchCtrl,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: 'Search players...',
                      suffixIcon: IconButton(
                        icon: Icon(Icons.cancel),
                        onPressed: () {
                          searchCtrl.text = '';
                          _debouncer.run(() {
                            setState(() {});
                          });
                        },
                      ),
                    ),
                    onChanged: (val) {
                      _debouncer.run(() {
                        setState(() {});
                      });
                    },
                  ),
                ),
              ),
            ),
            Expanded(
              child: searchCtrl.text.length > 0
                  ? ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: players.length,
                      itemBuilder: (context, index) {
                        var player = players[index];

                        if (!player.name!
                            .toLowerCase()
                            .contains(searchCtrl.text.trim().toLowerCase())) {
                          return Container();
                        }

                        return PlayerTile(player: player);
                      },
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: players.length,
                      itemBuilder: (context, index) {
                        var player = players[index];

                        return PlayerTile(player: player);
                      },
                    ),
            ),
          ],
        );
      },
    );
  }
}
