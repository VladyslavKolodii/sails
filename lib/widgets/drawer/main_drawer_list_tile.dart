import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainDrawerListTile extends StatelessWidget {
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
    return ListTile(
      onTap: onTap ?? () => {},
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
