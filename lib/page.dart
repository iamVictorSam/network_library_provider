import 'package:flutter/material.dart';

abstract class ExamplePage extends StatelessWidget {
  const ExamplePage(this.leading, this.title, {super.key});

  final Widget leading;
  final String title;
}
