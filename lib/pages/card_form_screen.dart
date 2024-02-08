import 'package:flutter/material.dart';


class CardFormScreen extends StatelessWidget {
  const CardFormScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pay with a Credit Card'),
      ),
      body: const Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [

                ],
              ),
            )
    );
          }
}
