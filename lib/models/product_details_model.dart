import 'package:machine_test_26_22/utils/helpers.dart';

class ProductDetailsModel {
  ProductDetails? productDetails;

  ProductDetailsModel({this.productDetails});

  ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    productDetails = json['ProductDetails'] != null
        ? ProductDetails.fromJson(json['ProductDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (productDetails != null) {
      data['ProductDetails'] = productDetails!.toJson();
    }
    return data;
  }
}

class ProductDetails {
  List<ProductInfoDetails>? productInfoDetails;
  List<ProductImageDetails>? productImageDetails;

  ProductDetails({this.productInfoDetails, this.productImageDetails});

  ProductDetails.fromJson(Map<String, dynamic> json) {
    if (json['productInfoDetails'] != null) {
      productInfoDetails = <ProductInfoDetails>[];
      json['productInfoDetails'].forEach((v) {
        productInfoDetails!.add(ProductInfoDetails.fromJson(v));
      });
    }
    if (json['productImageDetails'] != null) {
      productImageDetails = <ProductImageDetails>[];
      json['productImageDetails'].forEach((v) {
        productImageDetails!.add(ProductImageDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (productInfoDetails != null) {
      data['productInfoDetails'] =
          productInfoDetails!.map((v) => v.toJson()).toList();
    }
    if (productImageDetails != null) {
      data['productImageDetails'] =
          productImageDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductInfoDetails {
  int? productID;
  int? societyProductID;
  String? title;
  String? description;
  double? mrp;
  double? finalprice;

  ProductInfoDetails({
    this.productID,
    this.societyProductID,
    this.title,
    this.description,
    this.mrp,
    this.finalprice,
  });

  ProductInfoDetails.fromJson(Map<String, dynamic> json) {
    productID = json['ProductID'];
    societyProductID = json['SocietyproductID'];
    title = json['Title'];
    description = json['Description'];
    mrp = Helpers.convertToDouble(json['Mrp']);
    finalprice = Helpers.convertToDouble(json['Finalprice']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ProductID'] = productID;
    data['SocietyproductID'] = societyProductID;
    data['Title'] = title;
    data['Description'] = description;
    data['Mrp'] = mrp;
    data['Finalprice'] = finalprice;
    return data;
  }
}

class ProductImageDetails {
  String? originalImage;
  String? thumbImage;

  ProductImageDetails({this.originalImage, this.thumbImage});

  ProductImageDetails.fromJson(Map<String, dynamic> json) {
    originalImage = json['OriginalImage'];
    thumbImage = json['ThumbImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['OriginalImage'] = originalImage;
    data['ThumbImage'] = thumbImage;
    return data;
  }
}
