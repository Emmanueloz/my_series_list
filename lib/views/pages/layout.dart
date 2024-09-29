import 'package:flutter/material.dart';
import 'package:my_series_list/views/components/custom_navigation_bar.dart';

class LayoutPage extends StatelessWidget {
  final AppBar appBar;
  final Widget body;
  final Widget? floatingActionButton;
  final bool showNavigationBar;
  const LayoutPage({
    super.key,
    required this.appBar,
    required this.body,
    this.floatingActionButton,
    this.showNavigationBar = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: body,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar:
          showNavigationBar ? const CustomNavigationBar() : null,
    );
  }
}
