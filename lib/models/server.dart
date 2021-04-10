import 'package:dashspy/models/player.dart';

class Server {
  String? name;
  String? region;
  String? zone;
  String? mode;
  String? map;
  List<Player>? players;

  Server({
    this.name,
    this.region,
    this.zone,
    this.mode,
    this.map,
    this.players,
  });

  factory Server.fromMap(String name, Map<String, dynamic> map) {
    return Server(
      name: name,
      region: map['region'],
      zone: map['zone'],
      mode: map['mode'],
      map: map['map'] == 'ControlPoint_Stadium' ? 'Stadium' : map['map'],
      players: map['players'] != null
          ? (map['players'] as List)
              .map((p) => Player.fromMap(p, name))
              .toList()
          : [],
    );
  }
}
