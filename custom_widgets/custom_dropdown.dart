import 'package:flutter/material.dart';
import 'package:ground_booking_admin/constants/color_constants.dart';
import 'custom_text.dart';

class CustomDropdown extends StatelessWidget {
  const CustomDropdown(
      {super.key,
      required this.items,
      this.label,
      
      required this.selectedItem,
      required this.onSelected});
  final List<String> items;
  final String selectedItem;
  final String? label;
  
  final void Function(String?)? onSelected;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: ColorConstants.buttonSecondaryColor),
          color: Colors.transparent),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label != null) ...[
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: CustomText(label ?? '',
                  color: Colors.grey, size: 12),
            )
          ],
          DropdownButton(
              isExpanded: true,
              underline: const SizedBox(),
              value: selectedItem,
              focusColor: Colors.transparent,
              items: items
                  .map((e) => DropdownMenuItem(value: e, child: CustomText(e,)))
                  .toList(),
              onChanged: onSelected),
              
        ],
      ),
    );
  }
}
