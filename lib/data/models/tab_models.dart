import 'package:flutter/material.dart';

class TabHeader {
  final IconData icon;
  final String? text;

  const TabHeader({required this.icon, this.text});

  Tab get createTab => Tab(icon: Icon(icon), text: text);
}
