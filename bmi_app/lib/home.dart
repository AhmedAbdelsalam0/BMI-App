import 'dart:math';

import 'package:bmi_app/result.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isMale = true;
  double heightVal = 180;
  int weight = 85;
  int age = 25;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Body Mass Index"),
        centerTitle: true, // to let the title in the center
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    m1Expanded(context, "male"),
                    const SizedBox(
                      width: 15,
                    ),
                    m1Expanded(context, "female"),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.blueGrey,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Height" , style: Theme.of(context).textTheme.headline2,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        textBaseline: TextBaseline.alphabetic,  // it is necessary to use .baseLine
                        crossAxisAlignment: CrossAxisAlignment.baseline,  // to let cm exactly on the line
                        children: [
                          Text(heightVal.toStringAsFixed(1) , style: Theme.of(context).textTheme.headline1,),
                          Text("CM" , style: Theme.of(context).textTheme.bodyText1,),
                        ],
                      ),
                      Slider(
                        min: 50,
                        max: 220,
                        value: heightVal,
                        activeColor: Colors.black,
                        inactiveColor: Colors.white,
                        onChanged: (newValue) {
                          setState(() {
                            heightVal = newValue ;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    m2Expanded(context, "weight"),
                    const SizedBox(
                      width: 15,
                    ),
                    m2Expanded(context, "age"),
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.teal,
              ),
              height: MediaQuery.of(context).size.height * 0.07,
              width: MediaQuery.of(context).size.width * 0.9,
              child: TextButton(
                onPressed: () {
                  var result = weight / pow((heightVal / 100), 2);
                  print(result);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          Result(result: result, isMale: isMale, age: age),
                    ),
                  );
                },
                child: const Text(
                  "Calculate",
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.only(bottom: 20)),
          ],
        ),
      ),
    );
  }

  Expanded m1Expanded(BuildContext context, String type) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            isMale = (type == "male") ? true : false;
/*
            if(type == "male")
              {
                isMale = true;
                print(isMale);
              }
            else
              {
                isMale = false;
                print(isMale);
              }
   */
          });
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: (isMale && type == "male") || (!isMale && type == "female")
                ? Colors.teal
                : Colors.blueGrey,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                type == "male" ? Icons.male : Icons.female,
                size: 90,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                type == "male" ? "Male" : "Female",
                style: Theme.of(context).textTheme.headline2,
              )
            ],
          ),
        ),
      ),
    );
  }

  Expanded m2Expanded(BuildContext context, String type) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.blueGrey,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              type == "age" ? "Age" : "Weight",
              style: Theme.of(context).textTheme.headline2,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              type == "age" ? "$age" : "$weight",
              style: Theme.of(context).textTheme.headline1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  heroTag: type == "age" ? "age--" : "weight--",
                  onPressed: () {
                    setState(() {
                      type == "age" ? age-- : weight--;
                    });
                  },
                  mini: true,
                  child: const Icon(Icons.remove),
                ),
                const SizedBox(width: 10,),
                FloatingActionButton(
                  heroTag: type == "age" ? "age++" : "weight++",
                  onPressed: () {
                    setState(() {
                      type == "age" ? age++ : weight++;
                    });
                  },
                  mini: true,
                  child: const Icon(Icons.add),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
