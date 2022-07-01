import 'package:flutter/material.dart';

import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Practice extends StatelessWidget {
  const Practice({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Container(
              width: 250,
              height: 100,
              child: Column(
                  children: [Text("some text"), Text(("it can be set"))])),
          Column(children: [Text("can be")])
        ],
      ),
    );
  }
}
