// import 'package:e_portfolio/core/constant/app_strings.dart';
// import 'package:e_portfolio/core/utils/color_constant.dart';
// import 'package:e_portfolio/core/utils/image_constant.dart';
// import 'package:e_portfolio/core/utils/size_utils.dart';
// import 'package:e_portfolio/extensions.dart';
// import 'package:e_portfolio/theme/app_style.dart';
// import 'package:e_portfolio/ui/widgets/custom_image_view.dart';
import 'package:flutter/material.dart';

import '../../core/constant/app_colors.dart';
import '../../core/constant/app_strings.dart';
import '../../custom_widgets/custom_image_view.dart';
import '../../utils/util.dart';

// import '../../translations/locale_keys.g.dart';

class CustomDropDownWeb extends StatelessWidget {
  CustomDropDownWeb({
    this.shape,
    this.padding,
    this.variant,
    this.fontStyle,
    this.alignment,
    this.width,
    this.margin,
    this.focusNode,
    this.icon,
    this.hintText,
    this.prefix,
    this.prefixConstraints,
    this.items,
    this.onChanged,
    this.applyValidator = true,
    this.readOnly = false,
    this.selectedItem,
    this.validator,
    this.title = "",
  });

  String title;

  DropDownShape? shape;

  DropDownPadding? padding;

  DropDownVariant? variant;

  DropDownFontStyle? fontStyle;

  Alignment? alignment;

  double? width;

  EdgeInsetsGeometry? margin;

  FocusNode? focusNode;

  Widget? icon;

  String? hintText;

  Widget? prefix;

  BoxConstraints? prefixConstraints;

  List<String>? items;

  Function(String)? onChanged;

  bool applyValidator;

  bool readOnly;

  Function? validator;

  String? selectedItem;

  @override
  Widget build(BuildContext context) {
    print("selectedItem $selectedItem");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Visibility(
        //   visible: title.isNotEmpty,
        //   child: Container(
        //     margin: EdgeInsets.only(bottom: 7.Sh),
        //     child: Text(
        //       title,
        //       overflow: TextOverflow.ellipsis,
        //       textAlign: TextAlign.left,
        //       style: AppTextStyle.getTextStyle14FontWeight500,
        //     ),
        //   ),
        // ),
        alignment != null
            ? Align(
          alignment: alignment ?? Alignment.center,
          child: _buildDropDownWidget(),
        )
            : _buildDropDownWidget()
      ],
    );
  }

  _buildDropDownWidget() {
    return Container(
      width: width ?? double.maxFinite,
      margin: margin,
      child: DropdownButtonFormField(
        focusNode: focusNode,
        value: items!.contains(selectedItem) ? selectedItem : null,
        icon: Container(
          margin: getPadding(left: 5, right: 15),
          child: CustomImageView(
            imagePath: 'assets/images/drop_down_logo.png',
            height: 15,
          ),
        ),
        style: _setFontStyle(),
        decoration: _buildDecoration(),
        items: items?.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              overflow: TextOverflow.ellipsis,
            ),
          );
        }).toList(),
        onChanged: (value) {
          onChanged!(value.toString());
        },
        validator: applyValidator
            ? (validator != null)
            ? (value) => validator!(value)
            : (value) {
          if (value == null ||
              value.toString().isEmpty) {
            return "This field cannot be empty.";
          }
          return null;
        }
            : null,
      ),
    );
  }

  _buildDecoration() {
    var border = BorderRadius.circular(4);
    return InputDecoration(
      counterText: '',
     // hintText: title ?? "",
       hintText:hintText ?? "",
      hintStyle: _setFontStyle(),
      alignLabelWithHint: true,
      border: OutlineInputBorder(
        borderRadius: _setOutlineBorderRadius(),
        borderSide: BorderSide(
          color: AppColors.blueGray5002,
          width: 1,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: _setOutlineBorderRadius(),
        borderSide: BorderSide(
          color: AppColors.blueGray5002,
          width: 1,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: _setOutlineBorderRadius(),
        borderSide: BorderSide(
          color: AppColors.blueGray5002,
          width: 1,
        ),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: border,
        borderSide: const BorderSide(color: Color(0xffE5E5E5), width: 1),
      ),
      prefixIcon: prefix,
      prefixIconConstraints: prefixConstraints,
      fillColor: _setFillColor(),
      filled: _setFilled(),
      isDense: true,
      contentPadding: _setPadding(),
    );
  }

  // _buildDecoration() {
  //   return InputDecoration(
  //     hintText: hintText ?? "",
  //     hintStyle: _setFontStyle(),
  //     border: _setBorderStyle(),
  //     enabledBorder: _setBorderStyle(),
  //     focusedBorder: _setBorderStyle(),
  //     prefixIcon: prefix,
  //     prefixIconConstraints: prefixConstraints,
  //     fillColor: _setFillColor(),
  //     filled: _setFilled(),
  //     isDense: true,
  //     contentPadding: _setPadding(),
  //   );
  // }

  _setFontStyle() {
    switch (fontStyle) {
      default:
        return TextStyle(
          color: Colors.grey[600],
          fontSize: 14,
          fontFamily: AppStrings.appFontFamily,
          fontWeight: FontWeight.w500,
          height: 1.25,
        );
    }
  }

  _setOutlineBorderRadius() {
    switch (shape) {
      default:
        return BorderRadius.circular(5);
    }
  }

  _setBorderStyle() {
    switch (variant) {
      case DropDownVariant.OutlineBluegray5002:
        return OutlineInputBorder(
          borderRadius: _setOutlineBorderRadius(),
          borderSide: const BorderSide(
            color: Colors.blueGrey,
            width: 1,
          ),
        );
      case DropDownVariant.OutlineBluegray5002_1:
        return OutlineInputBorder(
          borderRadius: _setOutlineBorderRadius(),
          borderSide: const BorderSide(
            color: Colors.blueGrey,
            width: 1,
          ),
        );
      case DropDownVariant.None:
        return InputBorder.none;
      default:
        return OutlineInputBorder(
          borderRadius: _setOutlineBorderRadius(),
          borderSide: const BorderSide(
            color: Color(0xffE5E5E5),
            width: 1,
          ),
        );
    }
  }

  _setFillColor() {
    switch (variant) {
      case DropDownVariant.OutlineBluegray5002_1:
        return Colors.white;
      default:
        return Colors.white;
    }
  }

  _setFilled() {
    switch (variant) {
      case DropDownVariant.OutlineBluegray5002_1:
        return true;
      case DropDownVariant.None:
        return false;
      default:
        return true;
    }
  }

  _setPadding() {
    switch (padding) {
      default:
        return getPadding(
          left: 13,
          top: 10,
          bottom: 10,
        );
    }
  }
}

enum DropDownShape {
  RoundedBorder8,
}

enum DropDownPadding {
  PaddingT28,
}

enum DropDownVariant {
  None,
  OutlineBluegray5002,
  OutlineBluegray5002_1,
}

enum DropDownFontStyle {
  MontserratMedium14,
}
