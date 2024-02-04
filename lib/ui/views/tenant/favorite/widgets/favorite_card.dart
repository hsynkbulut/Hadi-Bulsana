import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hadi_bulsana/common/constants/colors.dart';
import 'package:iconsax/iconsax.dart';

class FavoriteCard extends StatelessWidget {
  final String title, loc, path;
  final double price;
  final bool isHeart;
  const FavoriteCard(
      {Key? key,
      required this.title,
      required this.loc,
      required this.path,
      required this.isHeart,
      required this.price})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final height = MediaQuery.of(context).size.height * 1;
    //final width = MediaQuery.of(context).size.width * 1;
    return InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppColors.whiteColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment:
                  Alignment.topRight, //Kalp ikonunun, resmin üzerindeki konumu
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image(
                    width: 100,
                    fit: BoxFit.cover,
                    height: 100,
                    image: AssetImage(path),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(
                      CupertinoIcons.heart_fill,
                      size: 20,
                      color: AppColors.primaryColor,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: AppColors.primaryColor),
                ),
                const SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(
                      Iconsax.location5,
                      color: AppColors.darkGrey,
                      size: 16,
                    ),
                    const SizedBox(width: 2),
                    Text(
                      loc,
                      style: const TextStyle(
                          color: AppColors.darkGrey,
                          fontSize: 16,
                          fontFamily: 'SignikaNegative'),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(
                      Iconsax.money5,
                      color: AppColors.darkGrey,
                      size: 16,
                    ),
                    const SizedBox(width: 2),
                    Text(
                      '$price TL/aylık',
                      style: const TextStyle(
                          fontSize: 16,
                          fontFamily: 'SignikaNegative',
                          color: AppColors.darkGrey,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
