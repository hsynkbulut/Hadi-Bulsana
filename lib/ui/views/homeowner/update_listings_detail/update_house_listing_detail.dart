import 'package:flutter/material.dart';
import 'package:hadi_bulsana/common/constants/colors.dart';
import 'package:hadi_bulsana/common/constants/image_paths.dart';
import 'package:hadi_bulsana/common/constants/sizes.dart';
import 'package:hadi_bulsana/common/constants/text_strings.dart';
import 'package:hadi_bulsana/common/helpers/helpers_functions.dart';
import 'package:hadi_bulsana/common/styles/spacing_styles.dart';
import 'package:hadi_bulsana/core/models/house_listing_model.dart';
import 'package:hadi_bulsana/core/utils/themes/background_gradient.dart';
import 'package:hadi_bulsana/core/viewmodel/homeowner_viewmodel/update_house_list_viewmodel.dart';
import 'package:hadi_bulsana/ui/views/homeowner/update_listings_detail/widgets/update_house_listing_form.dart';
import 'package:hadi_bulsana/ui/widgets/homeowner_widgets/homeowner_appbar.dart';

class UpdateHouseListingDetailScreen extends StatefulWidget {
  final HouseListing houseListing;
  final UpdateHouseListViewModel viewModel;

  const UpdateHouseListingDetailScreen({
    super.key,
    required this.houseListing,
    required this.viewModel,
  });

  @override
  State<UpdateHouseListingDetailScreen> createState() =>
      _UpdateHouseListingDetailScreenState();
}

class _UpdateHouseListingDetailScreenState
    extends State<UpdateHouseListingDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    //final height = THelperFunctions.screenHeight(context);
    //final width = THelperFunctions.screenWidth(context);
    //final Size screenSize = THelperFunctions.screenSize(context);
    //final AddHouseListViewModel viewModel = AddHouseListViewModel();

    return Scaffold(
      backgroundColor: dark ? AppColors.dark : AppColors.primaryColor2,
      appBar: HomeOwnerAppBar(
        showBackButton: true,
        title: 'İlan Güncelle',
        isDark: dark,
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 33.0),
        decoration: dark
            ? BackgroundGradient().buildGradient()
            : BackgroundGradient().buildGradient2(),
        child: SingleChildScrollView(
          child: Padding(
            padding: TSpacingStyle.paddingWithAppBarHeight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image(
                      height: 140,
                      image: AssetImage(dark
                          ? ImagePaths.darkAppLogo2
                          : ImagePaths.lightAppLogo2),
                    ),

                    /// Title
                    Text(TTexts.createListingTitle,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: dark
                                    ? AppColors.whiteColor
                                    : AppColors.darkerGrey)),
                    const SizedBox(height: TSizes.spaceBtwSections / 2),
                  ],
                ),

                /// Form
                UpdateHouseListingForm(
                  houseListing: widget.houseListing,
                  viewModel: widget.viewModel,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
