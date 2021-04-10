import 'package:dashspy/controllers/server_list_ctrl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TagListPage extends StatelessWidget {
  TagListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ServerListCtrl>(
      init: Get.find<ServerListCtrl>(),
      builder: (ctrl) {
        if (ctrl.loading) {
          return Center(child: CircularProgressIndicator());
        }

        var tagKeys = ctrl.tags.keys.toList();
        return ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: ctrl.tags.keys.length,
          itemBuilder: (context, index) {
            var key = tagKeys[index];
            var playerList = ctrl.tags[index];

            /*if (playerList == null || srv.players!.length == 0) {
              return Container();
            }
            Color? chipColor;

            if (srv.players!.length < 5) {
              // chipColor: Colors.orange;
            } else if (srv.players!.length < 8) {
              chipColor = Colors.orange;
            } else {
              chipColor = Colors.green;
            }
            */

            return Card(
              child: ListTile(
                title: Text(key),
                onTap: () {
                  // Get.to(() => ServerViewPage(server: srv));
                },
              ),
            );
          },
        );
      },
    );
  }
}
