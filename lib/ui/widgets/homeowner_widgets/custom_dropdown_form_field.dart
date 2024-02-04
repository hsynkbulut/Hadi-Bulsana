import 'package:flutter/material.dart';
import 'package:hadi_bulsana/common/constants/colors.dart';
import 'package:hadi_bulsana/common/helpers/helpers_functions.dart';

class CustomDropdownFormField extends StatefulWidget {
  final String labelText;
  final IconData prefixIcon;
  final String? value;
  final List<String> items;
  final ValueChanged<String?>? onChanged;
  final AlignmentDirectional? alignmentDirectional;

  const CustomDropdownFormField({
    super.key,
    required this.labelText,
    required this.prefixIcon,
    required this.value,
    required this.items,
    this.onChanged,
    this.alignmentDirectional = AlignmentDirectional.center,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CustomDropdownFormFieldState createState() =>
      _CustomDropdownFormFieldState();
}

class _CustomDropdownFormFieldState extends State<CustomDropdownFormField> {
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final height = THelperFunctions.screenHeight(context);
    //final width = THelperFunctions.screenWidth(context);

    return DropdownButtonFormField(
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
          color: MaterialStateColor.resolveWith((states) =>
              dark ? AppColors.whiteColor : AppColors.primaryColor2)),
      menuMaxHeight: height * 0.15,
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      value: widget.value,
      items: widget.items
          .map((e) => DropdownMenuItem(
                alignment:
                    widget.alignmentDirectional!, // ögenin konumu (sayıların)
                value: e,
                child: Text(e),
              ))
          .toList(),
      onChanged: widget.onChanged,
      icon: Icon(
        Icons.arrow_drop_down_circle,
        color: dark ? AppColors.whiteColor : AppColors.primaryColor2,
      ),
      iconSize: 22,
      dropdownColor: dark
          ? AppColors.primaryColor2
          : AppColors.whiteColor, //menü arkaplan rengi (dropdownColor)
      decoration: InputDecoration(
        floatingLabelStyle: Theme.of(context)
            .inputDecorationTheme
            .floatingLabelStyle!
            .copyWith(color: AppColors.primaryColor2),
        enabledBorder: Theme.of(context)
            .inputDecorationTheme
            .enabledBorder!
            .copyWith(
                borderSide: BorderSide(
                    color: dark ? AppColors.whiteColor : AppColors.darkGrey)),
        focusedBorder: Theme.of(context)
            .inputDecorationTheme
            .enabledBorder!
            .copyWith(
                borderSide: BorderSide(
                    color: dark
                        ? AppColors.primaryColor2
                        : AppColors.primaryColor2)),
        labelText: widget.labelText,
        prefixIcon: Icon(
          widget.prefixIcon,
          size: 20,
          color: dark ? AppColors.whiteColor : AppColors.primaryColor2,
        ),
        border: const UnderlineInputBorder(),
      ),
    );
  }
}
