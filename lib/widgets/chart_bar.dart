import 'package:flutter/material.dart';

import '../helpers.dart';

class ChartBar extends StatelessWidget {
  final String day;
  final double amt;
  final double factor;
  final bool isLight;

  ChartBar(
      {required this.day,
      required this.amt,
      required this.factor,
      required this.isLight});

  @override
  Widget build(BuildContext context) {
    Color primaryColor = isLight
        ? Theme.of(context).primaryColorLight
        : Theme.of(context).primaryColorDark;

    return LayoutBuilder(builder: (context, constraints) {
      double height = constraints.maxHeight;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: height * 0.13,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: height * 0.01),
              child: FittedBox(
                child: Text(
                  '\$',
                  style: TextStyle(
                      color: primaryColor,
                      fontFamily: 'Quicksand',
                      fontSize: 20,
                      fontWeight: FontWeight.w300),
                  softWrap: true,
                ),
              ),
            ),
          ),
          SizedBox(
            height: height * 0.11,
            child: FittedBox(
              alignment: Alignment.bottomCenter,
              child: Text(
                formatAmt(amt),
                style: Theme.of(context).textTheme.headline6,
                softWrap: true,
              ),
            ),
          ),
          SizedBox(
            height: 0.6 * height,
            child: Container(
              width: 15,
              margin: EdgeInsets.fromLTRB(3, height * 0.01, 5, height * 0.02),
              child: Stack(
                alignment: AlignmentDirectional.bottomStart,
                // Succedding children are placed on TOP of PREVIOUS child.
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                      color: const Color.fromRGBO(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  FractionallySizedBox(
                    heightFactor: factor,
                    child: Container(
                      decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(15)),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: height * 0.11,
            child: FittedBox(
              child: Text(
                day,
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
          ),
        ],
      );
    });
  }
}
