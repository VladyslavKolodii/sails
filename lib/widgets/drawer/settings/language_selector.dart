import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:hybrid_sailmate/widgets/common/input_scaffold.dart';
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
      child: InputScaffold(
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
        ),
      ),
    );
  }
}
