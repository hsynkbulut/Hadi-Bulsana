import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomCarouselSlider extends StatefulWidget {
  final List<String> images;
  final List<String> captions;
  const CustomCarouselSlider({
    Key? key,
    required this.images,
    required this.captions,
  }) : super(key: key);

  @override
  State<CustomCarouselSlider> createState() => _CustomCarouselSliderState();
}

class _CustomCarouselSliderState extends State<CustomCarouselSlider> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    const int maxImages = 3;
    final int itemCount =
        widget.images.length > maxImages ? maxImages : widget.images.length;

    return Column(
      children: [
        Stack(
          children: [
            CarouselSlider(
              items: List.generate(itemCount, (index) {
                return Builder(
                  builder: (BuildContext context) {
                    return Stack(
                      children: [
                        CachedNetworkImage(
                          imageUrl: widget.images[index],
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          placeholder: (context, url) => Shimmer.fromColors(
                            highlightColor: Colors.white,
                            baseColor: Colors.grey.shade300,
                            child: Container(
                              color: Colors.grey.shade300,
                            ),
                          ),
                          errorWidget: (context, url, error) => const Center(
                            child: Icon(
                              Icons.error_outline,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 8.0,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                  bottomRight: Radius.circular(25),
                                  bottomLeft: Radius.circular(25)),
                              color: Colors.black.withOpacity(0.5),
                            ),
                            child: Text(
                              widget.captions[index],
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              }).toList(),
              options: CarouselOptions(
                autoPlay: false,
                enlargeCenterPage: true,
                aspectRatio: 1.5,
                viewportFraction: 1,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(itemCount, (index) {
            return Container(
              width: 6,
              height: 6,
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 3),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentIndex == index
                    ? Colors.grey.shade600
                    : Colors.grey.shade400,
              ),
            );
          }),
        )
      ],
    );
  }
}
