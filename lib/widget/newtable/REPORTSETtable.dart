import 'package:flutter/material.dart';

import 'tablebox.dart';

class FINISHEDGOODTRANFERHStable extends StatelessWidget {
  const FINISHEDGOODTRANFERHStable({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: rowbox_type0BS(
            Head: "date",
          ),
        ),
        Expanded(
          flex: 1,
          child: rowbox_type0BS(
            Head: "TYPE",
          ),
        ),
        Expanded(
          flex: 2,
          child: rowbox_type0BS(
            Head: "INSTRUMENT",
          ),
        ),
        Expanded(
          flex: 1,
          child: rowbox_type0BS(
            Head: "NUMBER",
          ),
        ),
        Expanded(
          flex: 1,
          child: rowbox_type0BS(
            Head: "POINT",
          ),
        ),
        Expanded(
          flex: 6,
          child: rowbox_type0BS(
            Head: "DATA",
          ),
        ),
      ],
    );
  }
}

class FINISHEDGOODTRANFERHSitem extends StatelessWidget {
  FINISHEDGOODTRANFERHSitem({
    super.key,
    this.text01,
    this.text02,
    this.text03,
    this.text04,
    this.text05,
    this.text06,
    this.text07,
    this.text08,
    this.text09,
    this.text10,
    this.text11,
    this.text12,
    this.holding,
    this.Wid01,
    this.pic,
  });

  String? text01;
  String? text02;
  String? text03;
  String? text04;
  String? text05;
  String? text06;
  String? text07;
  String? text08;
  String? text09;
  String? text10;
  String? text11;
  String? text12;

  Widget? Wid01;

  bool? holding;

  bool? pic;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: rowbox_type0BS(
            Head: text01,
            // Colorss: (holding ?? 0) % 2 == 0 ? Colors.white : Colors.grey,
            Colorss: holding ?? false ? Colors.grey.shade300 : Colors.white,
          ),
        ),
        Expanded(
          flex: 1,
          child: rowbox_type0BS(
            Head: text02,
            // Colorss: (holding ?? 0) % 2 == 0 ? Colors.white : Colors.grey,
            Colorss: holding ?? false ? Colors.grey.shade300 : Colors.white,
          ),
        ),
        Expanded(
          flex: 2,
          child: rowbox_type0BS(
            Head: text06,
            // Colorss: (holding ?? 0) % 2 == 0 ? Colors.white : Colors.grey,
            Colorss: holding ?? false ? Colors.grey.shade300 : Colors.white,
          ),
        ),
        Expanded(
          flex: 1,
          child: rowbox_type0BS(
            Head: text03,
            // Colorss: (holding ?? 0) % 2 == 0 ? Colors.white : Colors.grey,
            Colorss: holding ?? false ? Colors.grey.shade300 : Colors.white,
          ),
        ),
        Expanded(
          flex: 1,
          child: rowbox_type0BS(
            Head: text04,
            // Colorss: (holding ?? 0) % 2 == 0 ? Colors.white : Colors.grey,
            Colorss: holding ?? false ? Colors.grey.shade300 : Colors.white,
          ),
        ),
        Expanded(
          flex: 6,
          child: Column(
            children: [
              if (pic ?? false) ...[
                rowbox_type0BS(
                  Head: text05,
                  // Colorss: (holding ?? 0) % 2 == 0 ? Colors.white : Colors.grey,
                  Colorss:
                      holding ?? false ? Colors.grey.shade300 : Colors.white,
                ),
              ] else ...[
                Wid01 ?? SizedBox(),
              ]
              //
            ],
          ),
        ),

        // Expanded(
        //   flex: 1,
        //   child: rowbox_type0_NB(
        //     Head: text10,
        //     // Colorss: (holding ?? 0) % 2 == 0 ? Colors.white : Colors.grey,
        //     Colorss: holding ?? false ? Colors.grey.shade300 : Colors.white,
        //   ),
        // ),
      ],
    );
  }
}
