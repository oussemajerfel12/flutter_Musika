import 'package:flutter/material.dart';

import 'Mygradient.dart';

class loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: MyGradient.getGradient()),
      child: Center(
        child: CircularProgressIndicator(
          color: Colors.white.withOpacity(1),
          backgroundColor: Colors.grey,
        ),
      ),
    );
  }
}
