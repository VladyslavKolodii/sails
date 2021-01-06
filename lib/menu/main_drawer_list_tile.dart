import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';

class MainDrawerListTile extends HookWidget {
  MainDrawerListTile({
    @required this.label,
    @required this.icon,
    this.onTap
  }) : assert(label != null),
    assert(icon != null);

  final String label;
  final IconData icon;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    var selected = useState(false);
    return ListTile(
      selected: selected.value,
      onTap: () {
        selected.value = true;
        Future.delayed(Duration(milliseconds: 200), onTap ?? () => {});
      },
      tileColor: Colors.transparent,
      selectedTileColor: Colors.white,
      title: Text(label, style: GoogleFonts.lato(
        fontSize: 16
      )),
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Icon(icon, size: 16, color: Color(int.parse('0xff4B7CC6')))]
      )
    );
  }
}
