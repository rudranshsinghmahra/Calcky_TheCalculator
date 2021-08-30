import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:auto_size_text/auto_size_text.dart';

void main() {
  runApp(Calculator());
}

class Calculator extends StatelessWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calcky',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Calcky(),
    );
  }
}

class Calcky extends StatefulWidget {
  const Calcky({Key? key}) : super(key: key);

  @override
  _CalckyState createState() => _CalckyState();
}

class _CalckyState extends State<Calcky> {

  String equation ="";
  String result ="0";
  String expression ="0";
  double equationFontSize = 48.0;
  double resultFontSize = 58.0;
  Color colorResult = Colors.black;
  Color colorEquation = Colors.black;

  buttonPressed(String buttonText){
    setState(() {
      if(buttonText == "C"){
        equation = "";
        result = "0";
        equationFontSize = 48.0;
        resultFontSize = 58.0;
        colorResult = Colors.black;
        colorEquation = Colors.black;
      }else if(buttonText == "⌫"){
        colorResult = Colors.black;
        colorEquation = Colors.black;
        equationFontSize = 58.0;
        resultFontSize = 48.0;
        equation = equation.substring(0,equation.length-1);
        if(equation==""){
          equation="0";
        }
      }
      else if(buttonText == "="){
        colorResult = Colors.redAccent;
        colorEquation = Colors.black54;
        equationFontSize = 38.0;
        resultFontSize = 58.0;

        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');

        

        try{
          Parser parser = new Parser();
          Expression exp = parser.parse(expression);
          ContextModel contextModel = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, contextModel)}';
        }
        catch(e){
          result="Error";
        }


      }else{
        colorResult = Colors.black54;
        colorEquation = Colors.black;
        equationFontSize = 58.0;
        resultFontSize = 38.0;
        if(equation == "0"){
          equation=buttonText;
        }else {
          equation = equation + buttonText;
        }
      }
    });
  }


  Widget buildButton(String buttonText,double buttonHeight,Color buttonColor){
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      color: buttonColor,
      child: TextButton(
        onPressed: ()=>buttonPressed(buttonText),
        child: Text(buttonText,style: TextStyle(fontSize: 30,fontWeight: FontWeight.normal,color: Colors.white),),
        style: ButtonStyle(
          shape: MaterialStateProperty.all<
              RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
              side: BorderSide(
                  color: Colors.white,
                  width: 1,
                  style: BorderStyle.solid),
            ),
          ),
          padding: MaterialStateProperty.all<EdgeInsets>(
              EdgeInsets.all(16)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CALCKY"),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.green,
                Colors.redAccent,
              ],
              begin: Alignment.centerRight,
              end: Alignment.bottomCenter
            )
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: AutoSizeText(
              equation,
              style: TextStyle(fontSize: equationFontSize,color: colorEquation),
              maxLines: 2,
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: AutoSizeText(
              result,
              style: TextStyle(fontSize: resultFontSize,color: colorResult),
              maxLines: 1,
            ),
          ),
          Expanded(child: Divider(color: Colors.white,)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.75,
                child: Table(
                  children: [
                    TableRow(children: [
                      buildButton("C", 1, Colors.redAccent),
                      buildButton("⌫", 1, Colors.green),
                      buildButton("÷", 1, Colors.green),
                    ]),TableRow(children: [
                      buildButton("7", 1, Colors.black54),
                      buildButton("8", 1, Colors.black54),
                      buildButton("9", 1, Colors.black54),
                    ]),TableRow(children: [
                      buildButton("4", 1, Colors.black54),
                      buildButton("5", 1, Colors.black54),
                      buildButton("6", 1, Colors.black54),
                    ]),TableRow(children: [
                      buildButton("1", 1, Colors.black54),
                      buildButton("2", 1, Colors.black54),
                      buildButton("3", 1, Colors.black54),
                    ]),TableRow(children: [
                      buildButton(".", 1, Colors.black54),
                      buildButton("0", 1, Colors.black54),
                      buildButton("00", 1, Colors.black54),
                    ]),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        buildButton("×", 1, Colors.green)
                      ]
                    ),TableRow(
                      children: [
                        buildButton("-", 1, Colors.green)
                      ]
                    ),TableRow(
                      children: [
                        buildButton("+", 1, Colors.green)
                      ]
                    ),TableRow(
                      children: [
                        buildButton("=", 2, Colors.redAccent)
                      ]
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
