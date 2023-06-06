library good_search_appbar;

import 'package:flutter/material.dart';
import 'package:good_search_appbar/search_bar.dart';

class GoodSearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  const GoodSearchAppBar({
    Key? key,
    required this.title,
    required this.onSearchChanged,
    this.onFilterChanged,
    this.filter = false,
    this.focus = true,
    this.labelStyle,
    this.searchIcon,
    this.clearIcon,
    this.filterIcon,
    this.hintText,
    this.hintStyle,
    this.cursorColor,
    this.leading = true,
    this.leadingIcon,
    this.leadingWith,
    this.elevation,
    this.backgroundColor,
    this.foregroundColor,
  }) : super(key: key);

  final String title;
  final Function(String) onSearchChanged;
  final Function()? onFilterChanged;
  final bool? filter;
  final bool? focus;
  final TextStyle? labelStyle;
  final Widget? searchIcon;
  final Widget? clearIcon;
  final Widget? filterIcon;
  final String? hintText;
  final TextStyle? hintStyle;
  final Color? cursorColor;
  final bool leading;
  final Widget? leadingIcon;
  final double? leadingWith;
  final double? elevation;
  final Color? backgroundColor;
  final Color? foregroundColor;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: SearchBarWidget(
        label: title,
        focus: focus,
        onSearchChanged: onSearchChanged,
        clearIcon: clearIcon,
        cursorColor: cursorColor,
        filter: filter,
        filterIcon: filterIcon,
        hintStyle: hintStyle,
        hintText: hintText,
        labelStyle: labelStyle,
        onFilterChanged: onFilterChanged,
        searchIcon: searchIcon,
      ),
      leading: !leading ? const SizedBox() : leadingIcon,
      leadingWidth: !leading ? 0 : leadingWith,
      elevation: elevation,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
