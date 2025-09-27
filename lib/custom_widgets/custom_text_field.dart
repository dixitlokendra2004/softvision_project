import 'package:softvision_project/core/constant/app_colors.dart';
import 'package:softvision_project/core/constant/app_images.dart';
import 'package:softvision_project/core/constant/app_strings.dart';
import 'package:softvision_project/custom_widgets/custom_image_view.dart';
import 'package:softvision_project/size_ext.dart';
import 'package:softvision_project/utils/util.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CustomTextFormField extends StatefulWidget {
  CustomTextFormField({
    this.shape,
    this.padding,
    this.variant,
    this.fontStyle,
    this.alignment,
    this.width,
    this.margin,
    this.controller,
    this.focusNode,
    this.isObscureText = false,
    this.applyValidator = true,
    this.onlyNumber = false,
    this.onlyText = false,
    this.decimalNumber = false,
    this.readOnly = false,
    this.isDatePicker = false,
    this.isTimePicker = false,
    this.isFilePicker = false,
    this.isImagePiker = false,
    this.allowedExtensions,
    this.onChange,
    this.onDateSelected,
    this.onTimeSelected,
    this.onFilePicked,
    this.onFileCanceled,
    this.textInputAction = TextInputAction.next,
    this.textInputType = TextInputType.text,
    this.onSubmitted,
    this.maxLines,
    this.maxLength,
    this.hintText,
    this.prefix,
    this.prefixConstraints,
    this.suffix,
    this.suffixConstraints,
    this.validator,
    this.title = "",
  });

  Function? onSubmitted;

  String title;

  TextFormFieldShape? shape;

  TextFormFieldPadding? padding;

  TextFormFieldVariant? variant;

  TextFormFieldFontStyle? fontStyle;

  Alignment? alignment;

  double? width;

  EdgeInsetsGeometry? margin;

  TextEditingController? controller;

  FocusNode? focusNode;

  bool isObscureText;

  TextInputAction? textInputAction;

  TextInputType? textInputType;

  int? maxLines;

  int? maxLength;

  String? hintText;

  Widget? prefix;

  BoxConstraints? prefixConstraints;

  Widget? suffix;

  BoxConstraints? suffixConstraints;

  bool applyValidator;

  bool onlyNumber;

  bool onlyText;

  bool decimalNumber;

  bool readOnly;

  bool isDatePicker;

  bool isTimePicker;

  bool isFilePicker;

  bool isImagePiker;

  Function? validator;

  List<String>? allowedExtensions;

  final ValueChanged<String>? onChange;

  final ValueChanged<DateTime>? onDateSelected;

  final ValueChanged<TimeOfDay>? onTimeSelected;

  final ValueChanged<PlatformFile>? onFilePicked;

  final Function? onFileCanceled;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = widget.controller ?? TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isImagePiker) widget.isFilePicker = true;
    setupVariables();
    return Container(
      margin: widget.margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Visibility(
            visible: widget.title.isNotEmpty,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: EdgeInsets.only(bottom: 7.Sh),
                child: Text(
                  widget.title,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: AppColors.gray800,
                    fontSize: 15.Sp,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          widget.alignment != null
              ? Align(
                  alignment: widget.alignment ?? Alignment.center,
                  child: getTF(),
                )
              : getTF()
        ],
      ),
    );
  }

  _buildTextFormFieldWidget(bool absorb) {
    return Container(
      child: AbsorbPointer(
        absorbing: absorb,
        child: TextFormField(
          controller: controller,
          focusNode: widget.focusNode,
          maxLength: widget.maxLength,
          onFieldSubmitted: (widget.onSubmitted != null)
              ? (s) => widget.onSubmitted!(s)
              : null,
          style: _setFontStyle(),
          onChanged: (s) {
            if (widget.onChange != null) {
              widget.onChange!(s);
            }
          },
          obscureText: widget.isObscureText,
          textInputAction: widget.textInputAction,
          keyboardType: widget.textInputType,
          maxLines: widget.maxLines ?? 1,
          decoration: _buildDecoration(),
          readOnly: (widget.readOnly ||
              widget.isFilePicker ||
              widget.isDatePicker ||
              widget.isTimePicker),
          inputFormatters: (widget.onlyNumber)
              ? <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]
              : (widget.onlyText)
                  ? []
                  : (widget.decimalNumber)
                      ? [
                          FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
                          TextInputFormatter.withFunction((oldValue, newValue) {
                            try {
                              final text = newValue.text;
                              if (text.isNotEmpty) double.parse(text);
                              return newValue;
                            } catch (e) {}
                            return oldValue;
                          }),
                        ]
                      : null,
          validator: widget.applyValidator
              ? (widget.validator != null)
                  ? (value) => widget.validator!(value)
                  : (value) {
                      if (value == null || value.isEmpty) {
                        return AppStrings.thisFieldCannotBeEmpty;
                      }
                      return null;
                    }
              : null,
        ),
      ),
    );
  }

  _buildDecoration() {
    return InputDecoration(
      hintText: widget.hintText ?? "",
      counterText: "",
      hintStyle: _setFontStyle(),
      border: _setBorderStyle(),
      enabledBorder: _setBorderStyle(),
      focusedBorder: _setBorderStyle(),
      disabledBorder: _setBorderStyle(),
      prefixIcon: widget.prefix,
      prefixIconConstraints: widget.prefixConstraints,
      suffixIcon: widget.suffix,
      suffixIconConstraints: widget.suffixConstraints,
      fillColor: _setFillColor(),
      filled: _setFilled(),
      isDense: true,
      contentPadding: _setPadding(),
    );
  }

  _setFontStyle() {
    switch (widget.fontStyle) {
      case TextFormFieldFontStyle.MontserratMedium12:
        return TextStyle(
          color: AppColors.white,
          fontSize: 12.Sp,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w500,
        );
      case TextFormFieldFontStyle.MontserratMedium16:
        return TextStyle(
          color: AppColors.gray600,
          fontSize: 16.Sp,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w500,
        );
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
    switch (widget.shape) {
      case TextFormFieldShape.RoundedBorder12:
        return BorderRadius.circular(12);
      default:
        return BorderRadius.circular(6);
    }
  }

  _setBorderStyle() {
    switch (widget.variant) {
      case TextFormFieldVariant.FillYellow70033:
        return OutlineInputBorder(
          borderRadius: _setOutlineBorderRadius(),
          borderSide: BorderSide.none,
        );
      case TextFormFieldVariant.FillWhiteA700:
        return OutlineInputBorder(
          borderRadius: _setOutlineBorderRadius(),
          borderSide: BorderSide.none,
        );
      case TextFormFieldVariant.OutlineBluegray5002_1:
        return OutlineInputBorder(
          borderRadius: _setOutlineBorderRadius(),
          borderSide: BorderSide(
            color: AppColors.blueGray5002,
            width: 1,
          ),
        );
      case TextFormFieldVariant.None:
        return InputBorder.none;
      default:
        return OutlineInputBorder(
          borderRadius: _setOutlineBorderRadius(),
          borderSide: BorderSide(
            color: AppColors.blueGray5002,
            width: 1,
          ),
        );
    }
  }

  _setFillColor() {
    switch (widget.variant) {
      case TextFormFieldVariant.FillYellow70033:
        return AppColors.yellow70033;
      case TextFormFieldVariant.FillWhiteA700:
        return AppColors.white;
      case TextFormFieldVariant.OutlineBluegray5002_1:
        return AppColors.white;
      default:
        return AppColors.white;
    }
  }

  _setFilled() {
    switch (widget.variant) {
      case TextFormFieldVariant.FillYellow70033:
        return true;
      case TextFormFieldVariant.FillWhiteA700:
        return true;
      case TextFormFieldVariant.OutlineBluegray5002_1:
        return true;
      case TextFormFieldVariant.None:
        return false;
      default:
        return true;
    }
  }

  _setPadding() {
    switch (widget.padding) {
      case TextFormFieldPadding.PaddingT13:
        return getPadding(
          left: 12,
          top: 13,
          right: 12,
          bottom: 13,
        );
      case TextFormFieldPadding.PaddingT28:
        return getPadding(
          left: 15,
          top: 28,
          right: 15,
          bottom: 28,
        );
      case TextFormFieldPadding.PaddingAll6:
        return getPadding(
          all: 6,
        );
      case TextFormFieldPadding.PaddingT16:
        return getPadding(
          top: 16,
          right: 16,
          bottom: 16,
          left: 16
        );
      default:
        return getPadding(
          left: 13,
          top: 13,
          bottom: 13,
        );
    }
  }

  Widget getTF() {
    if (widget.isTimePicker) {
      return InkWell(
        onTap: () async {
          final TimeOfDay? picked = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
          );
          if (picked != null) {
            widget.controller?.text = picked.formatTime;
            widget.onTimeSelected!(picked);
          }
        },
        child: _buildTextFormFieldWidget(true),
      );
    } else if (widget.isDatePicker) {
      return GestureDetector(
        onTap: () async {
          final DateTime? picked = await showDatePicker(
            context: Get.context!,
            initialDate: DateTime.now(),
            firstDate: DateTime(2015, 8),
            lastDate: DateTime.now().add(Duration(days: 365)),
          );
          if (picked != null) {
            controller.text = picked.formatDate;
            widget.onDateSelected!(picked);
          }
        },
        child: _buildTextFormFieldWidget(true),
      );
    } else if (widget.isFilePicker) {
      return Stack(
        children: [
          Positioned(
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () async {
                PlatformFile? file = await pickFile();
                if (file != null) {
                  widget.onFilePicked!(file);
                  setState(() {});
                }
              },
              child: _buildTextFormFieldWidget(true),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            bottom: 0,
            width: 40.Sw,
            child: GestureDetector(
              onTap: () => getIconTap(),
              child: Container(
                color: Colors.transparent,
              ),
            ),
          ),
        ],
      );
    } else {
      return _buildTextFormFieldWidget(
          (widget.readOnly || widget.isFilePicker || widget.isDatePicker));
    }
  }

  Future<PlatformFile?> pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type:
            (widget.allowedExtensions != null) ? FileType.custom : FileType.any,
        allowedExtensions: widget.allowedExtensions,
      );

      if (result != null) {
        if (result.files.single.size < 32 * 1024 * 1024) {
          //check size is smalller then 32 MB
          controller.text = result.files.single.name;
          PlatformFile file = result.files.single;
          return file;
        } else {
          Util.getSnackBar(AppStrings.fileSizeTooLarge);
        }
      }

      return null;
    } on PlatformException catch (e) {
      return null;
    } catch (e) {
      return null;
    }
  }

  void setupVariables() {
    if (widget.isObscureText ||
        widget.isFilePicker ||
        widget.isDatePicker ||
        widget.isTimePicker) {
      widget.maxLines = 1;
    }
    if (widget.onlyNumber) {
      widget.textInputType = TextInputType.number;
    }
    if (widget.isFilePicker || widget.isDatePicker || widget.isTimePicker) {
      widget.suffixConstraints = BoxConstraints(maxHeight: 44.Sh);
      EdgeInsetsGeometry margin =
          getMargin(left: 30, top: 14, right: 15, bottom: 14);
      if (widget.isFilePicker) {
        widget.suffix = Container(
          margin: margin,
          child: CustomImageView(
            imagePath: controller.text.trim().isNotEmpty
                ? AppImages.crossIcon
                : AppImages.uploadIcon,
          ),
        );
      } else if (widget.isTimePicker) {
        widget.suffix = Container(
          margin: margin,
          child: CustomImageView(imagePath: AppImages.clockIcon, height: 15),
        );
      } else if (widget.isDatePicker) {
        widget.suffix = Container(
          margin: margin,
          child: CustomImageView(imagePath: AppImages.imgCalendar),
        );
      }
    }
  }

  getIconTap() async {
    if (widget.onFileCanceled != null && controller.text.trim().isNotEmpty) {
      controller.text = "";
      setState(() {});
      widget.onFileCanceled!();
    } else if (controller.text.trim().isEmpty && widget.isFilePicker) {
      PlatformFile? file = await pickFile();
      if (file != null) {
        widget.onFilePicked!(file);
        setState(() {});
      }
    }
  }
}

enum TextFormFieldShape {
  RoundedBorder6,
  RoundedBorder12,
}

enum TextFormFieldPadding {
  PaddingT13,
  PaddingT13_1,
  PaddingT28,
  PaddingAll6,
  PaddingT16,
}

enum TextFormFieldVariant {
  None,
  OutlineBluegray5002,
  FillYellow70033,
  FillWhiteA700,
  OutlineBluegray5002_1,
}

enum TextFormFieldFontStyle {
  MontserratMedium14,
  MontserratMedium12,
  MontserratMedium16,
}
