import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hadi_bulsana/common/constants/image_paths.dart';
import 'package:hadi_bulsana/core/utils/button_round.dart';
import 'package:hadi_bulsana/common/constants/colors.dart';
import 'package:hadi_bulsana/core/utils/gap.dart';
import 'package:iconsax/iconsax.dart';

class TopPopularScreen extends StatefulWidget {
  final dynamic popular;

  const TopPopularScreen({super.key, required this.popular});
  @override
  State<TopPopularScreen> createState() => _TopPopularScreenState();
}

class _TopPopularScreenState extends State<TopPopularScreen> {
  @override
  Widget build(BuildContext context) {
    //final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.bColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 330,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0.0, 2.0),
                          blurRadius: 6.0)
                    ],
                  ),
                  child: Hero(
                    tag: widget.popular.imageUrl,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20)),
                      child: Image(
                        image: AssetImage(widget.popular.imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),

                //adding back arrow button
                Padding(
                    padding:
                        const EdgeInsets.only(top: 40, left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: AppColors.whiteColor,
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.arrow_back_ios_outlined,
                              size: 24.0,
                              color: AppColors.primaryColor,
                            ),
                            color: Colors.black,
                            iconSize: 20.0,
                          ),
                        ),
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: AppColors.whiteColor,
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: Center(
                            child: IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Iconsax.heart,
                                  size: 24.0,
                                  color: AppColors.primaryColor,
                                )),
                          ),
                        ),
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 285, left: 10, right: 20),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      width: 70,
                      height: 35,
                      padding: const EdgeInsets.all(7),
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor.withOpacity(0.97),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.star,
                            size: 22,
                            color: AppColors.primaryColor,
                          ),
                          Gap(
                              isWidth: true,
                              isHeight: false,
                              width: width * 0.02),
                          Text(
                            '${widget.popular.rating}',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: AppColors.primaryColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${widget.popular.room}+${widget.popular.livingRoom} Kiralık Apart',
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: [
                              const Icon(
                                Iconsax.location,
                                size: 23,
                                color: AppColors.darkGrey,
                              ),
                              Text(
                                '${widget.popular.city!}, ${widget.popular.district!}',
                                style: const TextStyle(
                                  color: AppColors.darkGrey,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Text(
                        '${widget.popular.prices} TL/aylık',
                        style: const TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Container(
                          height: 75,
                          width: MediaQuery.of(context).size.width * 0.2,
                          decoration: BoxDecoration(
                              color: AppColors.primaryColor.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.white24)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const FaIcon(
                                FontAwesomeIcons.bed,
                                size: 18.0,
                                color: AppColors.primaryColor,
                              ),
                              Text(
                                '${widget.popular.room} Oda',
                                style: const TextStyle(
                                    color: AppColors.primaryColor),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          height: 75,
                          width: MediaQuery.of(context).size.width * 0.2,
                          decoration: BoxDecoration(
                              color: AppColors.primaryColor.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.white24)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const FaIcon(
                                FontAwesomeIcons.restroom,
                                size: 18.0,
                                color: AppColors.primaryColor,
                              ),
                              Text(
                                '${widget.popular.livingRoom} Salon',
                                style: const TextStyle(
                                    color: AppColors.primaryColor),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          height: 75,
                          width: MediaQuery.of(context).size.width * 0.2,
                          decoration: BoxDecoration(
                              color: AppColors.primaryColor.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.white24)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const FaIcon(
                                FontAwesomeIcons.kitchenSet,
                                size: 18.0,
                                color: AppColors.primaryColor,
                              ),
                              Text(
                                '${widget.popular.kitchen} Mutfak',
                                style: const TextStyle(
                                    color: AppColors.primaryColor),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25.0),
                  const Text(
                    'Açıklama',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 6.0,
                  ),
                  Text(
                    widget.popular.description,
                    style:
                        const TextStyle(fontSize: 13.0, color: Colors.black45),
                  ),
                  const SizedBox(height: 25.0),
                  Container(
                    height: 150,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.white24)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              /*
                              Container(
                                width: 45,
                                height: 45,
                                decoration: BoxDecoration(
                                  color: AppColors.darkGrey,
                                  borderRadius: BorderRadius.circular(7),
                                ),
                                child: Image.asset(
                                  ImagePaths.homeOwner,
                                ),
                              ),
                              */
                              const CircleAvatar(
                                radius: 30,
                                backgroundColor: AppColors.ratingColor,
                                child: Padding(
                                  padding: EdgeInsets.all(3), // Border radius
                                  child: ClipOval(
                                      child: Image(
                                    fit: BoxFit.fill,
                                    image: AssetImage(ImagePaths.homeOwner),
                                  )),
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.popular.homeOwner,
                                    style: const TextStyle(
                                        color: AppColors.primaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  const Text(
                                    'İlan Sahibi',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 15.0),
                          RoundButton(title: "İletişime Geç", onTap: () {})
                        ],
                      ),
                    ),
                  ),
                  //const SizedBox(height: 10.0),
                  //RoundButton(title: "İletişime Geç", onTap: () {})
                  const SizedBox(height: 15.0),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
