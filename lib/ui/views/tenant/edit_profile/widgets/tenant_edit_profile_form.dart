import 'package:flutter/material.dart';
import 'package:hadi_bulsana/common/constants/colors.dart';
import 'package:hadi_bulsana/common/constants/sizes.dart';
import 'package:hadi_bulsana/common/constants/text_strings.dart';
import 'package:hadi_bulsana/core/models/tenant_model.dart';
import 'package:hadi_bulsana/core/viewmodel/tenant_viewmodel/tenant_edit_profile_viewmodel.dart';
import 'package:hadi_bulsana/ui/widgets/tenant_widgets/tenant_text_form_field.dart';
import 'package:iconsax/iconsax.dart';

class TenantEditProfileForm extends StatefulWidget {
  final Tenant tenant;
  const TenantEditProfileForm({
    super.key,
    required this.tenant,
  });

  @override
  State<TenantEditProfileForm> createState() => _TenantEditProfileFormState();
}

class _TenantEditProfileFormState extends State<TenantEditProfileForm> {
  TenantEditProfileViewModel viewModel = TenantEditProfileViewModel();
  bool isLoading = false; // Bayrak değişkeni tanımla

  void _handleUpdate() async {
    setState(() {
      isLoading = true; // İşlem başladığında bayrağı true yap
    });

    // ViewModel'deki güncelleme metodunu burada çağırabilirsiniz
    await viewModel.updateSignUp(context, widget.tenant);

    setState(() {
      isLoading = false; // İşlem tamamlandığında bayrağı false yap
    });
  }

  @override
  void initState() {
    super.initState();
    //userIdController.text = widget.tenant.userID!;
    viewModel.nameController.text = widget.tenant.name;
    viewModel.surnameController.text = widget.tenant.surname;
    viewModel.emailController.text = widget.tenant.email;
    viewModel.phoneNumberController.text = widget.tenant.phoneNumber;
    viewModel.passwordController.text = widget.tenant.password;
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
              prefixIcon: Iconsax.direct_right,
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
                                (states) => AppColors.primaryColor)),
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
