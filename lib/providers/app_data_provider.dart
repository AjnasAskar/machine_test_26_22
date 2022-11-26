import 'package:flutter/material.dart';
import 'package:async/async.dart';
import 'package:machine_test_26_22/common/constants.dart';
import 'package:machine_test_26_22/models/product_details_model.dart';
import 'package:machine_test_26_22/models/product_list_model.dart';
import 'package:machine_test_26_22/utils/helpers.dart';

import '../services/base_provider_class.dart';
import '../utils/http_requests.dart';

class AppDataProvider extends ChangeNotifier with BaseProviderClass {
  final String _customerId = 'sNhZrOJ/BHc=';
  ProductListModel? productListModel;
  ProductDetailsModel? productDetailsModel;
  ProductInfoDetails? productInfoDetails;
  Map<int, int> localProductList = {};
  List<int> localProductIds = [];

  int get cartCount => localProductIds.length;

  Future<void> getProductDataList({bool refreshLocal = false}) async {
    updateLoaderState(LoaderState.loading);
    Map param = {
      "CustomerId": _customerId,
      "SocietyId": 1,
      "PageNumber": 1,
      "PageSize": 5
    };
    Result res = await serviceConfig.getProductDataList(param, refreshLocal);
    if (res.isValue) {
      productListModel = res.asValue!.value;
      updateLoaderState(LoaderState.loaded);
    } else {
      updateLoaderState(fetchError(res.asError!.error as Exceptions));
    }
  }

  Future<void> getProductDetailData(int productId) async {
    updateLoaderState(LoaderState.loading);
    Map param = {
      "CustomerId": _customerId,
      "SocietyId": 1,
      "ProductID": productId
    };
    Result res = await serviceConfig.getProductDetails(param);
    if (res.isValue) {
      productDetailsModel = res.asValue!.value;
      if ((productDetailsModel?.productDetails?.productInfoDetails ?? [])
          .isNotEmpty) {
        productInfoDetails =
            productDetailsModel?.productDetails?.productInfoDetails?.first;
      }
      updateLoaderState(LoaderState.loaded);
    } else {
      updateLoaderState(fetchError(res.asError!.error as Exceptions));
    }
  }

  void _updateLocalProduct({required int? id, required int count}) {
    if (id != null) {
      localProductList[id] = count;
      notifyListeners();
    }
  }

  void increaseCount({required int? id, required int count}) {
    _updateLocalProduct(id: id, count: count + 1);
  }

  int getLocalCartCount(int id) {
    return localProductList.containsKey(id) ? (localProductList[id] ?? 0) : 0;
  }

  void decreaseCount({required int? id, required int count}) {
    if (count > 0) {
      _updateLocalProduct(id: id, count: count - 1);
    }
  }

  void updateCartCount({required int? id}) {
    if (id != null && !localProductIds.contains(id)) {
      localProductIds.add(id);
      Helpers.successToast(Constants.addToCart);
    } else {
      Helpers.successToast(Constants.updatedToCart);
    }
    localProductList.remove(id);
    notifyListeners();
  }

  @override
  void pageInit() {
    productListModel = null;
    loaderState = LoaderState.loading;
    localProductList.clear();
    localProductIds.clear();
    notifyListeners();
    super.pageInit();
  }

  void productDetailInit() {
    productDetailsModel = null;
    productInfoDetails = null;
    loaderState = LoaderState.loading;
    notifyListeners();
  }

  @override
  void updateLoaderState(LoaderState state) {
    loaderState = state;
    notifyListeners();
  }
}
