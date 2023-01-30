import 'package:flutter/material.dart';

class ChartBar extends StatefulWidget {
  ChartBar(
      {super.key,
      required this.label,
      required this.spendingAmount,
      required this.spendingPctOfTotal});
  final String label;
  final double spendingAmount;
  final double spendingPctOfTotal;

  @override
  State<ChartBar> createState() => _ChartBarState();
}

class _ChartBarState extends State<ChartBar> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constaints) {
      return Column(
        children: [
          SizedBox(
            height: constaints.maxHeight * 0.05,
          ),
          Container(
            height: constaints.maxHeight * 0.1,
            child: FittedBox(
              child: Text('\$${widget.spendingAmount.toStringAsFixed(0)}'),
            ),
          ),
          SizedBox(
            height: constaints.maxHeight * 0.05,
          ),
          Container(
            width: 10,
            height: constaints.maxHeight * 0.6,
            child: Stack(children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 1),
                    color: Color.fromRGBO(220, 220, 220, 1),
                    borderRadius: BorderRadius.circular(10)),
              ),
              FractionallySizedBox(
                heightFactor: widget.spendingPctOfTotal,
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).primaryColor)),
              ),
            ]),
          ),
          SizedBox(
            height: constaints.maxHeight * 0.05,
          ),
          Container(
              height: constaints.maxHeight * 0.1,
              child: FittedBox(child: Text('${widget.label}'))),
        ],
      );
    });
  }
}
