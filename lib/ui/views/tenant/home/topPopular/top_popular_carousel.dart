import 'package:flutter/material.dart';
import 'package:hadi_bulsana/common/constants/colors.dart';
import 'package:hadi_bulsana/core/utils/gap.dart';
import 'package:hadi_bulsana/ui/views/tenant/home/topPopular/top_popular_screen.dart';
import 'package:hadi_bulsana/core/viewmodel/home_model.dart';

class TopPopularCarousel extends StatelessWidget {
  const TopPopularCarousel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Column(
      //destination text
      children: [
        // container for pictures
        SizedBox(
          height: 280.0,
          //color: Colors.blue,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: destinations.length,
            itemBuilder: (BuildContext context, int index) {
              Popular populars = destinations[index];
              return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => TopPopularScreen(popular: populars),
                  ),
                ),
                child: Container(
                  margin: const EdgeInsets.all(5),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: AppColors.whiteColor,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        alignment: Alignment
                            .bottomRight, //Yıldız ikonunun, resmin üzerindeki konumu
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image(
                              fit: BoxFit.cover,
                              height: 160,
                              image: AssetImage(populars.imageUrl),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: AppColors.whiteColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      size: 18,
                                      color: AppColors.ratingColor,
                                    ),
                                    Gap(
                                        isWidth: true,
                                        isHeight: false,
                                        width: width * 0.01),
                                    Text(
                                      populars.rating!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Gap(
                          isWidth: false,
                          isHeight: true,
                          height: height * 0.01),
                      Text(
                        '${populars.room}+${populars.livingRoom} Kiralık Apart',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                color: AppColors.darkerGrey),
                      ),
                      Gap(
                          isWidth: false,
                          isHeight: true,
                          height: height * 0.01),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_pin,
                            color: Colors.grey,
                          ),
                          Text(
                            '${populars.city}, ${populars.district}',
                            style: const TextStyle(color: AppColors.darkGrey),
                          ),
                        ],
                      ),
                      Text(
                        '${populars.prices} TL/aylık',
                        style: const TextStyle(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
