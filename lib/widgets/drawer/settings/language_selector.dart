import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:hybrid_sailmate/widgets/text_styles.dart';

class LanguageSelector extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final items = context.supportedLocales.map((item) => item.languageCode).toList();
    final selectedValue = useState(items.firstWhere((item) => item == context.locale.languageCode));

    return Padding(
      padding: EdgeInsets.only(
        top: 24,
        left: 24,
        right: 24,
      ),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.white,
          border: Border.all(color: Colors.white10, width: 1),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 18)],
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 16, right: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('drawer.settings.changeLanguage'.tr(), style: TextStyles.bottomSheetItemLabel()),
              DropdownButton(
                value: selectedValue.value,
                items: items.map((item) => DropdownMenuItem(value: item, child: Text(item))).toList(),
                onChanged: (value) {
                  selectedValue.value = value;
                  context.locale = Locale(value);
                },
              ),
            ],
          )
        ),
      )
    );
  }
}
