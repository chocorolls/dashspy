class Player {
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
}
