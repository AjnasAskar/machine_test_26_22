import 'dart:convert';

import 'package:async/async.dart';
import 'package:machine_test_26_22/models/product_details_model.dart';
import 'package:machine_test_26_22/models/product_list_model.dart';

import '../utils/http_requests.dart';
import 'hive_services.dart';

class ServiceConfig {
  Future<Result> getProductDataList(Map param, bool refreshLocal) async {
    try {
      final localRes = await HiveServices.getDataList();
      if (localRes.isNotEmpty && !refreshLocal) {
        ProductListModel productListModel =
            ProductListModel.fromJson(jsonDecode(localRes));
        return Result.value(productListModel);
      } else {
        Result res =
            await HttpReq.postRequest('listproducts', parameters: param);
        if (res.isError) {
          return res;
        } else {
          var response = res.asValue!.value;
          ProductListModel productListModel =
              ProductListModel.fromJson(response);
          if (productListModel.searchProductMobile != null) {
            HiveServices.saveData(
                val: jsonEncode(response), key: HiveServices.productDataList);
            return Result.value(productListModel);
          } else {
            return Result.error(Exceptions.noData);
          }
        }
      }
    } catch (_) {
      return Result.error(Exceptions.err);
    }
  }

  Future<Result> getProductDetails(Map param) async {
    try {
      Result res =
          await HttpReq.postRequest('productdetails', parameters: param);
      if (res.isError) {
        return res;
      } else {
        var response = res.asValue!.value;
        ProductDetailsModel productDetailsModel =
            ProductDetailsModel.fromJson(response);
        if (productDetailsModel.productDetails != null) {
          return Result.value(productDetailsModel);
        } else {
          return Result.error(Exceptions.noData);
        }
      }
    } catch (_) {
      return Result.error(Exceptions.err);
    }
  }
}
