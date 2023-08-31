import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizz/model/QuizzModel.dart';
import 'package:quizz/providers/QuizzProvider.dart';
import 'package:quizz/widgets/CustomeButton.dart';
import 'package:http/http.dart' as http;

class QuizzPage extends StatelessWidget {
  const QuizzPage({super.key});

  @override
  Widget build(BuildContext context) {
    
    return ChangeNotifierProvider(
        create: (context) => QuizzProvider(),
        child: Scaffold(
          appBar: AppBar(
            title: Text("QIZZ APP"),
          ),
          body: Column(
            children: [
            Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius:
                    BorderRadius.all(Radius.elliptical(20, 20))),


                child: Consumer<QuizzProvider>(
                  builder: (context, quizzProvider, child) =>
                      Text(
                        "Question ${quizzProvider.numberOfQuestion} /10",
                        style: TextStyle(fontSize: 30),),
                )),
                Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius:
                        BorderRadius.all(Radius.elliptical(20, 20))),

                    child: Text(
                      "Score : 10",
                      style: TextStyle(fontSize: 30),
                    )),
                ],
              ),
              SizedBox(
                height: 80,
              ),


              FutureBuilder(
                future: getQuizz(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Colors.deepOrange,
                      ),
                    );
                  } else {
                    return Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(24),
                        decoration: BoxDecoration(
                            color: Colors.limeAccent,
                            borderRadius:
                            BorderRadius.all(Radius.elliptical(50, 50))),
                        child: Consumer<QuizzProvider>(
                          builder: (context, quizzProvider, child) =>
                              Text(
                                snapshot.data[quizzProvider.index].question,
                                style: TextStyle(fontSize: 40,),),
                        )

                      /*
                        child: Consumer<QuizzProvider>(
                            builder: (context, quizzProvider, child) => (Text(
                              quizzProvider.question,
                              style: TextStyle(fontSize: 40, ),
                            )))

                      */
                    );
                  }
                }
                ,
              ),

              SizedBox(
                height: 90,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomeButton(
                    action: "false",
                    buttonColor: Colors.red,
                    buttonShape: BoxShape.circle,
                    icon: Icons.cancel,
                    buttonSize: 60,
                  ),
                  SizedBox(width: 60),
                  CustomeButton(
                      action: "true",
                      buttonColor: Colors.green,
                      buttonShape: BoxShape.circle,
                      icon: Icons.check_circle_rounded,
                      buttonSize: 60)
                ],
              ),
            ],
          ),
        ));
  }

  Future<List<QuizzModel>> getQuizz() async {
    dynamic dataQuizz;
    List <QuizzModel> quizzModelList = [];

    String url = "https://opentdb.com/api.php?amount=10&category=31&difficulty=easy&type=boolean";

    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      dataQuizz = json.decode(response.body);

      for (int i = 0; i < dataQuizz["results"].length; i++) {
        quizzModelList.add(QuizzModel(
            question: dataQuizz["results"][i]["question"],
            correct_answer: dataQuizz["results"][i]["correct_answer"],
            incorrect_answer: dataQuizz["results"][i]["incorrect_answers"][0])

        );
      }
    }
    return quizzModelList;
  }

  // verifierReponse(String reponse){
  //   if(reponse == ){
  //
  //   }
  // }

}
























/*
  Container(
                margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(24),
                  decoration: BoxDecoration(
                      color: Colors.limeAccent,
                      borderRadius:
                          BorderRadius.all(Radius.elliptical(50, 50))),
                  child: Consumer<QuizzProvider>(
                      builder: (context, quizzProvider, child) => (Text(
                            quizzProvider.question,
                            style: TextStyle(fontSize: 40, ),
                          )))),
 */

