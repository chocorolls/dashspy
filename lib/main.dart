import 'package:dashspy/controllers/server_list_ctrl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'controllers/favorites_ctrl.dart';
import 'nav.dart';

void main() async {
  await GetStorage.init();
  Get.put<FavoritesCtrl>(FavoritesCtrl(), permanent: true);
  Get.put<ServerListCtrl>(ServerListCtrl(), permanent: true);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DashSpy',
      theme: ThemeData.dark(),
      home: NavPage(),
    );
  }
}
