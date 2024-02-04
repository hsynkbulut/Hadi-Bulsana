import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hadi_bulsana/common/constants/colors.dart';
import 'package:hadi_bulsana/common/constants/sizes.dart';
import 'package:hadi_bulsana/common/constants/text_strings.dart';
import 'package:hadi_bulsana/common/helpers/helpers_functions.dart';
import 'package:hadi_bulsana/core/models/house_listing_model.dart';
import 'package:hadi_bulsana/core/viewmodel/homeowner_viewmodel/update_house_list_viewmodel.dart';
import 'package:hadi_bulsana/ui/views/homeowner/update_listings_detail/widgets/pick_images_update.dart';
import 'package:hadi_bulsana/ui/widgets/homeowner_widgets/host_text_form_field.dart';
import 'package:iconsax/iconsax.dart';

class UpdateHouseListingForm extends StatefulWidget {
  final HouseListing houseListing;
  final UpdateHouseListViewModel viewModel;

  const UpdateHouseListingForm({
    super.key,
    required this.houseListing,
    required this.viewModel,
  });

  @override
  State<UpdateHouseListingForm> createState() => _UpdateHouseListingFormState();
}

class _UpdateHouseListingFormState extends State<UpdateHouseListingForm> {
  @override
  void initState() {
    super.initState();
    // İlan bilgilerini doldurma
    widget.viewModel.titleController.text = widget.houseListing.title;
    widget.viewModel.descriptionController.text =
        widget.houseListing.description;
    widget.viewModel.priceController.text =
        widget.houseListing.price.toString();
    widget.viewModel.roomController.text = widget.houseListing.room;
    widget.viewModel.livingRoomController.text = widget.houseListing.livingRoom;
    widget.viewModel.kitchenController.text = widget.houseListing.kitchen;
    widget.viewModel.cityController.text = widget.houseListing.city;
    widget.viewModel.districtController.text = widget.houseListing.district;
    widget.viewModel.neighbourhoodController.text =
        widget.houseListing.neighborhood;
    widget.viewModel.streetController.text = widget.houseListing.street;
    widget.viewModel.alleyController.text = widget.houseListing.alley;
    widget.viewModel.apartmentNameController.text =
        widget.houseListing.apartmentName;
    widget.viewModel.buildingNoController.text =
        widget.houseListing.buildingNo.toString();
    widget.viewModel.flatNoController.text =
        widget.houseListing.flatNo.toString();
    widget.viewModel.phoneNumberController.text =
        widget.houseListing.phoneNumber;
    widget.viewModel.emailController.text = widget.houseListing.email;
    widget.viewModel.isRented = widget.houseListing.isRented;
    widget.viewModel.selectedImages = widget.houseListing.photos
            ?.map((photoPath) => File(photoPath))
            .toList() ??
        [];
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final height = THelperFunctions.screenHeight(context);
    final width = THelperFunctions.screenWidth(context);
    //final Size screenSize = THelperFunctions.screenSize(context);

    return Form(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'İLAN DETAYLARI',
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                color: dark ? AppColors.whiteColor : AppColors.dark,
                fontFamily: 'SignikaNegative',
                fontWeight: FontWeight.bold,
              ),
        ),
        Divider(
          thickness: 2,
          color: dark ? AppColors.whiteColor : AppColors.grey,
        ),
        const SizedBox(height: TSizes.spaceBtwInputFields),

        /// İlan başlığı
        HostTextFormField(
          keyboardType: TextInputType.text,
          labelText: TTexts.listingTitle,
          prefixIcon: Iconsax.textalign_center,
          maxLength: 30,
          controller: widget.viewModel.titleController,
          maxLines: 1, //max. 1 satır yüksekliğinde
        ),
        const SizedBox(height: TSizes.spaceBtwInputFields),

        /// İlan durumu (Kiralık mı değil mi?)
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Kiralık',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: MaterialStateColor.resolveWith((states) =>
                      dark ? AppColors.whiteColor : AppColors.primaryColor2)),
            ),
            Switch(
              value: widget.viewModel.isRented,
              onChanged: (value) {
                setState(() {
                  widget.viewModel.isRented = value;
                });
              },
              activeTrackColor: AppColors.primaryColor2,
              activeColor: AppColors.whiteColor,
            ),
            Text(
              'Tutuldu',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: MaterialStateColor.resolveWith((states) =>
                      dark ? AppColors.whiteColor : AppColors.primaryColor2)),
            ),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwInputFields),

        /// İlan Açıklaması
        HostTextFormField(
          keyboardType: TextInputType.text,
          labelText: TTexts.listingDescription,
          prefixIcon: Iconsax.document_text,
          maxLength: 400,
          minLines: 4,
          maxLines: 4,
          showCounter: true,
          controller: widget.viewModel.descriptionController,
        ),
        const SizedBox(height: TSizes.spaceBtwInputFields),

        /// Fiyat
        HostTextFormField(
          keyboardType: TextInputType.number,
          labelText: TTexts.listingPrice,
          prefixIcon: Iconsax.money5,
          maxLength: 10,
          controller: widget.viewModel.priceController,
          maxLines: 1, //max. 1 satır yüksekliğinde
        ),
        const SizedBox(height: TSizes.spaceBtwInputFields),

        /// Oda,salon,mutfak sayısı
        Row(
          children: [
            /// Oda
            Expanded(
              child: HostTextFormField(
                keyboardType: TextInputType.number,
                labelText: TTexts.numberOfRooms,
                prefixIcon: FontAwesomeIcons.bed,
                maxLength: 1,
                controller: widget.viewModel.roomController,
                maxLines: 1, //max. 1 satır yüksekliğinde
              ),
            ),
            const SizedBox(width: TSizes.spaceBtwInputFields),

            /// Salon
            Expanded(
              child: HostTextFormField(
                keyboardType: TextInputType.number,
                labelText: TTexts.numberOfLivingRooms,
                prefixIcon: FontAwesomeIcons.restroom,
                maxLength: 1,
                controller: widget.viewModel.livingRoomController,
                maxLines: 1, //max. 1 satır yüksekliğinde
              ),
            ),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwInputFields),

        /// Mutfak
        HostTextFormField(
          keyboardType: TextInputType.number,
          labelText: TTexts.numberOfKitchens,
          prefixIcon: FontAwesomeIcons.kitchenSet,
          maxLength: 1,
          controller: widget.viewModel.kitchenController,
          maxLines: 1, //max. 1 satır yüksekliğinde
        ),
        const SizedBox(height: TSizes.spaceBtwInputFields),

        Text(
          'ADRES BİLGİLERİ',
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                color: dark ? AppColors.whiteColor : AppColors.dark,
                fontFamily: 'SignikaNegative',
                fontWeight: FontWeight.bold,
              ),
        ),
        Divider(
          thickness: 2,
          color: dark ? AppColors.whiteColor : AppColors.grey,
        ),
        const SizedBox(height: TSizes.spaceBtwInputFields),

        /// İl
        HostTextFormField(
          keyboardType: TextInputType.text,
          labelText: TTexts.city,
          prefixIcon: Iconsax.buildings,
          maxLength: 20,
          controller: widget.viewModel.cityController,
          maxLines: 1, //max. 1 satır yüksekliğinde
        ),
        const SizedBox(height: TSizes.spaceBtwInputFields),

        /// İlçe
        HostTextFormField(
          keyboardType: TextInputType.text,
          labelText: TTexts.district,
          prefixIcon: Iconsax.buildings,
          maxLength: 25,
          controller: widget.viewModel.districtController,
          maxLines: 1, //max. 1 satır yüksekliğinde
        ),
        const SizedBox(height: TSizes.spaceBtwInputFields),

        /// Mahalle
        HostTextFormField(
          keyboardType: TextInputType.text,
          labelText: TTexts.neighborhood,
          prefixIcon: Iconsax.building,
          maxLength: 30,
          controller: widget.viewModel.neighbourhoodController,
          maxLines: 1, //max. 1 satır yüksekliğinde
        ),
        const SizedBox(height: TSizes.spaceBtwInputFields),

        /// Cadde, Sokak
        Row(
          children: [
            Expanded(
              child: HostTextFormField(
                keyboardType: TextInputType.text,
                labelText: TTexts.street,
                prefixIcon: Iconsax.candle,
                maxLength: 30,
                controller: widget.viewModel.streetController,
                maxLines: 1, //max. 1 satır yüksekliğinde
              ),
            ),
            const SizedBox(width: TSizes.spaceBtwInputFields),
            Expanded(
              child: HostTextFormField(
                keyboardType: TextInputType.text,
                labelText: TTexts.alley,
                prefixIcon: Iconsax.building_3,
                maxLength: 30,
                controller: widget.viewModel.alleyController,
                maxLines: 1, //max. 1 satır yüksekliğinde
              ),
            ),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwInputFields),

        // Apartman adı
        HostTextFormField(
          keyboardType: TextInputType.text,
          labelText: TTexts.apartmentName,
          prefixIcon: Iconsax.house,
          maxLength: 30,
          controller: widget.viewModel.apartmentNameController,
          maxLines: 1, //max. 1 satır yüksekliğinde
        ),
        const SizedBox(height: TSizes.spaceBtwInputFields),

        /// bina no, daire no
        Row(
          children: [
            // bina no
            Expanded(
              child: HostTextFormField(
                keyboardType: TextInputType.number,
                labelText: TTexts.buildingNo,
                prefixIcon: Icons.format_list_numbered_outlined,
                maxLength: 4,
                controller: widget.viewModel.buildingNoController,
                maxLines: 1, //max. 1 satır yüksekliğinde
              ),
            ),
            const SizedBox(width: TSizes.spaceBtwInputFields),

            // daire no
            Expanded(
              child: HostTextFormField(
                keyboardType: TextInputType.number,
                labelText: TTexts.flatNo,
                prefixIcon: Icons.format_list_numbered_outlined,
                maxLength: 4,
                controller: widget.viewModel.flatNoController,
                maxLines: 1, //max. 1 satır yüksekliğinde
              ),
            ),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwSections),

        Text(
          'İLETİŞİM BİLGİLERİ',
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                color: dark ? AppColors.whiteColor : AppColors.dark,
                fontFamily: 'SignikaNegative',
                fontWeight: FontWeight.bold,
              ),
        ),
        Divider(
          thickness: 2,
          color: dark ? AppColors.whiteColor : AppColors.grey,
        ),
        const SizedBox(height: TSizes.spaceBtwInputFields),

        /// Telefon no
        HostTextFormField(
          keyboardType: TextInputType.phone,
          labelText: TTexts.phoneNo,
          prefixIcon: Iconsax.call,
          maxLength: 11,
          controller: widget.viewModel.phoneNumberController,
          maxLines: 1, //max. 1 satır yüksekliğinde
        ),
        const SizedBox(height: TSizes.spaceBtwInputFields),

        /// email
        HostTextFormField(
          keyboardType: TextInputType.emailAddress,
          labelText: TTexts.email,
          prefixIcon: Iconsax.direct,
          maxLength: 40,
          controller: widget.viewModel.emailController,
          maxLines: 1, //max. 1 satır yüksekliğinde
        ),
        const SizedBox(height: TSizes.spaceBtwInputFields),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'FOTOĞRAF',
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: dark ? AppColors.whiteColor : AppColors.dark,
                    fontFamily: 'SignikaNegative',
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Divider(
              thickness: 2,
              color: dark ? AppColors.whiteColor : AppColors.grey,
            ),
            //const SizedBox(height: TSizes.spaceBtwInputFields),
            SizedBox(
              height: height * 0.32, // İstediğiniz boyutu ayarlayabilirsiniz
              width: width * 0.9,
              child: PickImagesUpdateScreen(viewModel: widget.viewModel),
            ),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwInputFields),

        /// Create Button
        SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () {
                  widget.viewModel
                      .updateHouseListing(context, widget.houseListing);
                  //Navigator.pushNamed(context, RouteConstant.hostDashboardRoute);
                },
                style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                    backgroundColor: MaterialStateColor.resolveWith(
                        (states) => AppColors.primaryColor2)),
                child: Container(
                    width: double.infinity,
                    height: 20.0, // veya istediğiniz yükseklik
                    alignment: Alignment.center,
                    child: Text(TTexts.createListingTitle,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge)))),
      ],
    ));
  }
}
