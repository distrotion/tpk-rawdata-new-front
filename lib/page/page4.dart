import 'package:flutter/material.dart';

import 'P4SELECTPLANTFORP2/P4SELECTPLANTFORP2MAIN.dart';

class Page4 extends StatelessWidget {
  const Page4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Page4Body();
  }
}

class Page4Body extends StatelessWidget {
  const Page4Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: P4SELECTPLANTmain());
  }
}
