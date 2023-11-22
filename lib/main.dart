import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  dynamic text = '0';
  double numOne = 0;
  double numTwo = 0;

  dynamic result = '';
  dynamic finalResult = '';
  dynamic opr = '';
  dynamic preOpr = '';

  void calculation(String btnText) {
    if (btnText == 'AC') {
      setState(() {
        text = '0';
        numOne = 0;
        numTwo = 0;
        result = '';
        finalResult = '0';
        opr = '';
        preOpr = '';
      });
    } else if (opr == '=' && btnText == '=') {
      if (preOpr == '+') {
        setState(() {
          finalResult = add();
        });
      } else if (preOpr == '-') {
        setState(() {
          finalResult = sub();
        });
      } else if (preOpr == 'x') {
        setState(() {
          finalResult = mul();
        });
      } else if (preOpr == '/') {
        setState(() {
          finalResult = div();
        });
      }
    } else if (btnText == '+' ||
        btnText == '-' ||
        btnText == 'x' ||
        btnText == '/' ||
        btnText == '=') {
      if (numOne == 0) {
        setState(() {
          numOne = double.parse(result);
        });
      } else {
        setState(() {
          numTwo = double.parse(result);
        });
      }

      if (opr == '+') {
        setState(() {
          finalResult = add();
        });
      } else if (opr == '-') {
        setState(() {
          finalResult = sub();
        });
      } else if (opr == 'x') {
        setState(() {
          finalResult = mul();
        });
      } else if (opr == '/') {
        setState(() {
          finalResult = div();
        });
      }
      setState(() {
        preOpr = opr;
        opr = btnText;
        result = '';
      });
    } else if (btnText == '%') {
      setState(() {
        result = numOne / 100;
        finalResult = doesContainDecimal(result);
      });
    } else if (btnText == '.') {
      setState(() {
        if (!result.toString().contains('.')) {
          result = result.toString() + '.';
        }
        finalResult = result;
      });
    } else if (btnText == '+/-') {
      setState(() {
        result.toString().startsWith('-')
            ? result = result.toString().substring(1)
            : result = '-' + result.toString();
        finalResult = result;
      });
    } else {
      setState(() {
        result = result + btnText;
        finalResult = result;
      });
    }

    setState(() {
      text = finalResult;
    });
  }

  String add() {
    setState(() {
      result = (numOne + numTwo).toString();
      numOne = double.parse(result);
      finalResult = doesContainDecimal(result);
    });
    return finalResult;
  }

  String sub() {
    setState(() {
      result = (numOne - numTwo).toString();
      numOne = double.parse(result);
      finalResult = doesContainDecimal(result);
    });
    return finalResult;
  }

  String mul() {
    setState(() {
      result = (numOne * numTwo).toString();
      numOne = double.parse(result);
      finalResult = doesContainDecimal(result);
    });
    return finalResult;
  }

  String div() {
    setState(() {
      result = (numOne / numTwo).toString();
      numOne = double.parse(result);
      finalResult = doesContainDecimal(result);
    });
    return finalResult;
  }

  String doesContainDecimal(dynamic result) {
    if (result.toString().contains('.')) {
      List<String> splitDecimal = result.toString().split('.');
      if (!(int.parse(splitDecimal[1]) > 0))
        return result = splitDecimal[0].toString();
    }
    return result;
  }

  Widget calcButton(String btnText, Color btnColor, Color txtColor) {
    return Container(
      child: ElevatedButton(
        onPressed: () {
          calculation(btnText);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: btnColor,
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(20),
        ),
        child: Text(
          btnText,
          style: TextStyle(
            fontSize: 27,
            color: txtColor,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Calculator",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  text,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 100,
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calcButton("AC", Colors.grey, Colors.black),
                calcButton("+/-", Colors.grey, Colors.black),
                calcButton("%", Colors.grey, Colors.black),
                calcButton("/", Colors.amber, Colors.white),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calcButton("7", Colors.grey, Colors.black),
                calcButton("8", Colors.grey, Colors.black),
                calcButton("9", Colors.grey, Colors.black),
                calcButton("x", Colors.amber, Colors.white),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calcButton("4", Colors.grey, Colors.black),
                calcButton("5", Colors.grey, Colors.black),
                calcButton("6", Colors.grey, Colors.black),
                calcButton("-", Colors.amber, Colors.white),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calcButton("3", Colors.grey, Colors.black),
                calcButton("2", Colors.grey, Colors.black),
                calcButton("1", Colors.grey, Colors.black),
                calcButton("+", Colors.amber, Colors.white),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[850],
                        padding: const EdgeInsets.symmetric(
                            horizontal: 64, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () {
                        calculation("0");
                      },
                      child: const Text(
                        "0",
                        style: TextStyle(
                          fontSize: 27,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  calcButton(".", Colors.grey, Colors.black),
                  calcButton("=", Colors.amber, Colors.white),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
