import 'package:deli_pos/component/constants.dart';
import 'package:deli_pos/layouts/custom_gridview.dart';
import 'package:flutter/material.dart';

class ResponsiveLayout extends StatefulWidget {
  const ResponsiveLayout({super.key});

  @override
  _ResponsiveLayoutState createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, dimens) {
        if (dimens.maxWidth <= kMobileBreakpoint) {
          return const CustomGridView(
            columnRatio: 6,
          );
        } else if (dimens.maxWidth > kMobileBreakpoint &&
            dimens.maxWidth <= kTabletBreakpoint) {
          return const CustomGridView(
            columnRatio: 4,
          );
        } else if (dimens.maxWidth > kTabletBreakpoint &&
            dimens.maxWidth <= kDesktopBreakPoint) {
          return const CustomGridView(
            columnRatio: 3,
          );
        } else {
          return const CustomGridView(columnRatio: 2);
        }
      },
    );
  }
}
