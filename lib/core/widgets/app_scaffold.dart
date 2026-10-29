import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    super.key,
    required this.body,
    this.padding = const EdgeInsets.symmetric(horizontal: 16),
    this.appBar,
    this.bottomNavigationBar,
    this.floatingActionButton,
  });

  final Widget body;
  final EdgeInsetsGeometry padding;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
      body: SafeArea(
        child: Padding(padding: padding, child: body),
      ),
    );
  }
}
