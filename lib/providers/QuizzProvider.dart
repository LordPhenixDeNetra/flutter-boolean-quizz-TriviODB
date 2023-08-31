import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:quizz/model/QuizzModel.dart';

class QuizzProvider extends ChangeNotifier{

  int index = 0;
  int numberOfQuestion = 1;
  int score = 0;

  changeQuestion(){

    if(index < 10){
      numberOfQuestion++;
      index++;
      notifyListeners();

    }if(index == 10){

      numberOfQuestion = 1;
      index = 0;
      notifyListeners();
    }

  }



}

/*
    changScore(){
    score++;
    notifyListeners();
  }
 */