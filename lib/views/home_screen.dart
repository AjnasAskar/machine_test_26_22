import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:machine_test_26_22/common/constants.dart';
import 'package:machine_test_26_22/common/extensions.dart';
import 'package:machine_test_26_22/common/route_generator.dart';
import 'package:machine_test_26_22/models/product_list_model.dart';
import 'package:machine_test_26_22/models/route_arguments.dart';
import 'package:machine_test_26_22/providers/app_data_provider.dart';
import 'package:machine_test_26_22/utils/theme_palette.dart';
import 'package:machine_test_26_22/widgets/common_app_bar.dart';
import 'package:machine_test_26_22/widgets/product_list_shimmer.dart';
import 'package:provider/provider.dart';

import '../utils/font_palette.dart';
import '../widgets/common_image_view.dart';
import '../widgets/error_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget productListTile(ProductListModel? productListModel) {
    return RefreshIndicator(
      onRefresh: () => fetchData(clearData: false),
      child: LayoutBuilder(builder: (context, constraints) {
        return GridView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: constraints.maxWidth / (constraints.maxHeight)),
          itemBuilder: (cxt, index) {
            SearchProductMobile? searchProductMobile =
                productListModel?.searchProductMobile?[index];
            if (searchProductMobile == null) return const SizedBox.shrink();
            return _ProductCard(searchProductMobile: searchProductMobile);
          },
          itemCount: productListModel?.searchProductMobile?.length ?? 0,
        );
      }),
    );
  }

  Widget widgetSwitcher(
      LoaderState loaderState, ProductListModel? productListModel) {
    switch (loaderState) {
      case LoaderState.loaded:
        return productListTile(productListModel);
      case LoaderState.loading:
        return const ProductListShimmer();
      case LoaderState.error:
        return ErrorScreen(
          title: Constants.serverError,
          onPressed: () => fetchData(),
        );
      case LoaderState.networkErr:
        return ErrorScreen(
          title: Constants.noInternet,
          onPressed: () => fetchData(),
        );
      case LoaderState.noData:
        return ErrorScreen(
          title: Constants.noDataFound,
          onPressed: () => fetchData(),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBar(
        context: context,
        pageTitle: Constants.productList,
        enableNavBack: false,
      ),
      body: Consumer<AppDataProvider>(
        builder: (context, provider, child) {
          return widgetSwitcher(
              provider.loaderState, provider.productListModel);
        },
      ),
    );
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  Future<void> fetchData({bool clearData = true}) async {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (clearData) context.read<AppDataProvider>().pageInit();
      context
          .read<AppDataProvider>()
          .getProductDataList(refreshLocal: !clearData);
    });
  }
}

class _ProductCard extends StatelessWidget {
  final SearchProductMobile? searchProductMobile;
  const _ProductCard({Key? key, this.searchProductMobile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int count = context
        .read<AppDataProvider>()
        .getLocalCartCount(searchProductMobile?.societyproductID ?? -1);
    return InkWell(
      onTap: () {
        context.read<AppDataProvider>().productDetailInit();
        Navigator.pushNamed(context, RouteGenerator.routeProductDetailScreen,
                arguments: RoutArguments(
                    id: searchProductMobile?.societyproductID,
                    title: searchProductMobile?.title))
            .then((value) => context
                .read<AppDataProvider>()
                .updateLoaderState(LoaderState.loaded));
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade200, width: 0.5)),
        child: Column(
          children: [
            Expanded(
                child: CommonImageView(
              image: searchProductMobile?.thumbImage ??
                  searchProductMobile?.originalImage ??
                  '',
            )),
            Container(
              color: HexColor('#fafafa'),
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Text(searchProductMobile?.title ?? '').avoidOverFlow(),
                  _QtyUpdateTile(
                    productId: searchProductMobile?.societyproductID,
                    count: count,
                  ),
                  Text(
                    'Rs ${searchProductMobile?.finalprice?.roundTo2 ?? '0.0'}',
                    style: FontPalette.black14Medium,
                  ).avoidOverFlow(),
                  const SizedBox(
                    height: 10,
                  ),
                  _CartBtn(
                    onPressed: count == 0
                        ? null
                        : () {
                            context.read<AppDataProvider>().updateCartCount(
                                id: searchProductMobile?.societyproductID);
                          },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _QtyUpdateTile extends StatelessWidget {
  final int? productId;
  final int count;
  const _QtyUpdateTile({Key? key, this.productId, this.count = 0})
      : super(key: key);

  Widget _tileBorder(
      {required Widget child,
      double? height,
      double? width,
      VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height ?? 25,
        width: width ?? 25,
        alignment: Alignment.center,
        decoration:
            BoxDecoration(border: Border.all(color: Colors.grey.shade300)),
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          _tileBorder(
              onTap: () => context
                  .read<AppDataProvider>()
                  .decreaseCount(id: productId, count: count),
              child: const Icon(
                Icons.remove,
                size: 15,
              )),
          const SizedBox(
            width: 5,
          ),
          Expanded(
              child: _tileBorder(
                  child: Text(
            '$count',
            textAlign: TextAlign.center,
          ))),
          const SizedBox(
            width: 5,
          ),
          _tileBorder(
              onTap: () => context
                  .read<AppDataProvider>()
                  .increaseCount(id: productId, count: count),
              child: const Icon(
                Icons.add,
                size: 15,
              ))
        ],
      ),
    );
  }
}

class _CartBtn extends StatelessWidget {
  final VoidCallback? onPressed;

  const _CartBtn({Key? key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: double.maxFinite,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
            primary: ThemePalette.primaryColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
        onPressed: onPressed,
        icon: const Icon(
          Icons.shopping_bag_outlined,
          color: Colors.white,
          size: 20,
        ),
        label: Text(
          Constants.addToCart,
          maxLines: 1,
          textAlign: TextAlign.center,
          style: FontPalette.white14Bold,
        ),
      ),
    );
  }
}
