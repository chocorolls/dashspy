import 'dart:async';

import 'package:dashspy/controllers/favorites_ctrl.dart';
import 'package:dashspy/data/known_tags.dart';
import 'package:dashspy/models/clan.dart';
import 'package:dashspy/models/player.dart';
import 'package:dashspy/models/server.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ServerListCtrl extends GetxController {
  List<Server> servers = [];
  List<Player> players = [];
  List<Clan> clans = [];
  //
  List<Player> onlineFavorites = [];
  List<String> offlineFavorites = [];

  List<Player> searchResult = [];
  bool loading = true;

  //late Timer timer;

  ServerListCtrl() {
    fetchData();

    /*timer = Timer.periodic(Duration(seconds: 5), (timer) {
      fetchData();
    });*/
  }

  @override
  void dispose() {
    //timer.cancel();
    super.dispose();
  }

  void populateClans() {
    knownTags.forEach((tag) {
      clans.add(Clan(name: tag));
    });
  }

  void fetchData() async {
    loading = true;
    update();

    clans.clear();

    onlineFavorites.clear();
    offlineFavorites = Get.find<FavoritesCtrl>().favorites;

    populateClans();

    var response = await GetConnect().get('https://api.dashlist.info/fetch');

    if (!response.hasError) {
      var maps = (response.body as Map);
      servers = maps.keys.map((k) => Server.fromMap(k, maps[k])).toList();

      servers..sort();
      //(a, b) => a.name!.toLowerCase().compareTo(b.name!.toLowerCase()));
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

        placeOnClan(player);
        placeFavorites(player);
      });
    });

    players..sort();
  }

  void placeOnClan(Player player) {
    var nameFragments = '${player.tag} ${player.name}'.split(' ');

    nameFragments.forEach((element) {
      if (knownTags.contains(element.toUpperCase())) {
        clans
            .firstWhere((clan) => clan.name == element.toUpperCase())
            .players
            .add(player);
      }
    });
  }

  void placeFavorites(Player player) {
    var favCtrl = Get.find<FavoritesCtrl>();

    if (favCtrl.favorites.contains(player.baseName)) {
      onlineFavorites.add(player);
      offlineFavorites.remove(player.baseName);
    }
  }

  void refreshFavorites() {
    onlineFavorites = [];
    offlineFavorites = GetStorage().read('favorites');

    servers.forEach((server) {
      server.players?.forEach((player) {
        placeFavorites(player);
      });
    });

    update();
  }
}
