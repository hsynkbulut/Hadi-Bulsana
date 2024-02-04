import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ExploreCarouselSlider extends StatefulWidget {
  final List<String> images;
  const ExploreCarouselSlider({Key? key, required this.images})
      : super(key: key);

  @override
  State<ExploreCarouselSlider> createState() => _ExploreCarouselSliderState();
}

class _ExploreCarouselSliderState extends State<ExploreCarouselSlider> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            CarouselSlider(
              items: widget.images
                  .map((e) => Container(
                        color: Colors.white,
                        child: CachedNetworkImage(
                          imageUrl: widget.images[_currentIndex],
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(
                                        25)), //Resmi tutan container'ın kenarlığına ovallik verdik
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit
                                      .cover, // Resmin boyutu, ne kadarlık yer kaplayacağı
                                )),
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
                      ))
                  .toList(),
              options: CarouselOptions(
                  autoPlay: false,
                  enlargeCenterPage: true,
                  aspectRatio: 1.5,
                  viewportFraction: 1,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentIndex = index;
                    });
                  }),
            ),
            /*
            Positioned(
                child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back),
            ))
            */
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.images.map((e) {
            int index = widget.images.indexOf(e);
            return Container(
              width: 6,
              height: 6,
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 3),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentIndex == index
                      ? Colors.grey.shade600
                      : Colors.grey.shade400),
            );
          }).toList(),
        )
      ],
    );
  }
}
