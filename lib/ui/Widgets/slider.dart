import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:store/data/banner.dart';
import 'package:store/ui/Widgets/save_image_service.dart';

class BannerSlider extends StatelessWidget {
  final PageController _pageController = PageController();
  final List<BannerEntity> banners;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry? padding;

  final Size screenSize;
  BannerSlider({
    super.key,
    required this.banners,
    required this.screenSize,
    this.borderRadius = const BorderRadius.all(Radius.circular(0)),
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        //Slider shadow
        Positioned(
            bottom: 0,
            left: 30,
            right: 30,
            child: Container(
              padding: padding,
              height: 1,
              decoration: BoxDecoration(boxShadow: [BoxShadow(blurRadius: 7)]),
            )),

        //Slider items
        Padding(
          padding: padding!,
          child: AspectRatio(
            aspectRatio: 2,
            child: ClipRRect(
              borderRadius: borderRadius!,
              child: PageView.builder(controller: _pageController,
                itemCount: banners.length,
                itemBuilder: (context, index) => (index != banners.length - 1)
                    ? FittedBox(
                        fit: BoxFit.fill,
                        child: Stack(
                          children: [
                            SaveImageService(
                              imageUrl: banners[index].imageUrl,
                            ),
                            Positioned(
                              left: -0.5,
                              top: 50,
                              bottom: 50,
                              child: VerticalDivider(
                                width: 2,
                                thickness: 2,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      )
                    : SaveImageService(
                        imageUrl: banners[index].imageUrl,
                      ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 7,
          child: SmoothPageIndicator(
            controller: _pageController,
            count: banners.length,
            effect: WormEffect(spacing: 5,
                dotHeight: 6,
                dotColor: Theme.of(context).primaryColor.withOpacity(0.3),
                activeDotColor: Theme.of(context).primaryColor.withAlpha(255),
                type: WormType.thin),
          ),
        ),
      ],
    );
  }
}
