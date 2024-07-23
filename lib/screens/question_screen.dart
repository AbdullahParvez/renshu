import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_excel/excel.dart';

import '../widgets/answer_bottom_sheet.dart';
import '../widgets/option_card.dart';
import '../widgets/text_and_image_card.dart';
import '../widgets/text_only_card.dart';
import 'full_screen.dart';

class QuestionScreen extends ConsumerStatefulWidget {
  const QuestionScreen({super.key, required this.year, required this.question});
  final String year;
  final String question;
  @override
  ConsumerState<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends ConsumerState<QuestionScreen> {
  final List _items = [];
  bool showSpinner = true;
  int itemCount = 0;
  int selectedAnswer=0;

// Fetch content from the json file
  Future<void> readJson() async {
    ByteData xlData =
        await rootBundle.load("assets/question/${widget.question}.xlsx");
    var bytes =
        xlData.buffer.asUint8List(xlData.offsetInBytes, xlData.lengthInBytes);
    var excel = Excel.decodeBytes(bytes);

    for (var table in excel.tables.keys) {
      var count = 0;

      for (var row in excel.tables[table]!.rows) {
        if (count > 0) {
          var textJpn = row[9]?.value;
          var option_1Jpn = row[10]?.value;
          var option_2Jpn = row[11]?.value;
          var option_3Jpn = row[12]?.value;
          var option_4Jpn = row[13]?.value;
          var textEng = row[1]?.value;
          String? option_1Eng = row[3]?.value;
          String? option_2Eng = row[4]?.value;
          String? option_3Eng = row[5]?.value;
          String? option_4Eng = row[6]?.value;
          var mainTextPic = row[2]?.value;
          var ans = row[7]?.value;
          var explanation = row[14]?.value;
          _items.add({
            'textJpn': textJpn,
            'option_1Jpn': option_1Jpn,
            'option_2Jpn': option_2Jpn,
            'option_3Jpn': option_3Jpn,
            'option_4Jpn': option_4Jpn,
            'textEng': textEng,
            'option_1Eng': option_1Eng,
            'option_2Eng': option_2Eng,
            'option_3Eng': option_3Eng,
            'option_4Eng': option_4Eng,
            'mainTextPic': mainTextPic,
            'ans': ans,
            'explanation': explanation,
          });
        }
        if (count == 50) {
          break;
        }
        count++;
      }
    }
    Timer(const Duration(seconds: 1), () {
      setState(() {
        showSpinner = false;
      });
    });
  }

  @override
  void initState() {
    readJson();
    super.initState();
  }

  Widget checkQuestionHaveFigure(question, figure, translation, itemCount) {
    if (figure == null || figure == '') {
      return TextOnlyCard(
        text: question,
        quesNo: itemCount,
        year: widget.year,
        translation: translation,
      );
    } else {
      return InkWell(
        child: TextAndImageCard(
          text: question,
          figure: figure,
          quesNo: itemCount,
          year: widget.year,
          translation: translation,
        ),
        onDoubleTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) =>
                  FullScreen(question, translation, figure, widget.year),
            ),
          );
        },
      );
    }
  }

  Color? optionOneBorderColor = Colors.grey;
  Color? optionTwoBorderColor = Colors.grey;
  Color? optionThreeBorderColor = Colors.grey;
  Color? optionFourBorderColor = Colors.grey;

  void setOptionBackgroundColor({
    Color? optionOneColor = Colors.grey,
    Color? optionTwoColor = Colors.grey,
    Color? optionThreeColor = Colors.grey,
    Color? optionFourColor = Colors.grey,
  }) {
    optionOneBorderColor = optionOneColor;
    optionTwoBorderColor = optionTwoColor;
    optionThreeBorderColor = optionThreeColor;
    optionFourBorderColor = optionFourColor;
  }

  void onSelectCard(int optionNo) {
    setState(
      () {
        selectedAnswer = optionNo;
        if (optionNo == 1) {
          setOptionBackgroundColor(optionOneColor: Colors.green[400]);
        } else if (optionNo == 2) {
          setOptionBackgroundColor(optionTwoColor: Colors.green[400]);
        } else if (optionNo == 3) {
          setOptionBackgroundColor(optionThreeColor: Colors.green[400]);
        } else if (optionNo == 4) {
          setOptionBackgroundColor(optionFourColor: Colors.green[400]);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // final Map<String, List<String>> commonVocabs =
    //     ref.watch(commonVocabProvider);
    final screen = MediaQuery.of(context).size;
    if (showSpinner) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Question'),
        ),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircularProgressIndicator(),
            ],
          ),
        ),
      );
    } else {
      var item = _items[itemCount];
      String question = item['textJpn'];
      String? figure = item['mainTextPic'];
      String option1 = item['option_1Jpn'];
      String option2 = item['option_2Jpn'];
      String option3 = item['option_3Jpn'];
      String option4 = item['option_4Jpn'];
      String translation = item['textEng'];
      String transOp1 = item['option_1Eng'];
      String transOp2 = item['option_2Eng'];
      String transOp3 = item['option_3Eng'];
      String transOp4 = item['option_4Eng'];
      String? explanation = item['explanation'];

      int ans;
      if (item['ans'].runtimeType==int){
        // print(item['ans'].runtimeType);
        ans = item['ans'];
      }else{
        // print(item['ans'].runtimeType);
        ans = int.parse(item['ans']);
      }
      final itemLength = _items.length;
      return Scaffold(
        appBar: AppBar(
          title: Text('${widget.question}     Question ${itemCount + 1}'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: screen.height * 0.35,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: screen.width * 1,
                    child: checkQuestionHaveFigure(
                        question, figure, translation, itemCount),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: screen.height * 0.01,
            ),
            SizedBox(
              height: screen.height * 0.20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  OptionCard(
                    optionNo: 1,
                    screen: screen,
                    year: widget.year,
                    option: option1,
                    translation: transOp1,
                    borderColor: optionOneBorderColor,
                    onSelectCard: onSelectCard,
                  ),
                  SizedBox(
                    width: screen.width * 0.02,
                  ),
                  OptionCard(
                    optionNo: 2,
                    screen: screen,
                    year: widget.year,
                    option: option2,
                    translation: transOp2,
                    borderColor: optionTwoBorderColor,
                    onSelectCard: onSelectCard,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: screen.height * 0.01,
            ),
            SizedBox(
              height: screen.height * 0.20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  OptionCard(
                    optionNo: 3,
                    screen: screen,
                    year: widget.year,
                    option: option3,
                    translation: transOp3,
                    borderColor: optionThreeBorderColor,
                    onSelectCard: onSelectCard,
                  ),
                  SizedBox(
                    width: screen.width * 0.02,
                  ),
                  OptionCard(
                    optionNo: 4,
                    screen: screen,
                    year: widget.year,
                    option: option4,
                    translation: transOp4,
                    borderColor: optionFourBorderColor,
                    onSelectCard: onSelectCard,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: screen.height * 0.02,
            ),
            SizedBox(
              height: screen.height * 0.08,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    iconSize: 40,
                    splashRadius: 50,
                    icon: const Icon(
                      Icons.keyboard_double_arrow_left,
                      color: Colors.lightBlueAccent,
                    ),
                    tooltip: 'Previous Question',
                    onPressed: () {
                      setState(
                        () {
                          if (itemCount > 0) {
                            itemCount = itemCount - 1;
                            item = _items[itemCount];
                          }
                          setOptionBackgroundColor();
                          selectedAnswer=0;
                        },
                      );
                    },
                  ),
                  FloatingActionButton.extended(
                    onPressed: () {
                      if (selectedAnswer!=0){
                        if (explanation != null){
                          showAnswerBottomSheet(
                              context, ans, selectedAnswer, explanation:explanation);
                        }else{
                          showAnswerBottomSheet(
                              context, ans, selectedAnswer);
                        }


                      }else{
                        final snackBar = SnackBar(
                          content: const Text('Please Select an Answer'),
                          action: SnackBarAction(
                            label: 'Undo',
                            onPressed: () {
                              // Some code to undo the change.
                            },
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                    label: const Text('Submit'),
                  ),

                  IconButton(
                    iconSize: 40,
                    splashRadius: 50,
                    splashColor: Colors.red,
                    icon: const Icon(
                      Icons.keyboard_double_arrow_right,
                      color: Colors.lightBlueAccent,
                    ),
                    tooltip: 'Next Question',
                    onPressed: () {
                      setState(
                        () {
                          if (itemCount < itemLength - 1) {
                            itemCount = itemCount + 1;
                            item = _items[itemCount];
                            selectedAnswer=0;
                            setOptionBackgroundColor();
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
  }
}

void showAnswerBottomSheet(
    BuildContext context, int answer, int selectedAnswer, {String explanation=''}) {
  final height = MediaQuery.of(context).size.height * 0.8;
  showModalBottomSheet(
    context: context,
    isScrollControlled: true, // Allow scrolling if image is large
    builder: (BuildContext context) {
      return AnswerBottomSheet(
        answer: answer,
        selectedAnswer: selectedAnswer,
        explanation: explanation,
        height: height,
      );
    },
  );
}
