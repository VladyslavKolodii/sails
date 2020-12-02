import 'package:flutter/material.dart';
import 'package:fontisto_flutter/fontisto_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hybrid_sailmate/widgets/drawer/main_drawer_list_tile.dart';
import 'package:hybrid_sailmate/widgets/main_button_decoration.dart';

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
                  children: [MainDrawerListTile(label: 'My profile', icon: Istos.person)],
                ),
              ),
              Divider(),
              Container(
                height: 60,
                child: MainDrawerListTile(label: 'Saved routes', icon: Istos.star, onTap: () {
                  Navigator.of(context).pop();
                  _modalBottomSheet(context, 'Saved routes');
                }),
              ),
              Container(
                height: 60,
                child: MainDrawerListTile(label: 'Tracked routes', icon: Istos.history, onTap: () {
                  Navigator.of(context).pop();
                  _modalBottomSheet(context, 'Tracked routes');
                }),
              ),
              Container(
                height: 60,
                child: MainDrawerListTile(label: 'Saved places', icon: Istos.heart, onTap: () {
                  Navigator.of(context).pop();
                  _modalBottomSheet(context, 'Saved places');
                }),
              ),
              Divider(),
              Container(
                height: 60,
                child: MainDrawerListTile(label: 'Download chart for offline use', icon: Istos.cloud_down, onTap: () {
                  Navigator.of(context).pop();
                  _modalBottomSheet(context, 'Download chart for offline use');
                }),
              ),
              Container(
                height: 60,
                child: MainDrawerListTile(label: 'Settings', icon: Istos.spinner_cog, onTap: () {
                  Navigator.of(context).pop();
                  _modalBottomSheet(context, 'Settings');
                }),
              ),
              Container(
                height: 60,
                child: MainDrawerListTile(label: 'Subscriptions', icon: Istos.wallet, onTap: () {
                  Navigator.of(context).pop();
                  _modalBottomSheet(context, 'Subscriptions');
                }),
              ),
              Divider(),
              Container(
                height: 60,
                child: MainDrawerListTile(label: 'Help Center', icon: Istos.info, onTap: () {
                  Navigator.of(context).pop();
                  _modalBottomSheet(context, 'Help Center');
                }),
              ),
              Container(
                height: 60,
                child: MainDrawerListTile(label: 'Terms & conditions', icon: Istos.check, onTap: () {
                  Navigator.of(context).pop();
                  _modalBottomSheet(context, 'Terms & conditions');
                }),
              ),
              Divider(),
              Container(
                height: 102,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [MainDrawerListTile(label: 'Logout', icon: Icons.logout)],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void _modalBottomSheet(context, label){
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
                  Expanded(child: Center(child: Text(label, style: GoogleFonts.lato(fontSize: 22)))),
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
                    child: ListView.builder(
                      itemCount: 25,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(title: Text('Item $index'));
                      },
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
