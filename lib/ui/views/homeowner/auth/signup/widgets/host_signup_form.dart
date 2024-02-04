import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hadi_bulsana/common/constants/colors.dart';
import 'package:hadi_bulsana/common/constants/sizes.dart';
import 'package:hadi_bulsana/common/constants/text_strings.dart';
import 'package:hadi_bulsana/core/viewmodel/authentication/homeowner/register_viewmodel_homeowner.dart';
import 'package:hadi_bulsana/ui/widgets/homeowner_widgets/host_text_form_field.dart';
import 'package:iconsax/iconsax.dart';

class HostSignupForm extends StatefulWidget {
  final File? profilePhoto; // Profil fotoğrafı parametresi eklendi

  const HostSignupForm({
    super.key,
    this.profilePhoto,
  });

  @override
  State<HostSignupForm> createState() => _HostSignupFormState();
}

class _HostSignupFormState extends State<HostSignupForm> {
  RegisterViewModelHomeOwner viewModel = RegisterViewModelHomeOwner();
  bool isSignUp = false; // Bayrak tanımlama

  void _signUp() async {
    setState(() {
      isSignUp = true; // Çıkış işlemi başladığında bayrağı true yap
    });

    // İşlemi gerçekleştir
    viewModel.profilePhoto =
        widget.profilePhoto; // viewModel içindeki profilePhoto'ya resmi atama
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
              child: HostTextFormField(
                keyboardType: TextInputType.name,
                labelText: TTexts.firstName,
                prefixIcon: Iconsax.user,
                maxLength: 20,
                controller: viewModel.nameController,
              ),
            ),
            const SizedBox(width: TSizes.spaceBtwInputFields),
            Expanded(
              child: HostTextFormField(
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
        HostTextFormField(
          keyboardType: TextInputType.emailAddress,
          labelText: TTexts.email,
          prefixIcon: Iconsax.direct,
          maxLength: 30,
          controller: viewModel.emailController,
        ),
        const SizedBox(height: TSizes.spaceBtwInputFields),

        /// Phone Number
        HostTextFormField(
          keyboardType: TextInputType.phone,
          labelText: TTexts.phoneNo,
          prefixIcon: Iconsax.call,
          maxLength: 11,
          controller: viewModel.phoneNumberController,
        ),
        const SizedBox(height: TSizes.spaceBtwInputFields),

        /// Password
        HostTextFormField(
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
                /*
                viewModel.profilePhoto = widget
                    .profilePhoto; // viewModel içindeki profilePhoto'ya resmi atama
                viewModel.signUp(context);
                */
                //Navigator.pushNamed(context, RouteConstant.hostDashboardRoute);
              },
              style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                  backgroundColor: MaterialStateColor.resolveWith(
                      (states) => AppColors.primaryColor2)),
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
