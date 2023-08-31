import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizz/providers/QuizzProvider.dart';

class CustomeButton extends StatelessWidget {
  final String action;
  final Color buttonColor;
  final Color iconColor;
  final BoxShape buttonShape;
  final IconData icon;
  final double buttonSize;

  CustomeButton({required this.action, required this.buttonColor, required this.buttonShape, required this.icon, this.buttonSize = 100, this.iconColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    var changeQuestion= Provider.of<QuizzProvider>(context, listen: false);
    // TODO: implement build
    return GestureDetector(
      onTap: () {
        if(action == "true"){
          changeQuestion.changeQuestion();

        }else if(action == "false"){
          changeQuestion.changeQuestion();
        }

      },
      child: UnconstrainedBox(
        child: Container(
          // width: 50,
          // height: 50,
          decoration: BoxDecoration(
            shape: this.buttonShape,
            color: this.buttonColor,
          ),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Icon(
              this.icon,
              color: this.iconColor,
              size: this.buttonSize,
            ),
          ),
        ),
      ),
    );
  }
}
