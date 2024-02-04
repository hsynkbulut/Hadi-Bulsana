import 'package:flutter/material.dart';
import 'package:hadi_bulsana/common/constants/colors.dart';
import 'package:hadi_bulsana/common/constants/sizes.dart';
import 'package:hadi_bulsana/common/constants/text_strings.dart';
import 'package:hadi_bulsana/core/models/homeowner_model.dart';
import 'package:hadi_bulsana/core/viewmodel/homeowner_viewmodel/host_edit_profile_viewmodel.dart';
import 'package:hadi_bulsana/ui/widgets/homeowner_widgets/host_text_form_field.dart';
import 'package:iconsax/iconsax.dart';

class HostEditProfileForm extends StatefulWidget {
  final HomeOwner homeOwner;
  const HostEditProfileForm({
    super.key,
    required this.homeOwner,
  });

  @override
  State<HostEditProfileForm> createState() => _HostEditProfileFormState();
}

class _HostEditProfileFormState extends State<HostEditProfileForm> {
  HostEditProfileViewModel viewModel = HostEditProfileViewModel();
  bool isLoading = false; // Bayrak değişkeni tanımla

  void _handleUpdate() async {
    setState(() {
      isLoading = true; // İşlem başladığında bayrağı true yap
    });

    // ViewModel'deki güncelleme metodunu burada çağırabilirsiniz
    await viewModel.updateSignUp(context, widget.homeOwner);

    setState(() {
      isLoading = false; // İşlem tamamlandığında bayrağı false yap
    });
  }

  @override
  void initState() {
    super.initState();
    //userIdController.text = widget.homeOwner.userID!;
    viewModel.nameController.text = widget.homeOwner.name;
    viewModel.surnameController.text = widget.homeOwner.surname;
    viewModel.emailController.text = widget.homeOwner.email;
    viewModel.phoneNumberController.text = widget.homeOwner.phoneNumber;
    viewModel.passwordController.text = widget.homeOwner.password;
    //viewModel.profilePhoto = File(widget.homeOwner.profilePhoto!);
  }

  @override
  Widget build(BuildContext context) {
    //final dark = THelperFunctions.isDarkMode(context);
    return Form(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: TSizes.spaceBtwSections),
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
              prefixIcon: Iconsax.direct_right,
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
            const SizedBox(height: TSizes.spaceBtwInputFields / 3),

            /// Sign In Button
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      //viewModel.updateSignUp(context, widget.homeOwner);
                      _handleUpdate(); // Güncelleme işlemini başlatan metod
                    },
                    style: Theme.of(context)
                        .elevatedButtonTheme
                        .style!
                        .copyWith(
                            backgroundColor: MaterialStateColor.resolveWith(
                                (states) => AppColors.primaryColor2)),
                    child: isLoading
                        ? const CircularProgressIndicator(
                            backgroundColor: AppColors.whiteColor,
                            color: AppColors.ratingColor,
                            strokeWidth: 3, //Kalınlığı
                            strokeAlign:
                                CircularProgressIndicator.strokeAlignCenter,
                          )
                        : Container(
                            width: double.infinity,
                            height: 20.0,
                            alignment: Alignment.center,
                            child: Text(TTexts.updateButton,
                                textAlign: TextAlign.center,
                                style:
                                    Theme.of(context).textTheme.titleLarge)))),
          ],
        ),
      ),
    );
  }
}
