import 'package:deli_pos/component/constants.dart';
import 'package:deli_pos/layouts/custom_gridview.dart';
import 'package:flutter/material.dart';

class ResponsiveLayout extends StatefulWidget {
  final dynamic data;

  const ResponsiveLayout({super.key, this.data});

  @override
  _ResponsiveLayoutState createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, dimens) {
        if (dimens.maxWidth <= kMobileBreakpoint) {
          return CustomGridView(columnRatio: 6, data: widget.data);
        } else if (dimens.maxWidth > kMobileBreakpoint &&
            dimens.maxWidth <= kTabletBreakpoint) {
          return CustomGridView(columnRatio: 4, data: widget.data);
        } else if (dimens.maxWidth > kTabletBreakpoint &&
            dimens.maxWidth <= kDesktopBreakPoint) {
          return CustomGridView(columnRatio: 3, data: widget.data);
        } else {
          return CustomGridView(columnRatio: 2, data: widget.data);
        }
      },
    );
  }
}
