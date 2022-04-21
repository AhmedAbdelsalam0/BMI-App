import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  const Result(
      {Key? key, required this.result, required this.isMale, required this.age})
      : super(key: key);

  final double result;
  final bool isMale;
  final int age;

  String get resultPhrase{
    String resultText ="";

    if(result >= 30)
      resultText = "Obese";
    else if (result >=25 && result < 30)
      resultText = "OverWeight";
    else if (result >=20 && result <25)
      resultText = "Normal";
    else
      resultText = "Thin";

      return resultText;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Result"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Gender : ${isMale ? "Male" : "Female"}",
                style: Theme.of(context).textTheme.headline1,
              ),
              Text(
                "Age : $age",
                style: Theme.of(context).textTheme.headline1,
              ),Text(
                "Result : ${result.toStringAsFixed(2)}",  // to get just 2 numbers after .
                style: Theme.of(context).textTheme.headline1,
              ),Text(
                "Health : $resultPhrase",
                textAlign: TextAlign.center,  // it is useful if the text is long
                style: Theme.of(context).textTheme.headline1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
