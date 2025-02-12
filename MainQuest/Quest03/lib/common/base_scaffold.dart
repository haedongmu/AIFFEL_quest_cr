// base_scaffold.dart
import 'package:flutter/material.dart';
import 'custom_app_bar.dart';
import 'app_drawer.dart';

class BaseScaffold extends StatelessWidget {
  final String title;
  final Widget body;
  final Widget? bottomNavigationBar;

  const BaseScaffold({
    Key? key,
    required this.title,
    required this.body,
    this.bottomNavigationBar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppDrawer를 모든 페이지에 포함
      drawer: AppDrawer(),
      appBar: CustomAppBar(title: title),
      body: body,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
