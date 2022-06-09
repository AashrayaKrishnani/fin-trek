import 'package:flutter/material.dart';

class NoTransactionsYet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 30, 10, 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Card(
                color: Theme.of(context).primaryColor,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text('You Savin\' Big Time eh? ;p',
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                            fontSize: 25,
                            color: Colors.white,
                          )),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(5, 35, 5, 10),
                height: 300,
                child: Image.asset(
                  'assets/images/waiting.png',
                  fit: BoxFit.cover,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
