import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:verzusxyz/core/utils/my_images.dart';
import 'package:verzusxyz/core/utils/util.dart';
import 'package:verzusxyz/view/components/text/label_text_with_instructions.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:verzusxyz/core/utils/dimensions.dart';
import 'package:verzusxyz/core/utils/my_color.dart';
import 'package:verzusxyz/core/utils/style.dart';
import 'package:verzusxyz/view/components/text/label_text.dart';

class CustomTextField extends StatefulWidget {
  final String? instructions;
  final String? labelText;
  final String? hintText;
  final Function? onChanged;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final VoidCallback? onTap;
  final FormFieldValidator? validator;
  final TextInputType? textInputType;
  final bool isEnable;
  final bool isPassword;
  final bool isShowSuffixIcon;
  final bool isIcon;
  final VoidCallback? onSuffixTap;
  final bool isSearch;
  final bool isCountryPicker;
  final TextInputAction inputAction;
  final bool needOutlineBorder;
  final bool readOnly;
  final bool needRequiredSign;
  final int maxLines;
  final bool animatedLabel;
  final Color fillColor;
  final Color labelTextColor;
  final Color borderColor;
  final Color disableBorderColor;
  final bool isRequired;
  final bool isSuffixImage;
  final bool isSuffixContainer;
  final bool hasPercent;
  final bool hasLabelTextSize;
  final bool textAlign;
  final bool limitTheInput;
  final String? suffixImage;
  final String? currrency;
  final double borderRadious;
  final double labelTextSize;
  final int? maxLength;

  const CustomTextField({
    Key? key,
    this.instructions,
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
                  textAlign: widget.textAlign
                      ? TextAlign.center
                      : TextAlign.left,
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
                              margin: const EdgeInsets.all(Dimensions.space5),
                              padding: const EdgeInsets.all(Dimensions.space10),
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
                              margin: const EdgeInsets.all(Dimensions.space5),
                              padding: const EdgeInsets.all(Dimensions.space10),
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
                    LabelTextInstruction(
                      text: widget.labelText.toString(),
                      isRequired: widget.isRequired,
                      instructions: widget.instructions,
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
                          color: MyColor.getHintTextColor().withOpacity(0.7),
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
                                            ? Icons.arrow_drop_down_outlined
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
            style: regularDefault.copyWith(color: MyColor.getTextColor()),
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
                                  ? Icons.arrow_drop_down_outlined
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
