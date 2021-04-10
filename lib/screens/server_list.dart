import 'package:dashspy/models/server.dart';
import 'package:dashspy/screens/server_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/server_list_ctrl.dart';

class ServerListPage extends StatefulWidget {
  ServerListPage({Key? key}) : super(key: key);

  @override
  _ServerListPageState createState() => _ServerListPageState();
}

class _ServerListPageState extends State<ServerListPage> {
  var searchCtrl = TextEditingController();
  bool hideEmpty = true;
  String mode = 'all';

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ServerListCtrl>(
      init: Get.find<ServerListCtrl>(),
      builder: (ctrl) {
        if (ctrl.loading) {
          return Center(child: CircularProgressIndicator());
        }

        return Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Wrap(
                  children: [
                    //ToggleButtons(children: children, isSelected: isSelected)
                    CheckboxListTile(
                      title: Text('Hide <5 players'),
                      value: hideEmpty,
                      onChanged: (val) {
                        setState(() {
                          hideEmpty = val!;
                        });
                      },
                    ),
                    ListTile(
                      title: Text('Show'),
                      subtitle: Text('tap to toggle'),
                      trailing: Text(mode),
                      onTap: () {
                        switch (mode) {
                          case 'all':
                            mode = 'public';
                            break;
                          case 'public':
                            mode = 'private';
                            break;
                          case 'private':
                            mode = 'all';
                            break;
                        }

                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: ctrl.servers.length,
                itemBuilder: (context, index) {
                  var srv = ctrl.servers[index];

                  if (srv.players == null || srv.players!.length == 0) {
                    return Container();
                  }

                  if (srv.players!.length < 5 && hideEmpty) {
                    return Container();
                  }

                  if (mode == 'public' && !srv.name!.contains('#')) {
                    return Container();
                  }

                  if (mode == 'private' && srv.name!.contains('#')) {
                    return Container();
                  }

                  return ServerTile(srv: srv);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class ServerTile extends StatelessWidget {
  const ServerTile({
    Key? key,
    required this.srv,
  }) : super(key: key);

  final Server srv;

  @override
  Widget build(BuildContext context) {
    Color? chipColor;

    if (srv.players!.length < 5) {
      // chipColor: Colors.orange;
    } else if (srv.players!.length < 8) {
      chipColor = Colors.orange;
    } else {
      chipColor = Colors.green;
    }

    return Card(
      child: ListTile(
        leading: SizedBox(
          width: 80,
          child: Chip(
            backgroundColor: chipColor,
            label: Text('${srv.players!.length} / 10'),
          ),
        ),
        title: Text(srv.name!.contains('#') ? '${srv.region}' : '${srv.name}'),
        subtitle: !srv.name!.contains('#')
            ? Text(srv.region ?? '')
            : Text(srv.name!.split('#')[1]),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              srv.map ?? srv.mode ?? '',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        onTap: () {
          Get.to(() => ServerViewPage(server: srv));
        },
      ),
    );
  }
}
