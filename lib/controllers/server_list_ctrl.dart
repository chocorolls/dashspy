import 'package:dashspy/models/player.dart';
import 'package:dashspy/models/server.dart';
import 'package:get/get.dart';

class ServerListCtrl extends GetxController {
  List<Server> servers = [];
  List<Player> players = [];
  Map<String, List<Player>> tags = {};

  List<Player> searchResult = [];
  bool loading = true;

  ServerListCtrl() {
    fetchData();
  }

  void fetchData() async {
    loading = true;
    update();
    var response = await GetConnect().get('https://api.dashlist.info/fetch');

    if (!response.hasError) {
      var maps = (response.body as Map);
      servers = maps.keys.map((k) => Server.fromMap(k, maps[k])).toList();

      servers
        ..sort(
            (a, b) => a.name!.toLowerCase().compareTo(b.name!.toLowerCase()));
      loading = false;
      mapPlayers();
    } else {
      print(response.body);
    }

    loading = false;
    update();
  }

  void mapPlayers() {
    players = [];
    servers.forEach((server) {
      server.players?.forEach((player) {
        players.add(player);

        if (player.tag != null) {
          if (!tags.containsKey(player.tag)) {
            tags[player.tag!] = [];
          }

          tags[player.tag!]?.add(player);
        }
      });
    });

    players
      ..sort((a, b) => a.name!.toLowerCase().compareTo(b.name!.toLowerCase()));
  }
}
