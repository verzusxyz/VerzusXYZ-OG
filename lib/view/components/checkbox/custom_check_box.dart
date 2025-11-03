import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:verzusxyz/core/utils/my_color.dart';
import 'package:verzusxyz/core/utils/style.dart';

/// A custom checkbox widget.
class CustomCheckBox extends StatefulWidget {
  /// The list of selected values.
  final List<String>? selectedValue;

  /// The list of checkbox options.
  final List<String> list;

  /// The callback function to execute when the checkbox value changes.
  final ValueChanged? onChanged;

  /// Creates a new [CustomCheckBox] instance.
  const CustomCheckBox({
    Key? key,
    this.selectedValue,
    required this.list,
    this.onChanged,
  }) : super(key: key);

  @override
  State<CustomCheckBox> createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  @override
  Widget build(BuildContext context) {
    if (widget.list.isEmpty) {
      return Container();
    }
    return Column(
      children: [
        Column(
          children: List<CheckboxListTile>.generate(widget.list.length, (
            int index,
          ) {
            List<String>? s = widget.selectedValue;
            bool selected_ = s != null ? s.contains(widget.list[index]) : false;
            return CheckboxListTile(
              value: selected_,
              activeColor: MyColor.activeIndicatorColor,
              title: Text(
                widget.list[index].tr,
                style: regularDefault.copyWith(
                  color: MyColor.colorWhite,
                  fontFamily: 'Inter',
                ),
              ),
              onChanged: (bool? value) {
                setState(() {
                  if (value != null) {
                    widget.onChanged!('${index}_$value');
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
