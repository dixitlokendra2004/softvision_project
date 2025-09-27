import 'package:softvision_project/apis/api_status.dart';
import 'package:softvision_project/core/constant/app_strings.dart';
import 'package:softvision_project/size_ext.dart';
import 'package:softvision_project/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:searchfield/searchfield.dart';

class CustomSearchField<T> extends StatefulWidget {
  final Future<dynamic> Function(String s) apiCall;
  final Function(T) onSelected;
  final String Function(T) displayField;
  final Function deselectValue;
  final String title;
  final String hintText;
  final TextEditingController controller;
  Function? validator;
  bool applyValidator;
  bool readOnly;

  CustomSearchField({
    required this.displayField,
    required this.apiCall,
    required this.onSelected,
    required this.title,
    required this.hintText,
    required this.controller,
    required this.deselectValue,
    this.validator,
    this.applyValidator = true,
    this.readOnly = false,
  });

  @override
  _CustomSearchFieldState<T> createState() => _CustomSearchFieldState<T>();
}

class _CustomSearchFieldState<T> extends State<CustomSearchField<T>> {
  List<T> items = [];

  getItems(String s) async {
    var result = await widget.apiCall(s);
    if(result is List<T>) {
      items = result;
    } else if(result is Success) {
      if(result.response is List<T>) {
        items = result.response as List<T>;
      } else {
        items = [];
      }
    } else {
      items = [];
    }
    print("items ${items}");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: widget.title.isNotEmpty,
          child: Container(
            margin: EdgeInsets.only(bottom: 7.Sh),
            child: Text(
              widget.title,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        SearchField<T>(
          controller: widget.controller,
          searchInputDecoration: _buildDecoration(),
          searchStyle: _setFontStyle(),
          suggestionStyle: _setFontStyle(),
          readOnly: widget.readOnly,
          onSuggestionTap: (selection) {
            if (selection.item != null) {
              widget.onSelected(selection.item!);
            }
          },
          validator: widget.applyValidator
              ? (widget.validator != null)
              ? (value) => widget.validator!(value)
              : (value) {
            if (value == null ||
                value.isEmpty ||
                value == AppStrings.NA) {
              return "This field cannot be empty";
            }
            return null;
          }
              : null,
          suggestionsDecoration: SuggestionDecoration(
              padding: getPadding(left: 13, right: 13),
              color: Colors.white,
              border: Border.all(
                color: Color(0xffE5E5E5),
                width: 1,
              ),
              borderRadius: _setOutlineBorderRadius(),
              boxShadow: Util.defaultShadow),
          onSearchTextChanged: (String s) {
            getItems(s);
            widget.deselectValue();
            return null;
          },
          suggestions: items
              .map(
                (e) => SearchFieldListItem<T>(
              widget.displayField(e),
              item: e,
            ),
          )
              .toList(),
        ),
      ],
    );
  }

  _buildDecoration() {
    return InputDecoration(
      counterText: '',
      hintText: widget.hintText ?? "",
      hintStyle: _setFontStyle(),
      border: _setBorderStyle(),
      enabledBorder: _setBorderStyle(),
      focusedBorder: _setBorderStyle(),
      disabledBorder: _setBorderStyle(),
      // prefixIcon: widget.prefix,
      // prefixIconConstraints: widget.prefixConstraints,
      // suffixIcon: widget.suffix,
      // suffixIconConstraints: widget.suffixConstraints,
      fillColor: _setFillColor(),
      filled: _setFilled(),
      isDense: true,
      contentPadding: _setPadding(),
    );
  }

  _setFontStyle() {
    return TextStyle(
      color: Colors.grey[600],
      fontSize: 14,
      // fontFamily: AppStrings.appFontFamily,
      fontWeight: FontWeight.w500,
      height: 1.5.Sw,
    );
  }

  _setOutlineBorderRadius() {
    return BorderRadius.circular(6.Sw);
  }

  _setBorderStyle() {
    return OutlineInputBorder(
      borderRadius: _setOutlineBorderRadius(),
      borderSide: const BorderSide(
        color: Color(0xffE5E5E5),
        width: 1,
      ),
    );
  }

  _setFillColor() {
    return const Color(0xffffffff);
  }

  _setFilled() {
    return true;
  }

  _setPadding() {
    return getPadding(left: 13, top: 10, bottom: 10);
  }

// List<DropdownMenuEntry<T>> getEntries() {
//   List<DropdownMenuEntry<T>> list = [];
//   for (int i = 0; i < widget.items.length; i++) {
//     list.add(
//       DropdownMenuEntry<T>(
//         value: widget.items[i],
//         label: widget.displayItems[i],
//       ),
//     );
//   }
//   return list;
// }
}
