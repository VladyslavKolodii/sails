import 'package:flutter/material.dart';
import 'package:fontisto_flutter/fontisto_flutter.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:hybrid_sailmate/widgets/drawer/main_drawer_list_tile.dart';
import 'package:hybrid_sailmate/widgets/drawer/settings/language_selector.dart';
import 'package:hybrid_sailmate/widgets/main_button_decoration.dart';
import 'package:hybrid_sailmate/widgets/text_styles.dart';

final color = Color(int.parse('0xffF2F5F9'));
final barrierColor = Color(int.parse('0xffD6DFF0'));
class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color
        ),
        child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: ListView(
            children: [
              Container(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [IconButton(
                    color: Colors.grey,
                    iconSize: 24,
                    icon: Icon(Istos.close),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )]
                )
              ),
              Container(
                height: 102,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [MainDrawerListTile(label: 'drawer.profileTitle'.tr(), icon: Istos.person)],
                ),
              ),
              Divider(),
              Container(
                height: 60,
                child: MainDrawerListTile(label: 'drawer.routesTitle'.tr(), icon: Istos.star, onTap: () {
                  Navigator.of(context).pop();
                  _modalBottomSheet(context, 'drawer.routesTitle');
                }),
              ),
              Container(
                height: 60,
                child: MainDrawerListTile(label: 'drawer.tracksTitle'.tr(), icon: Istos.history, onTap: () {
                  Navigator.of(context).pop();
                  _modalBottomSheet(context, 'drawer.tracksTitle');
                }),
              ),
              Container(
                height: 60,
                child: MainDrawerListTile(label: 'drawer.placesTitle'.tr(), icon: Istos.heart, onTap: () {
                  Navigator.of(context).pop();
                  _modalBottomSheet(context, 'drawer.placesTitle');
                }),
              ),
              Divider(),
              Container(
                height: 60,
                child: MainDrawerListTile(label: 'drawer.offlineChartTitle'.tr(), icon: Istos.cloud_down, onTap: () {
                  Navigator.of(context).pop();
                  _modalBottomSheet(context, 'drawer.offlineChartTitle');
                }),
              ),
              Container(
                height: 60,
                child: MainDrawerListTile(label: 'drawer.settingsTitle'.tr(), icon: Istos.spinner_cog, onTap: () {
                  Navigator.of(context).pop();
                  _modalBottomSheet(context, 'drawer.settingsTitle', content: [LanguageSelector()]);
                }),
              ),
              Container(
                height: 60,
                child: MainDrawerListTile(label: 'drawer.subscriptionsTitle'.tr(), icon: Istos.wallet, onTap: () {
                  Navigator.of(context).pop();
                  _modalBottomSheet(context, 'drawer.subscriptionsTitle');
                }),
              ),
              Divider(),
              Container(
                height: 60,
                child: MainDrawerListTile(label: 'drawer.helpTitle'.tr(), icon: Istos.info, onTap: () {
                  Navigator.of(context).pop();
                  _modalBottomSheet(context, 'drawer.helpTitle');
                }),
              ),
              Container(
                height: 60,
                child: MainDrawerListTile(label: 'drawer.termsTitle'.tr(), icon: Istos.check, onTap: () {
                  Navigator.of(context).pop();
                  _modalBottomSheet(context, 'drawer.termsTitle');
                }),
              ),
              Divider(),
              Container(
                height: 102,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [MainDrawerListTile(label: 'drawer.logoutTitle'.tr(), icon: Icons.logout)],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void _modalBottomSheet(context, key, { content }){
  showModalBottomSheet(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    backgroundColor: Colors.transparent,
    context: context,
    isScrollControlled: true,
    barrierColor: barrierColor.withAlpha(200),
    builder: (BuildContext context) {
      return Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 24, bottom: 16, right: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 46,
                    width: 46,
                    child: DecoratedBox(
                      decoration: MainButtonDecoration(),
                      child: FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Icon(Istos.arrow_left, color: Colors.grey, size: 12),
                      ),
                    ),
                  ),
                  Expanded(child: Center(child: Text(tr(key), style: TextStyles.bottomSheetTitle()))),
                  SizedBox(width: 46),
                ],
              ),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height / 4.0 * 3.0,
              ),
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                      color: color
                    ),
                    child: ListView(
                      children: content ?? Row()
                    ),
                  ),
                ]
              )
            ),
          ],
        )
      );
    }
  );
}
