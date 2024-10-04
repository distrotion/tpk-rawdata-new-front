import 'package:flutter/material.dart';

import 'P01DASHBOARDVAR.dart';

class P01DASHBOARDMAIN extends StatelessWidget {
  const P01DASHBOARDMAIN({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 100,
          width: 100,
          color: Colors.blue,
          child: Text(P01DASHBOARDVAR.dataset01),
        ),
        Container(
          height: 100,
          width: 100,
          color: Colors.green,
          child: Text(P01DASHBOARDVAR2.dataset01),
        ),
      ],
    );
  }
}
