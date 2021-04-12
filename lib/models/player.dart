import 'package:dashspy/data/known_tags.dart';

class Player implements Comparable<Player> {
  String? name;
  String? tag;
  int? level;
  String? serverName;
  int? team;

  Player({
    this.name,
    this.tag,
    this.level,
    this.serverName,
    this.team,
  });

  factory Player.fromMap(Map<String, dynamic> map, String serverName) {
    return Player(
      name: map['name'],
      tag: map['tag'],
      level: map['level'],
      team: map['team'],
      serverName: serverName,
    );
  }

  @override
  int compareTo(Player other) {
    var tagPos =
        (tag?.toLowerCase() ?? '').compareTo(other.tag?.toLowerCase() ?? '');
    var namePos = name!.toLowerCase().compareTo(other.name!.toLowerCase());

    return tagPos == 0 ? namePos : tagPos;
  }

  @override
  String toString() {
    return '$tag $name'; // ?? 'Unknown';
  }

  String get baseName {
    return name?.trim().split(' ')[0] ?? 'Unknown';
  }
}
