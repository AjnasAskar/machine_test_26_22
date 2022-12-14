import 'package:hive/hive.dart';

class HiveServices {
  static const String generalAppBox = 'general_app_box';
  static const String productDataList = 'product_data_list';

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


}