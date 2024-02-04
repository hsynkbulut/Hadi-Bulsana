import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hadi_bulsana/common/constants/colors.dart';
import 'package:hadi_bulsana/common/constants/sizes.dart';
import 'package:hadi_bulsana/common/constants/text_strings.dart';
import 'package:hadi_bulsana/common/helpers/helpers_functions.dart';
import 'package:hadi_bulsana/core/viewmodel/homeowner_viewmodel/add_house_list_viewmodel.dart';
import 'package:hadi_bulsana/core/viewmodel/cities.dart';
import 'package:hadi_bulsana/core/viewmodel/room_options.dart';
import 'package:hadi_bulsana/ui/views/homeowner/add_house_listings/widgets/pick_multiple_images_screen.dart';
import 'package:hadi_bulsana/ui/widgets/homeowner_widgets/custom_dropdown_form_field.dart';
import 'package:hadi_bulsana/ui/widgets/homeowner_widgets/host_text_form_field.dart';
import 'package:iconsax/iconsax.dart';

class AddHouseListingForm extends StatefulWidget {
  const AddHouseListingForm({
    super.key,
  });

  @override
  State<AddHouseListingForm> createState() => _AddHouseListingFormState();
}

class _AddHouseListingFormState extends State<AddHouseListingForm> {
  //final viewModel = AddHouseListViewModel();
  final AddHouseListViewModel viewModel = AddHouseListViewModel();
  bool isAddListing = false;

  void _createHouseListing(BuildContext context) async {
    setState(() {
      isAddListing = true; // Çıkış işlemi başladığında bayrağı true yap
    });

    // İşlemi gerçekleştir
    await viewModel.createHouseListing(context);

    setState(() {
      isAddListing = false; // İşlem tamamlandığında bayrağı false yap
    });
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
          controller: viewModel.titleController,
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
              value: viewModel.isRented,
              onChanged: (value) {
                setState(() {
                  viewModel.isRented = value;
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
          controller: viewModel.descriptionController,
        ),
        const SizedBox(height: TSizes.spaceBtwInputFields),

        /// Fiyat
        HostTextFormField(
          keyboardType: TextInputType.number,
          labelText: TTexts.listingPrice,
          prefixIcon: Iconsax.money5,
          maxLength: 10,
          controller: viewModel.priceController,
          maxLines: 1, //max. 1 satır yüksekliğinde
        ),
        const SizedBox(height: TSizes.spaceBtwInputFields),

        /// Oda,salon,mutfak sayısı
        Row(
          children: [
            /// Oda
            Expanded(
              child: CustomDropdownFormField(
                labelText: TTexts.numberOfRooms,
                prefixIcon: FontAwesomeIcons.bed,
                value: RoomOptions.selectedRoom,
                items: RoomOptions.roomNumbersList,
                onChanged: (val) {
                  setState(() {
                    RoomOptions.selectedRoom = val as String;
                    viewModel.selectedRoom = val;
                  });
                },
              ),
            ),
            const SizedBox(width: TSizes.spaceBtwInputFields),

            /// Salon
            Expanded(
              child: CustomDropdownFormField(
                labelText: TTexts.numberOfLivingRooms,
                prefixIcon: FontAwesomeIcons.restroom,
                value: RoomOptions.selectedLivingRoom,
                items: RoomOptions.livingRoomNumbersList,
                onChanged: (val) {
                  setState(() {
                    RoomOptions.selectedLivingRoom = val as String;
                    viewModel.selectedLivingRoom = val;
                  });
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwInputFields),

        /// Mutfak
        CustomDropdownFormField(
          labelText: TTexts.numberOfKitchens,
          prefixIcon: FontAwesomeIcons.kitchenSet,
          value: RoomOptions.selectedKitchen,
          items: RoomOptions.kitchenNumbersList,
          onChanged: (val) {
            setState(() {
              RoomOptions.selectedKitchen = val as String;
              viewModel.selectedKitchen = val;
            });
          },
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
        CustomDropdownFormField(
          alignmentDirectional: AlignmentDirectional.centerStart,
          labelText: TTexts.city,
          prefixIcon: Iconsax.buildings,
          value: selectedCity,
          items: cities,
          onChanged: (val) {
            setState(() {
              selectedCity = val as String;
              // Seçilen şehre göre ilçeleri güncelleyin
              selectedDistrict = null; // Seçili ilçeyi sıfırlayın
              districts[selectedCity] != null
                  ? districtItems = districts[selectedCity]!
                  : districtItems = [];
              viewModel.selectedCity = val;
            });
          },
        ),
        const SizedBox(height: TSizes.spaceBtwInputFields),

        /// İlçe
        CustomDropdownFormField(
          alignmentDirectional: AlignmentDirectional.centerStart,
          labelText: TTexts.district,
          prefixIcon: Iconsax.buildings,
          value: selectedDistrict,
          items: districtItems,
          onChanged: (val) {
            setState(() {
              selectedDistrict = val as String;
              viewModel.selectedDistrict = val;
            });
          },
        ),
        const SizedBox(height: TSizes.spaceBtwInputFields),

        /// Mahalle
        HostTextFormField(
          keyboardType: TextInputType.text,
          labelText: TTexts.neighborhood,
          prefixIcon: Iconsax.building,
          maxLength: 30,
          controller: viewModel.neighbourhoodController,
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
                controller: viewModel.streetController,
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
                controller: viewModel.alleyController,
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
          controller: viewModel.apartmentNameController,
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
                controller: viewModel.buildingNoController,
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
                controller: viewModel.flatNoController,
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
          controller: viewModel.phoneNumberController,
          maxLines: 1, //max. 1 satır yüksekliğinde
        ),
        const SizedBox(height: TSizes.spaceBtwInputFields),

        /// email
        HostTextFormField(
          keyboardType: TextInputType.emailAddress,
          labelText: TTexts.email,
          prefixIcon: Iconsax.direct,
          maxLength: 40,
          controller: viewModel.emailController,
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
              child: PickMultipleImagesScreen(viewModel: viewModel),
            ),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwInputFields),

        /// Create Button
        SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () {
                  //viewModel.createHouseListing(context);
                  _createHouseListing(context);
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
