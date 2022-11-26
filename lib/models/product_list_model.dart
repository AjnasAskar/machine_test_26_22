import '../utils/helpers.dart';

class ProductListModel {
  List<SearchProductMobile>? searchProductMobile;
  int? totalCount;

  ProductListModel({this.searchProductMobile, this.totalCount});

  ProductListModel.fromJson(Map<String, dynamic> json) {
    if (json['SearchProductMobile'] != null) {
      searchProductMobile = <SearchProductMobile>[];
      json['SearchProductMobile'].forEach((v) {
        searchProductMobile!.add(SearchProductMobile.fromJson(v));
      });
    }
    totalCount = Helpers.convertToInt(json['TotalCount']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (searchProductMobile != null) {
      data['SearchProductMobile'] =
          searchProductMobile!.map((v) => v.toJson()).toList();
    }
    data['TotalCount'] = totalCount;
    return data;
  }
}

class SearchProductMobile {
  int? societyproductID;
  String? title;
  String? originalImage;
  String? thumbImage;
  double? finalprice;
  double? mrp;
  int? totalCount;
  int? cartId;

  SearchProductMobile({
    this.societyproductID,
    this.title,
    this.originalImage,
    this.thumbImage,
    this.finalprice,
    this.mrp,
    this.totalCount,
    this.cartId,
  });

  SearchProductMobile.fromJson(Map<String, dynamic> json) {
    societyproductID = json['SocietyproductID'];
    title = json['Title'];
    originalImage = json['OriginalImage'];
    thumbImage = json['ThumbImage'];
    finalprice = Helpers.convertToDouble(json['Finalprice']);
    mrp = Helpers.convertToDouble(json['Mrp']);
    totalCount = Helpers.convertToInt(json['TotalCount']);
    cartId = json['CartId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['SocietyproductID'] = societyproductID;
    data['Title'] = title;
    data['OriginalImage'] = originalImage;
    data['ThumbImage'] = thumbImage;
    data['Finalprice'] = finalprice;
    data['Mrp'] = mrp;
    data['TotalCount'] = totalCount;
    data['CartId'] = cartId;
    return data;
  }
}
