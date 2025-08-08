import 'package:carousel_slider/carousel_slider.dart' as carousel;
import 'package:flutter/material.dart';

class BannerImage {
  final String image;
  BannerImage({required this.image});
}

class SliderBarWidget extends StatefulWidget {
  final double? width;
  final double aspectRatio;
  final List<BannerImage> imgList;
  SliderBarWidget({super.key, required this.imgList, this.width, required this.aspectRatio});

  @override
  State<SliderBarWidget> createState() => _SliderBarWidgetState();
}

class _SliderBarWidgetState extends State<SliderBarWidget> {
  final _carouselController = carousel.CarouselController();
  int _current = 0;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: carousel.CarouselSlider(
          carouselController: _carouselController,
          options: carousel.CarouselOptions(
            aspectRatio: widget.aspectRatio,
            padEnds: true,
            initialPage: 0,
            enlargeCenterPage: true,
            autoPlay: true,
            autoPlayCurve: Curves.fastOutSlowIn,
            enableInfiniteScroll: true,
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            viewportFraction: widget.width == null ? 1 : widget.width! / MediaQuery.of(context).size.width,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
          ),
          items: widget.imgList
              .map((item) => Container(
                    child: Center(child: Image.asset(item.image, fit: BoxFit.fitWidth, width: widget.width ?? double.infinity)),
                  ))
              .toList(),
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: widget.imgList.asMap().entries.map((entry) {
          return GestureDetector(
            onTap: () => _carouselController.animateToPage(entry.key),
            child: Container(
              width: _current == entry.key ? 24.0 : 12.0,
              height: 12.0,
              margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Color(0xFF055FA7).withOpacity(_current == entry.key ? 0.9 : 0.4)),
            ),
          );
        }).toList(),
      ),
    ]);
  }
}
