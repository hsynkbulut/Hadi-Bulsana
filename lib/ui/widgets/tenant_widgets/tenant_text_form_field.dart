import 'package:flutter/material.dart';
import 'package:hadi_bulsana/common/constants/colors.dart';
import 'package:hadi_bulsana/common/helpers/helpers_functions.dart';
import 'package:iconsax/iconsax.dart';

class TenantTextFormField extends StatefulWidget {
  final TextInputType keyboardType;
  final String labelText;
  final IconData prefixIcon;
  final IconData? suffixIcon;
  final int? maxLength;
  final int? minLines;
  final int? maxLines;
  final bool showCounter;
  final TextEditingController? controller;
  final bool obscureText;

  const TenantTextFormField({
    Key? key,
    required this.keyboardType,
    required this.labelText,
    required this.prefixIcon,
    this.suffixIcon,
    this.maxLength,
    this.minLines,
    this.maxLines,
    this.showCounter = false,
    this.controller,
    this.obscureText = false, // Varsayılan değer olarak false
  }) : super(key: key);

  @override
  State<TenantTextFormField> createState() => _TenantTextFormFieldState();
}

class _TenantTextFormFieldState extends State<TenantTextFormField> {
  bool _isObscured = false;
  IconData _currentSuffixIcon = Iconsax.eye;

  void toggleObscureText() {
    setState(() {
      _isObscured = !_isObscured;
      _currentSuffixIcon = _isObscured ? Iconsax.eye_slash : Iconsax.eye;
    });
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return TextFormField(
      obscureText: widget.obscureText && _isObscured, // güncellendi
      //obscureText: widget.obscureText, // Dışarıdan alınan değeri burada kullan
      controller: widget.controller, // Controller kullanıldı
      maxLength: widget.maxLength,
      buildCounter: (context,
          {required currentLength, required maxLength, required isFocused}) {
        final text = '$currentLength/$maxLength';
        if (widget.showCounter) {
          return Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: MaterialStateColor.resolveWith((states) =>
                    dark ? AppColors.whiteColor : AppColors.primaryColor2)),
          ); // Eğer showCounter true ise karakter sayısını ve maksimum karakter sayısını göster
        } else {
          return const SizedBox(height: 0.0); // Aksi halde SizedBox'ı göster
        }
      },
      minLines: widget.minLines,
      maxLines: widget.obscureText
          ? 1
          : widget.maxLines, // Şifre alanı için maxLines kontrolü
      expands: false,
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
        labelStyle: Theme.of(context).textTheme.bodyMedium,
        labelText: widget.labelText,
        prefixIcon: Icon(
          widget.prefixIcon,
        ),
        suffixIcon: widget.suffixIcon != null
            ? GestureDetector(
                onTap: () {
                  if (widget.suffixIcon == Iconsax.eye_slash ||
                      widget.suffixIcon == Iconsax.eye) {
                    toggleObscureText();
                  }
                },
                child: Icon(_currentSuffixIcon),
              )
            : null,
      ),
    );
  }
}
