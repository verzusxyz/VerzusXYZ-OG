import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:verzusxyz/core/utils/my_color.dart';
import 'package:verzusxyz/core/utils/style.dart';

class CustomRadioButton extends StatefulWidget {
  final String? title;
  final String? selectedValue;
  final int selectedIndex;
  final List<String> list;
  final ValueChanged? onChanged;

  const CustomRadioButton({
    Key? key,
    this.title,
    this.selectedIndex = 0,
    this.selectedValue,
    required this.list,
    this.onChanged,
  }) : super(key: key);

  @override
  State<CustomRadioButton> createState() => _CustomRadioButtonState();
}

class _CustomRadioButtonState extends State<CustomRadioButton> {
  @override
  Widget build(BuildContext context) {
    if (widget.list.isEmpty) {
      return Container();
    }

    return Column(
      children: [
        widget.title != null ? const SizedBox() : Text(widget.title ?? ''),
        Column(
          children: List<RadioListTile<int>>.generate(widget.list.length, (
            int index,
          ) {
            return RadioListTile<int>(
              value: index,
              groupValue: widget.selectedIndex,
              activeColor: MyColor.activeIndicatorColor,
              title: Text(
                widget.list[index].tr,
                style: regularDefault.copyWith(
                  color: MyColor.colorWhite,
                  fontFamily: 'Inter',
                ),
              ),
              selected: index == widget.selectedIndex,
              onChanged: (int? value) {
                setState(() {
                  if (value != null) {
                    widget.onChanged!(index);
                  }
                });
              },
            );
          }),
        ),
      ],
    );
  }
}
