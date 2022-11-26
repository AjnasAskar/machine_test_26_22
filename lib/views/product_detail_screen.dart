import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:machine_test_26_22/common/constants.dart';
import 'package:machine_test_26_22/common/extensions.dart';
import 'package:machine_test_26_22/models/product_details_model.dart';
import 'package:machine_test_26_22/models/route_arguments.dart';
import 'package:machine_test_26_22/utils/font_palette.dart';
import 'package:machine_test_26_22/utils/theme_palette.dart';
import 'package:machine_test_26_22/widgets/common_image_view.dart';
import 'package:machine_test_26_22/widgets/network_connectivity.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../providers/app_data_provider.dart';
import '../widgets/common_app_bar.dart';
import '../widgets/error_screen.dart';
import '../widgets/product_detail_shimmer.dart';

class ProductDetailScreen extends StatefulWidget {
  final RoutArguments? routArguments;

  const ProductDetailScreen({Key? key, this.routArguments}) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  late final PageController pageController;
  Widget widgetSwitcher(
      LoaderState loaderState,
      ProductDetailsModel? productDetailsModel,
      ProductInfoDetails? productInfoDetails) {
    switch (loaderState) {
      case LoaderState.loaded:
        return mainWidget(false, productDetailsModel, productInfoDetails);
      case LoaderState.loading:
        return mainWidget(true, productDetailsModel, productInfoDetails);
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

  Widget mainWidget(bool isLoading, ProductDetailsModel? productDetailsModel,
      ProductInfoDetails? productInfoDetails) {
    int sliderLength =
        productDetailsModel?.productDetails?.productImageDetails?.length ?? 0;
    int count = context
        .read<AppDataProvider>()
        .getLocalCartCount(productInfoDetails?.societyProductID ?? -1);
    return NetworkConnectivity(
      onTap: () => fetchData(),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: (isLoading
                      ? const ProductDetailShimmer()
                      : Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: Column(
                            children: [
                              Container(
                                height: context.sh(size: 0.35),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.grey.shade300,
                                        width: 0.5)),
                                child: Stack(
                                  children: [
                                    PageView.builder(
                                      controller: pageController,
                                      itemBuilder: (context, index) {
                                        ProductImageDetails? image =
                                            productDetailsModel?.productDetails
                                                ?.productImageDetails?[index];
                                        return CommonImageView(
                                            image: image?.originalImage ??
                                                image?.thumbImage ??
                                                '');
                                      },
                                      itemCount: sliderLength,
                                    ),
                                    if (sliderLength > 1)
                                      Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 10),
                                          child: SmoothPageIndicator(
                                            controller: pageController,
                                            count: sliderLength == 0
                                                ? 1
                                                : sliderLength,
                                            effect: WormEffect(
                                                paintStyle:
                                                    PaintingStyle.stroke,
                                                activeDotColor:
                                                    HexColor('#0B71C2'),
                                                dotHeight: 7.0,
                                                dotWidth: 7.0,
                                                dotColor: HexColor('#989898')
                                                    .withOpacity(0.3)),
                                          ),
                                        ),
                                      )
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 25, bottom: 10),
                                child: Text(
                                  productInfoDetails?.title ?? '',
                                  style: FontPalette.black18Medium,
                                ).avoidOverFlow(),
                              ),
                              _QtyUpdateTile(
                                productId: productInfoDetails?.societyProductID,
                                count: count,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  'Rs ${productInfoDetails?.finalprice}',
                                  style: FontPalette.black22SemiBold,
                                ).avoidOverFlow(),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              _DescriptionTile(
                                description: productInfoDetails?.description,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ))
                  .animatedSwitch(),
            ),
          ),
          _CartBtn(
            onPressed: (isLoading || count == 0)
                ? null
                : () {
                    context.read<AppDataProvider>().updateCartCount(
                        id: productInfoDetails?.societyProductID);
                  },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBar(
        context: context,
        pageTitle: widget.routArguments?.title ?? '',
      ),
      body: Consumer<AppDataProvider>(
        builder: (context, provider, child) {
          return widgetSwitcher(provider.loaderState,
              provider.productDetailsModel, provider.productInfoDetails);
        },
      ),
    );
  }

  @override
  void initState() {
    pageController = PageController();
    fetchData();
    _animateSlider();
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void _animateSlider() {
    Future.delayed(const Duration(seconds: 2)).then((_) {
      if (pageController.hasClients) {
        int nextPage = pageController.page!.round() + 1;
        pageController
            .animateToPage(nextPage,
                duration: const Duration(seconds: 2), curve: Curves.linear)
            .then((_) => _animateSlider());
      }
    });
  }

  Future<void> fetchData() async {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context
          .read<AppDataProvider>()
          .getProductDetailData(widget.routArguments?.id ?? -1);
    });
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
        height: height ?? 45,
        width: width ?? 45,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade200),
            color: HexColor('#fafafa')),
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      child: Row(
        children: [
          _tileBorder(
              onTap: () => context
                  .read<AppDataProvider>()
                  .decreaseCount(id: productId, count: count),
              child: const Icon(
                Icons.remove,
              )),
          const SizedBox(
            width: 10,
          ),
          Expanded(
              child: _tileBorder(
                  child: Text(
            '$count',
            textAlign: TextAlign.center,
            style: FontPalette.black16Medium,
          ))),
          const SizedBox(
            width: 10,
          ),
          _tileBorder(
              onTap: () => context
                  .read<AppDataProvider>()
                  .increaseCount(id: productId, count: count),
              child: const Icon(
                Icons.add,
              ))
        ],
      ),
    );
  }
}

class _DescriptionTile extends StatelessWidget {
  final String? description;
  const _DescriptionTile({Key? key, this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Constants.description.toUpperCase(),
            style: FontPalette.white16Bold
                .copyWith(color: ThemePalette.primaryColor),
          ),
          Container(
            height: 2,
            width: double.maxFinite,
            margin: const EdgeInsets.only(top: 5, bottom: 15),
            color: ThemePalette.primaryColor,
          ),
          HtmlWidget(
            description ?? '',
            customStylesBuilder: (element) {
              if (element.localName == "table") {
                return {
                  'width': 'auto !important',
                  'height': 'auto',
                  'border': '1px solid #ccc'
                };
              }
              if (element.localName == "td") {
                return {'padding': '5px 10px'};
              }
              return null;
            },
          )
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
    return Container(
      height: 50,
      width: context.sw(size: 0.8),
      margin: const EdgeInsets.only(bottom: 20, top: 10),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
            primary: ThemePalette.primaryColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
        onPressed: onPressed,
        icon: const Icon(
          Icons.shopping_bag_outlined,
          color: Colors.white,
          size: 26,
        ),
        label: Text(
          Constants.addToCart,
          maxLines: 1,
          textAlign: TextAlign.center,
          style: FontPalette.white16Bold,
        ),
      ),
    );
  }
}
