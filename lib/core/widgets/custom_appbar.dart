import 'package:flutter/material.dart';

class Customappbar extends StatelessWidget {
  const Customappbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 50,
      child: IconButton(onPressed: () {
        Navigator.pop(context);
      }, icon: const Icon(Icons.arrow_back),),
    );
  }
}