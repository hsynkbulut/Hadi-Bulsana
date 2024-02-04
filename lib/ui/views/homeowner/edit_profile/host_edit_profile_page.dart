import 'package:flutter/material.dart';
import 'package:hadi_bulsana/common/constants/colors.dart';
import 'package:hadi_bulsana/common/helpers/helpers_functions.dart';
import 'package:hadi_bulsana/common/styles/spacing_styles.dart';
import 'package:hadi_bulsana/core/models/homeowner_model.dart';
import 'package:hadi_bulsana/core/utils/themes/background_gradient.dart';
import 'package:hadi_bulsana/ui/views/homeowner/edit_profile/widgets/host_edit_profile_form.dart';
import 'package:hadi_bulsana/ui/views/homeowner/edit_profile/widgets/host_edit_profile_header.dart';
import 'package:hadi_bulsana/ui/widgets/homeowner_widgets/homeowner_appbar.dart';

class HostEditProfilePage extends StatefulWidget {
  final HomeOwner homeOwner;
  const HostEditProfilePage({super.key, required this.homeOwner});

  @override
  State<HostEditProfilePage> createState() => _HostEditProfilePageState();
}

class _HostEditProfilePageState extends State<HostEditProfilePage> {
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    //final height = THelperFunctions.screenHeight(context);
    //final width = THelperFunctions.screenWidth(context);
    //final Size screenSize = THelperFunctions.screenSize(context);
    return Scaffold(
      backgroundColor: dark ? AppColors.dark : AppColors.primaryColor2,
      appBar: HomeOwnerAppBar(
        showBackButton: true,
        title: 'Profil Düzenleme',
        isDark: dark,
      ),
      body: Container(
        padding: TSpacingStyle
            .paddingWithAppBarHeight2, //const EdgeInsets.only(top: 33.0),
        decoration: BackgroundGradient().buildGradient2(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(
                2), //TSpacingStyle.paddingWithAppBarHeight,
            child: Column(
              children: [
                /// Logo, Title & Sub-Title
                const HostEditProfileHeader(),

                /// Form
                HostEditProfileForm(homeOwner: widget.homeOwner),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
