import 'package:hive/hive.dart';
import 'package:machine_test_26_22/utils/helpers.dart';

class HiveServices {
  static const String generalAppBox = 'general_app_box';
  static const String productDataList = 'product_data_list';
  static const String cartCount = 'cart_count';

  static Future<void> saveData(
      {required String val, required String key}) async {
    if (Hive.isBoxOpen(generalAppBox)) {
      Box<dynamic> box = Hive.box(generalAppBox);
      box.put(key, val);
      box.close();
    } else {
      Box<dynamic> box = await Hive.openBox<dynamic>(generalAppBox);
      box.put(key, val);
      box.close();
    }
  }

  static Future<String> getDataList() async {
    String res = '';
    if (Hive.isBoxOpen(generalAppBox)) {
      Box<String> box = Hive.box(generalAppBox);
      res = box.get(productDataList) ?? '';
      box.close();
    } else {
      Box<String> box = await Hive.openBox<String>(generalAppBox);
      res = box.get(productDataList) ?? '';
      box.close();
    }
    return res;
  }

  static Future<int> getCartCount() async {
    String res = '';
    if (Hive.isBoxOpen(generalAppBox)) {
      Box<String> box = Hive.box(generalAppBox);
      res = box.get(cartCount) ?? '';
      box.close();
    } else {
      Box<String> box = await Hive.openBox<String>(generalAppBox);
      res = box.get(cartCount) ?? '';
      box.close();
    }
    return Helpers.convertToInt(res);
  }

}