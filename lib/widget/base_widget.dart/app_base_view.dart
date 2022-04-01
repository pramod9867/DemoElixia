import 'package:flutter/material.dart';

class AppBaseView extends StatefulWidget {
  final Widget child;

  const AppBaseView({ Key? key,required this.child }) : super(key: key);

  @override
  State<AppBaseView> createState() => _AppBaseViewState();
}

class _AppBaseViewState extends State<AppBaseView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
    );
  }
}