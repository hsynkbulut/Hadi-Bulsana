import 'package:flutter/material.dart';
import 'package:hadi_bulsana/common/constants/colors.dart';
import 'package:hadi_bulsana/common/constants/sizes.dart';
import 'package:hadi_bulsana/common/constants/text_strings.dart';
import 'package:hadi_bulsana/core/viewmodel/authentication/tenant/register_viewmodel_tenant.dart';
import 'package:hadi_bulsana/ui/widgets/tenant_widgets/tenant_text_form_field.dart';
import 'package:iconsax/iconsax.dart';

class TenantSignupForm extends StatefulWidget {
  const TenantSignupForm({
    super.key,
  });

  @override
  State<TenantSignupForm> createState() => _TenantSignupFormState();
}

class _TenantSignupFormState extends State<TenantSignupForm> {
  RegisterViewModelTenant viewModel = RegisterViewModelTenant();
  bool isSignUp = false; // Bayrak tanımlama

  void _signUp() async {
    setState(() {
      isSignUp = true; // Çıkış işlemi başladığında bayrağı true yap
    });

    // İşlemi gerçekleştir
    await viewModel.signUp(context);

    setState(() {
      isSignUp = false; // İşlem tamamlandığında bayrağı false yap
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Column(
      children: [
        /// First & Last Name
        Row(
          children: [
            Expanded(
              child: TenantTextFormField(
                keyboardType: TextInputType.name,
                labelText: TTexts.firstName,
                prefixIcon: Iconsax.user,
                maxLength: 20,
                controller: viewModel.nameController,
              ),
            ),
            const SizedBox(width: TSizes.spaceBtwInputFields),
            Expanded(
              child: TenantTextFormField(
                keyboardType: TextInputType.text,
                labelText: TTexts.lastName,
                prefixIcon: Iconsax.user,
                maxLength: 20,
                controller: viewModel.surnameController,
              ),
            ),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwInputFields),

        /// Email
        TenantTextFormField(
          keyboardType: TextInputType.emailAddress,
          labelText: TTexts.email,
          prefixIcon: Iconsax.direct,
          maxLength: 30,
          controller: viewModel.emailController,
        ),
        const SizedBox(height: TSizes.spaceBtwInputFields),

        /// Phone Number
        TenantTextFormField(
          keyboardType: TextInputType.phone,
          labelText: TTexts.phoneNo,
          prefixIcon: Iconsax.call,
          maxLength: 11,
          controller: viewModel.phoneNumberController,
        ),
        const SizedBox(height: TSizes.spaceBtwInputFields),

        /// City
        TenantTextFormField(
          keyboardType: TextInputType.text,
          labelText: TTexts.city,
          prefixIcon: Iconsax.buildings,
          maxLength: 16,
          controller: viewModel.cityController,
        ),
        const SizedBox(height: TSizes.spaceBtwInputFields),

        /// District
        TenantTextFormField(
          keyboardType: TextInputType.text,
          labelText: TTexts.district,
          prefixIcon: Iconsax.buildings,
          maxLength: 20,
          controller: viewModel.districtController,
        ),
        const SizedBox(height: TSizes.spaceBtwInputFields),

        /// Password
        TenantTextFormField(
          keyboardType: TextInputType.visiblePassword,
          labelText: TTexts.password,
          prefixIcon: Iconsax.lock_14,
          suffixIcon: Iconsax.eye_slash,
          maxLength: 20,
          obscureText: true, //şifreyi gizlemek için
          controller: viewModel.passwordController,
        ),
        const SizedBox(height: TSizes.spaceBtwInputFields),

        /// Sign Up Button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
              onPressed: () {
                _signUp();
                //viewModel.signUp(context);
                //Navigator.pushNamed(context, RouteConstant.bottomNaviRoute);
              },
              child: isSignUp
                  ? const CircularProgressIndicator(
                      backgroundColor: AppColors.whiteColor,
                      color: AppColors.ratingColor,
                      strokeWidth: 3, //Kalınlığı
                      strokeAlign: CircularProgressIndicator.strokeAlignCenter,
                    )
                  : const Text(TTexts.createAccount)),
        )
      ],
    ));
  }
}
