import 'package:flutter/material.dart';

class Constants {
  static const String noInternet = "Please validate your network connection";
  static const String productList = "Product List";
  static const String description = "Description";
  static const String addToCart = "Add to cart";
  static const String somethingWentWrong = "Oops something went wrong, Try again";
  static const String noDataFound = "No data found";
  static const String serverError = "Something went wrong while connecting with server";
  static const String tryAgain = "Try Again";
  static const String addedToCart = "Added to cart";
  static const String updatedToCart = "Updated item in cart";

}

enum LoaderState { loaded, loading, error, networkErr, noData }
