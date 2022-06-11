import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const JApp());
}

class JApp extends StatelessWidget {
  const JApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JCalculator - a calculator made with flutter',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: const JCalculator(title: 'Flutter Demo Home Page'),
    );
  }
}
class JCalculator extends StatefulWidget {
  const JCalculator({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<JCalculator> createState() => _JCalculatorState();
}

class _JCalculatorState extends State<JCalculator> {
  // bg color
  Color bgColor = const Color(0XFF161f2f); //#161f2f Color(0XFF2A2A2A);
  Color outputBgColor = const Color(0XFF88a273);

  var answer = '';
  double fontSize = 50;

  List<String> buttons = [
    "AC", "C", "%", "/",
    "7", "8", "9", "x",
    "4", "5", "6", "-",
    "1", "2", "3", "+",
    "0", ".", "AC", "="
  ];
  late TextEditingController controller;

  //initialize controller
  @override
  void initState() {
    controller = TextEditingController()
      ..addListener(() {
        doCalculation();
      });
    super.initState();
  }

  //dispose
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:  <Widget>[
            Flexible(child:
           FractionallySizedBox(
             heightFactor: 1,
             widthFactor: 1,
             child: Container(
               padding: const EdgeInsets.only(top: 50),
               child:Container( //outer
                 margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                 decoration: outputBoxDecOuter(),
                 child: Container(
                   margin: const EdgeInsets.all(8),
                   decoration: outputBoxDecInner(),
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.end,
                     crossAxisAlignment: CrossAxisAlignment.end,
                     children: [
                       Container( //first container expression and answer
                         padding: const EdgeInsets.symmetric(horizontal: 10),
                         margin: const EdgeInsets.only(bottom: 0),
                         child:  TextField( //input expression
                           textAlign: TextAlign.right,
                           controller: controller,
                           keyboardType: TextInputType.none,
                           style:  TextStyle(fontSize:fontSize,
                             fontWeight: FontWeight.normal, decoration: TextDecoration.none,),
                           decoration: const InputDecoration(
                               enabledBorder: InputBorder.none,
                               border: InputBorder.none,
                               focusedBorder: InputBorder.none,
                             hintText: "0.0",
                             hintTextDirection: TextDirection.rtl
                           ),
                         ),
                       ),
                       Container(
                         //the answer container
                         padding: const EdgeInsets.symmetric(horizontal: 10),
                         margin: const EdgeInsets.only(bottom: 20),
                         child:  Text(answer,
                           style: const TextStyle(fontSize: 25),),
                       ),
                     ],
                   ),
                 ),
               )
             ),
           ),
            flex: 3,),
            Flexible(
              child: FractionallySizedBox(
                heightFactor: 1,
                widthFactor: 1,
                child: Container( //the btns
                  padding: const EdgeInsets.only(top: 28, left: 15, right: 15),
                  child:  GridView.builder(
                    itemCount: buttons.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                      itemBuilder: (context, index){
                        return inputButton(buttons.elementAt(index));
                      },
                  ),
                ),
              ),
            flex: 7,),
          ],
        ),
    );

  }

  BoxDecoration outputBoxDecOuter(){
    return BoxDecoration(
      borderRadius: BorderRadius.circular(25), //50 or 20
      color: bgColor,
      shape: BoxShape.rectangle,
      boxShadow: [
        BoxShadow(
          offset: - const Offset(2, 2),
          color: Colors.white24,
          blurRadius: 2.0,
          spreadRadius: 0.0,
        ),
        const BoxShadow(
          offset: Offset(2, 2),
          color: Colors.black,
          blurRadius: 2.0,
          spreadRadius: 0.0,
        ),
      ],
    );
  }
  BoxDecoration outputBoxDecInner(){
    return BoxDecoration(
      borderRadius: BorderRadius.circular(25), //50 or 20
      color: outputBgColor,
      shape: BoxShape.rectangle,
      boxShadow: [
        BoxShadow(
          offset: -const Offset(2, 2),
          color: Colors.white24,
          blurRadius: 2.0,
          spreadRadius: 0.0,
        ),
        const BoxShadow(
          offset: Offset(2, 2),
          color: Colors.black,
          blurRadius: 2.0,
          spreadRadius: 1.0,
        ),
      ],
    );
  }
  Widget inputButton(String text){
    return InkWell(
      onTap: (){
        setState(() { //change the input text field
          if(controller.text.length>=10){fontSize=40;}else{fontSize=50;}
          if(text =="AC"){controller.text = ""; answer ="";} //clear all
          else if(text =="C"){controller.text =controller.text.substring(0, controller.text.length - 1); if(controller.text.isEmpty){answer ="";} }
          else if(text =="="){}
          else {controller.text = controller.text +text;}
        });
      },
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Text(text,
               textAlign: TextAlign.center,
               style: const TextStyle(fontSize: 28, color: Colors.white70, fontWeight: FontWeight.bold,),
        ),
        decoration:BoxDecoration(
          borderRadius: BorderRadius.circular(50), //50 or 20
          color: bgColor,
          shape: BoxShape.rectangle,
          boxShadow: [
            BoxShadow(
              offset: -const Offset(2, 2),
              color: Colors.white24,
              blurRadius: 2.0,
              spreadRadius: 0.0,
            ),
            const BoxShadow(
              offset: Offset(2, 2),
              color: Colors.black,
              blurRadius: 2.0,
              spreadRadius: 0.0,
            ),
          ],
        ),
      ),
    );
  }

  void doCalculation() {
   var  expression = controller.text;
   expression = expression.replaceAll("x", "*");
   // if(expression.contains("x")){ }
   Parser p = Parser();
   Expression mathExpression = p.parse(expression);
   ContextModel cm = ContextModel();
   double eval = mathExpression.evaluate(EvaluationType.REAL, cm);
   answer = eval.toString();
    //var expression = controller.text.contains("X");

  }
}
