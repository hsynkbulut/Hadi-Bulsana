import 'package:flutter/material.dart';
import 'package:hadi_bulsana/common/constants/colors.dart';
import 'package:hadi_bulsana/common/helpers/helpers_functions.dart';
import 'package:hadi_bulsana/common/styles/spacing_styles.dart';
import 'package:hadi_bulsana/core/models/tenant_model.dart';
import 'package:hadi_bulsana/core/utils/themes/background_gradient.dart';
import 'package:hadi_bulsana/ui/views/tenant/edit_profile/widgets/tenant_edit_profile_form.dart';
import 'package:hadi_bulsana/ui/views/tenant/edit_profile/widgets/tenant_edit_profile_header.dart';
import 'package:hadi_bulsana/ui/widgets/tenant_widgets/tenant_appbar.dart';

class TenantEditProfilePage extends StatefulWidget {
  final Tenant tenant;
  const TenantEditProfilePage({super.key, required this.tenant});

  @override
  State<TenantEditProfilePage> createState() => _TenantEditProfilePageState();
}

class _TenantEditProfilePageState extends State<TenantEditProfilePage> {
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    //final height = THelperFunctions.screenHeight(context);
    //final width = THelperFunctions.screenWidth(context);
    //final Size screenSize = THelperFunctions.screenSize(context);
    return Scaffold(
      backgroundColor: dark ? AppColors.dark : AppColors.primaryColor,
      appBar: TenantAppBar(
        showBackButton: true,
        title: 'Profil Düzenleme',
        isDark: dark,
      ),
      body: Container(
        padding: TSpacingStyle
            .paddingWithAppBarHeight2, //const EdgeInsets.only(top: 33.0),
        decoration: dark
            ? BackgroundGradient().buildGradient()
            : BackgroundGradient().buildGradient2(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(
                2), //TSpacingStyle.paddingWithAppBarHeight,
            child: Column(
              children: [
                /// Logo, Title & Sub-Title
                const TenantEditProfileHeader(),

                /// Form
                TenantEditProfileForm(tenant: widget.tenant),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
