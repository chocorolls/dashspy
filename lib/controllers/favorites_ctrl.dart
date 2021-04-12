import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class FavoritesCtrl extends GetxController {
  List<String> _favorites = [];
  GetStorage storage = GetStorage();

  //FavoritesCtrl() {}

  List<String> get favorites {
    _favorites =
        storage.read<List>('favorites')?.map((s) => s.toString()).toList() ??
            [];
    return _favorites;
  }

  bool addPlayer(String name) {
    var cleanedName = name;

    if (!_favorites.contains(cleanedName)) {
      _favorites.add(name);

      storage.write('favorites', _favorites);
      storage.save();
      return true;
    } else {
      return false;
    }
  }

  bool removePlayer(String name) {
    _favorites.remove(name);
    storage.write('favorites', _favorites);

    storage.save();

    return true;
  }
}
