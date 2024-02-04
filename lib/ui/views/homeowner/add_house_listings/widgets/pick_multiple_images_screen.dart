import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:hadi_bulsana/common/constants/colors.dart';
import 'package:hadi_bulsana/common/constants/sizes.dart';
import 'package:hadi_bulsana/common/helpers/helpers_functions.dart';
import 'package:hadi_bulsana/core/viewmodel/homeowner_viewmodel/add_house_list_viewmodel.dart';
import 'package:iconsax/iconsax.dart';
import 'package:images_picker/images_picker.dart';

class PickMultipleImagesScreen extends StatefulWidget {
  final AddHouseListViewModel viewModel;

  const PickMultipleImagesScreen({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  @override
  State<PickMultipleImagesScreen> createState() =>
      _PickMultipleImagesScreenState();
}

class _PickMultipleImagesScreenState extends State<PickMultipleImagesScreen> {
  final ValueNotifier<bool> attachMultipleImages = ValueNotifier<bool>(false);
  List compressedPhotosList = ["place_holder"];
  int maxImagesCount = 5;

  pickPhotos() async {
    List<Media>? photosList = [];
    photosList = await ImagesPicker.pick(
      count: ((compressedPhotosList.isNotEmpty) &&
              (compressedPhotosList.length > 1))
          ? (maxImagesCount + 1 - compressedPhotosList.length)
          : maxImagesCount,
      pickType: PickType.all,
      language: Language.English, //Dili
      cropOpt: CropOption(
        aspectRatio: const CropAspectRatio(600, 400),
      ),
    );

    if (photosList != null && photosList.isNotEmpty && photosList.isNotEmpty) {
      List<File> updatedList = [];
      for (int i = 0; i < photosList.length; i++) {
        XFile? photoCompressedFile =
            await compressImage(File(photosList[i].path));
        if (photoCompressedFile != null) {
          setState(() {
            // Resimlerin sıkıştırılmış versiyonlarını listeye ekle
            compressedPhotosList.add(photoCompressedFile.path);
            updatedList.add(File(photoCompressedFile
                .path)); // ViewModel'e göndermek için güncellenmiş listeye ekleniyor
          });
        }
      }
      attachMultipleImages.value = !attachMultipleImages.value;

      // ViewModel'e güncellenmiş liste gönderiliyor
      widget.viewModel.updateCompressedPhotosList(updatedList);
    }
  }

  Future<XFile?> compressImage(File file) async {
    final filePath = file.absolute.path;
    final lastIndex = filePath.lastIndexOf(RegExp(r'.png|.jp'));
    final splitted = filePath.substring(0, (lastIndex));
    final outPath = "${splitted}_out${filePath.substring(lastIndex)}";

    if (lastIndex == filePath.lastIndexOf(RegExp(r'.png'))) {
      final compressedImage = await FlutterImageCompress.compressAndGetFile(
          filePath, outPath,
          minWidth: 1000,
          minHeight: 1000,
          quality: 50,
          format: CompressFormat.png);
      return compressedImage;
    } else {
      final compressedImage = await FlutterImageCompress.compressAndGetFile(
        filePath,
        outPath,
        minWidth: 1000,
        minHeight: 1000,
        quality: 50,
      );
      return compressedImage;
    }
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final width = THelperFunctions.screenWidth(context);
    //final height = THelperFunctions.screenHeight(context);
    //final Size screenSize = THelperFunctions.screenSize(context);

    return SafeArea(
      child: ValueListenableBuilder<bool>(
        valueListenable: attachMultipleImages,
        builder: (context, snapshot, child) {
          return Scaffold(
            backgroundColor: dark ? AppColors.dark : AppColors.bColor,
            body: (compressedPhotosList.isNotEmpty &&
                    compressedPhotosList.length > 1)
                ? GridView.builder(
                    itemCount: (compressedPhotosList.isNotEmpty &&
                            compressedPhotosList.length > 1 &&
                            (compressedPhotosList.length - 1 == maxImagesCount))
                        ? compressedPhotosList.length - 1
                        : compressedPhotosList.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(16),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 4.0,
                            mainAxisSpacing: 4.0),
                    itemBuilder: (BuildContext context, int index) {
                      return ((compressedPhotosList[index] == "place_holder") &&
                              compressedPhotosList.length - 1 != maxImagesCount)
                          ? InkWell(
                              onTap: () async {
                                if (compressedPhotosList.length - 1 !=
                                    maxImagesCount) {
                                  pickPhotos();
                                }
                              },
                              child: Container(
                                width: width,
                                height: 105,
                                //color: AppColors.primaryColor2,
                                decoration: BoxDecoration(
                                  color: dark
                                      ? AppColors.whiteColor
                                      : AppColors.primaryColor2,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Center(
                                  child: Icon(
                                    Iconsax
                                        .gallery_add, //Resim yüklendikten sonra resmin yanında yeni resim eklemek için Resim yükleme ikonu
                                    size: 48.0,
                                    color: dark
                                        ? AppColors.primaryColor2
                                        : AppColors.whiteColor,
                                  ),
                                ),
                              ),
                            )
                          : Stack(
                              clipBehavior: Clip.none,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(4.0),
                                  child: Image.file(
                                    File(compressedPhotosList[index]),
                                    fit: BoxFit.fitHeight,
                                    width: width,
                                    height: 105,
                                    filterQuality: FilterQuality.low,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        width: width,
                                        height: 105,
                                        color: Colors.black,
                                      );
                                    },
                                  ),
                                ),
                                Positioned(
                                  bottom: 15,
                                  right: 8,
                                  child: InkWell(
                                    onTap: () async {
                                      compressedPhotosList.removeAt(index);
                                      attachMultipleImages.value =
                                          !attachMultipleImages.value;
                                    },
                                    child: const CircleAvatar(
                                      radius: 15.0,
                                      backgroundColor: Colors.black45,
                                      child: Icon(
                                        Iconsax
                                            .trash, //Resim yüklendikten sonra resmin sağ alt köşesindeki çöp kutusu ikonu
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            );
                    },
                  )
                : Center(
                    child: InkWell(
                      onTap: () async {
                        pickPhotos();
                      },
                      child: Container(
                        margin: const EdgeInsets.all(5),
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: dark
                              ? AppColors.whiteColor
                              : AppColors.primaryColor2,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Iconsax.camera,
                              color: dark
                                  ? AppColors.primaryColor2
                                  : AppColors.whiteColor,
                              size: 60,
                            ),
                            const SizedBox(height: TSizes.spaceBtwInputFields),
                            Text(
                              "Fotoğraf eklemek için tıkla",
                              style: TextStyle(
                                fontSize: 17.0,
                                fontWeight: FontWeight.bold,
                                color: dark
                                    ? AppColors.primaryColor2
                                    : AppColors.whiteColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    /*InkWell(
                      onTap: () {
                        pickPhotos();
                      },
                      child: const Text(
                        "Fotoğraf eklemek için tıkla",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    */
                  ),
          );
        },
      ),
    );
  }
}
