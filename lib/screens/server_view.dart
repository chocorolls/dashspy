import 'package:dashspy/models/server.dart';
import 'package:flutter/material.dart';

class ServerViewPage extends StatelessWidget {
  final Server server;
  const ServerViewPage({Key? key, required this.server}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(server.name ?? '')),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: server.players!.length,
        itemBuilder: (context, index) {
          var player = server.players![index];
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
              title: Row(
                children: [
                  player.tag != null
                      ? Text(
                          player.tag! + ' ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        )
                      : Container(),
                  Text(player.name?.trim() ?? ''),
                ],
              ),
              subtitle: Text(player.serverName ?? ''),

              // trailing: Text(srv['mode']),
              //onTap: () {
              //  Get.to(() =>
              //      ServerViewPage(name: servers[index], server: srv));
              //},
            ),
          );
        },
      ),
    );
  }
}
