import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:verzusxyz/core/utils/my_images.dart';
import 'package:verzusxyz/core/utils/util.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:verzusxyz/core/utils/dimensions.dart';
import 'package:verzusxyz/core/utils/my_color.dart';
import 'package:verzusxyz/core/utils/style.dart';
import 'package:verzusxyz/view/components/text/label_text.dart';

/// A custom text field widget.
class CustomTextField extends StatefulWidget {
  /// The label text for the text field.
  final String? labelText;

  /// The hint text for the text field.
  final String? hintText;

  /// The callback function to execute when the text field value changes.
  final Function? onChanged;

  /// The controller for the text field.
  final TextEditingController? controller;

  /// The focus node for the text field.
  final FocusNode? focusNode;

  /// The next focus node to move to when the text field is submitted.
  final FocusNode? nextFocus;

  /// The callback function to execute when the text field is tapped.
  final VoidCallback? onTap;

  /// The validator for the text field.
  final FormFieldValidator? validator;

  /// The text input type for the text field.
  final TextInputType? textInputType;

  /// Whether the text field is enabled.
  final bool isEnable;

  /// Whether the text field is for a password.
  final bool isPassword;

  /// Whether to show the suffix icon.
  final bool isShowSuffixIcon;

  /// Whether the suffix is an icon.
  final bool isIcon;

  /// The callback function to execute when the suffix icon is tapped.
  final VoidCallback? onSuffixTap;

  /// Whether the text field is for searching.
  final bool isSearch;

  /// Whether the text field is for a country picker.
  final bool isCountryPicker;

  /// The input action for the text field.
  final TextInputAction inputAction;

  /// Whether the text field needs an outline border.
  final bool needOutlineBorder;

  /// Whether the text field is read-only.
  final bool readOnly;

  /// Whether the text field needs a required sign.
  final bool needRequiredSign;

  /// The maximum number of lines for the text field.
  final int maxLines;

  /// Whether to use an animated label.
  final bool animatedLabel;

  /// The fill color for the text field.
  final Color fillColor;

  /// The color of the label text.
  final Color labelTextColor;

  /// The color of the border.
  final Color borderColor;

  /// The color of the disabled border.
  final Color disableBorderColor;

  /// Whether the text field is required.
  final bool isRequired;

  /// Whether the suffix is an image.
  final bool isSuffixImage;

  /// Whether the suffix is a container.
  final bool isSuffixContainer;

  /// Whether the text field has a percent sign.
  final bool hasPercent;

  /// Whether the label text has a specific size.
  final bool hasLabelTextSize;

  /// Whether to align the text to the center.
  final bool textAlign;

  /// Whether to limit the input.
  final bool limitTheInput;

  /// The image for the suffix.
  final String? suffixImage;

  /// The currency symbol for the suffix.
  final String? currrency;

  /// The border radius of the text field.
  final double borderRadious;

  /// The font size of the label text.
  final double labelTextSize;

  /// The maximum length of the text field.
  final int? maxLength;

  /// Creates a new [CustomTextField] instance.
  const CustomTextField({
    Key? key,
    this.labelText,
    this.readOnly = false,
    this.fillColor = MyColor.colorBgCard,
    this.labelTextColor = MyColor.colorWhite,
    this.borderColor = MyColor.textFieldEnableBorderColor,
    this.disableBorderColor = MyColor.textFieldDisableBorderColor,
    required this.onChanged,
    this.hintText,
    this.controller,
    this.onTap,
    this.focusNode,
    this.nextFocus,
    this.validator,
    this.limitTheInput = false,
    this.textInputType,
    this.isEnable = true,
    this.isPassword = false,
    this.isShowSuffixIcon = false,
    this.isIcon = false,
    this.onSuffixTap,
    this.isSearch = false,
    this.isCountryPicker = false,
    this.inputAction = TextInputAction.next,
    this.needOutlineBorder = false,
    this.needRequiredSign = false,
    this.maxLines = 1,
    this.animatedLabel = false,
    this.isRequired = false,
    this.isSuffixImage = false,
    this.isSuffixContainer = false,
    this.hasPercent = false,
    this.suffixImage = "",
    this.currrency = "",
    this.borderRadious = 8,
    this.labelTextSize = 0,
    this.hasLabelTextSize = false,
    this.maxLength,
    this.textAlign = false,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return widget.needOutlineBorder
        ? widget.animatedLabel
            ? TextFormField(
                maxLines: widget.maxLines,
                maxLength: widget.maxLength,
                readOnly: widget.readOnly,
                style: widget.hasLabelTextSize
                    ? TextStyle(fontSize: 20, color: MyColor.textColor2)
                    : regularDefault.copyWith(
                        color: MyColor.getTextColor(),
                        fontFamily: 'Inter',
                      ),
                cursorColor: MyColor.getTextColor(),
                controller: widget.controller,
                autofocus: false,
                textAlign:
                    widget.textAlign ? TextAlign.center : TextAlign.left,
                textInputAction: widget.inputAction,
                enabled: widget.isEnable,
                focusNode: widget.focusNode,
                validator: widget.validator,
                keyboardType: widget.textInputType,
                obscureText: widget.isPassword ? obscureText : false,
                decoration: InputDecoration(
                  counterText: "",
                  labelText: widget.labelText?.tr ?? '',
                  labelStyle: widget.hasLabelTextSize
                      ? semiBoldExtraLarge.copyWith(
                          color: widget.labelTextColor,
                          fontFamily: 'Inter',
                        )
                      : regularLarge.copyWith(
                          color: widget.labelTextColor,
                          fontFamily: 'Inter',
                        ),
                  hintText:
                      widget.hintText ?? '', // Set to empty string if null
                  hintStyle: regularSmall.copyWith(
                    fontSize: Dimensions.fontDefault,
                    color: MyColor.getHintTextColor().withOpacity(0.7),
                    fontFamily: 'Inter',
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  contentPadding: const EdgeInsets.only(
                    top: 5,
                    left: 15,
                    right: 15,
                    bottom: 5,
                  ),
                  fillColor: widget.fillColor,
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 0.5,
                      color: widget.disableBorderColor,
                    ),
                    borderRadius: BorderRadius.circular(
                      Dimensions.defaultRadius,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 0.5,
                      color: widget.borderColor,
                    ),
                    borderRadius: BorderRadius.circular(
                      Dimensions.defaultRadius,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 0.5,
                      color: widget.disableBorderColor,
                    ),
                    borderRadius: BorderRadius.circular(
                      Dimensions.defaultRadius,
                    ),
                  ),
                  suffixIcon: SizedBox(
                    width: 65,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (widget.isShowSuffixIcon)
                          IconButton(
                            onPressed: _toggle,
                            icon: Icon(
                              widget.isSearch
                                  ? Icons.search_outlined
                                  : widget.isCountryPicker
                                      ? Icons.arrow_drop_down_outlined
                                      : obscureText
                                          ? Icons.visibility_off_outlined
                                          : Icons.visibility_outlined,
                              size: 20,
                              color: MyColor.colorWhite,
                            ),
                          ),
                        if (widget.isSuffixContainer)
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: MyColor.navBarActiveButtonColor,
                            ),
                            margin:
                                const EdgeInsets.all(Dimensions.space5),
                            padding:
                                const EdgeInsets.all(Dimensions.space10),
                            width: Dimensions.space55,
                            child: Center(
                              child: Text(
                                widget.currrency ?? "",
                                style: semiBoldDefault.copyWith(
                                  fontFamily: 'Inter',
                                ),
                              ),
                            ),
                          ),
                        if (widget.hasPercent)
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: MyColor.navBarActiveButtonColor,
                            ),
                            margin:
                                const EdgeInsets.all(Dimensions.space5),
                            padding:
                                const EdgeInsets.all(Dimensions.space10),
                            width: Dimensions.space55,
                            child: Center(
                              child: Text(
                                MyUtils.getPercentSign(),
                                style: semiBoldDefault.copyWith(
                                  fontFamily: 'Inter',
                                ),
                              ),
                            ),
                          ),
                        if (widget.isSuffixImage)
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: Image.asset(
                              widget.suffixImage!,
                              height: 25,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                onFieldSubmitted: (text) => widget.nextFocus != null
                    ? FocusScope.of(context).requestFocus(widget.nextFocus)
                    : null,
                onChanged: (text) => widget.onChanged!(text),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LabelText(
                    text: widget.labelText.toString(),
                    isRequired: widget.isRequired,
                  ),
                  const SizedBox(height: Dimensions.textToTextSpace),
                  TextFormField(
                    maxLines: widget.maxLines,
                    readOnly: widget.readOnly,
                    style: regularDefault.copyWith(
                      color: MyColor.getTextColor(),
                      fontFamily: 'Inter',
                    ),
                    maxLength: widget.maxLength,
                    cursorColor: MyColor.getTextColor(),
                    controller: widget.controller,
                    autofocus: false,
                    textInputAction: widget.inputAction,
                    enabled: widget.isEnable,
                    focusNode: widget.focusNode,
                    validator: widget.validator,
                    keyboardType: widget.textInputType,
                    obscureText: widget.isPassword ? obscureText : false,
                    decoration: InputDecoration(
                      counterText: "",
                      contentPadding: const EdgeInsets.only(
                        top: 5,
                        left: 15,
                        right: 15,
                        bottom: 5,
                      ),
                      hintText: widget.hintText != null
                          ? widget.hintText!.tr
                          : '',
                      hintStyle: regularSmall.copyWith(
                        fontSize: Dimensions.fontDefault,
                        color:
                            MyColor.getHintTextColor().withOpacity(0.7),
                        fontFamily: 'Inter',
                      ),
                      fillColor: widget.fillColor,
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 0.5,
                          color: MyColor.bottomColor,
                        ),
                        borderRadius: BorderRadius.circular(
                          widget.borderRadious,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 0.5,
                          color: MyColor.bottomColor,
                        ),
                        borderRadius: BorderRadius.circular(
                          widget.borderRadious,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 0.5,
                          color: MyColor.bottomColor,
                        ),
                        borderRadius: BorderRadius.circular(
                          widget.borderRadious,
                        ),
                      ),
                      prefixIcon: widget.isSearch
                          ? Padding(
                              padding: const EdgeInsets.only(
                                left: 15,
                                top: 15,
                                bottom: 15,
                                right: 5,
                              ),
                              child: SvgPicture.asset(
                                MyImages.searchIconSvg,
                                height: 15,
                              ),
                            )
                          : null,
                      suffixIcon: widget.isShowSuffixIcon
                          ? widget.isPassword
                              ? IconButton(
                                  icon: Icon(
                                    obscureText
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: MyColor.hintTextColor,
                                    size: 20,
                                  ),
                                  onPressed: _toggle,
                                )
                              : widget.isIcon
                                  ? IconButton(
                                      onPressed: widget.onSuffixTap,
                                      icon: Icon(
                                        widget.isSearch
                                            ? Icons.search_outlined
                                            : widget.isCountryPicker
                                                ? Icons
                                                    .arrow_drop_down_outlined
                                                : Icons.camera_alt_outlined,
                                        size: 25,
                                        color: MyColor.getPrimaryColor(),
                                      ),
                                    )
                                  : null
                          : null,
                    ),
                    onFieldSubmitted: (text) => widget.nextFocus != null
                        ? FocusScope.of(
                            context,
                          ).requestFocus(widget.nextFocus)
                        : null,
                    onChanged: (text) => widget.onChanged!(text),
                    onTap: widget.onTap,
                  ),
                ],
              )
        : TextFormField(
            maxLength: widget.maxLength,
            maxLines: widget.maxLines,
            readOnly: widget.readOnly,
            style:
                regularDefault.copyWith(color: MyColor.getTextColor()),
            //textAlign: TextAlign.left,
            cursorColor: MyColor.getHintTextColor(),
            controller: widget.controller,
            autofocus: false,
            textInputAction: widget.inputAction,
            enabled: widget.isEnable,
            focusNode: widget.focusNode,
            validator: widget.validator,
            keyboardType: widget.textInputType,
            obscureText: widget.isPassword ? obscureText : false,
            decoration: InputDecoration(
              counterText: "",
              contentPadding: const EdgeInsets.only(
                top: 5,
                left: 0,
                right: 0,
                bottom: 5,
              ),
              labelText: widget.labelText?.tr,
              labelStyle: regularDefault.copyWith(
                color: MyColor.getLabelTextColor(),
              ),
              fillColor: MyColor.transparentColor,
              filled: true,
              border: UnderlineInputBorder(
                borderSide: BorderSide(
                  width: 0.5,
                  color: MyColor.getTextFieldDisableBorder(),
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  width: 0.5,
                  color: MyColor.getTextFieldEnableBorder(),
                ),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  width: 0.5,
                  color: MyColor.getTextFieldDisableBorder(),
                ),
              ),
              suffixIcon: widget.isShowSuffixIcon
                  ? widget.isPassword
                      ? IconButton(
                          icon: Icon(
                            widget.isPassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: MyColor.hintTextColor,
                            size: 20,
                          ),
                          onPressed: _toggle,
                        )
                      : widget.isIcon
                          ? IconButton(
                              onPressed: widget.onSuffixTap,
                              icon: Icon(
                                widget.isSearch
                                    ? Icons.search_outlined
                                    : widget.isCountryPicker
                                        ? Icons
                                            .arrow_drop_down_outlined
                                        : Icons.camera_alt_outlined,
                                size: 25,
                                color: MyColor.getPrimaryColor(),
                              ),
                            )
                          : null
                  : null,
            ),
            onFieldSubmitted: (text) => widget.nextFocus != null
                ? FocusScope.of(context).requestFocus(widget.nextFocus)
                : null,
            onChanged: (text) => widget.onChanged!(text),
            onTap: widget.onTap,
          );
  }

  void _toggle() {
    setState(() {
      obscureText = !obscureText;
    });
  }
}
