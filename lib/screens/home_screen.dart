import 'package:flutter/material.dart';
import 'package:renshu/screens/question_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> examList = [
    '2011_1',
    '2011_2',
    '2012_1',
    '2012_2',
    '2013_1',
    '2013_2',
    '2014_1',
    '2014_2',
    '2015_1',
    '2015_2',
    '2016_1',
    '2016_2',
    '2017_1',
    '2017_2',
    '2018_1',
    '2018_2',
    '2019_1',
    '2019_2',
    '2020_1',
    '2020_2',
    '2021_1',
    '2021_2',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: Card(
          elevation: 8.0,
          child: GridView.builder(
            itemCount: examList.length,
            itemBuilder: (context, index) {
              return InkWell(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.blue[800]?.withOpacity(index /
                        examList.length), // Different color for each item
                  ),
                  child: Center(
                    child: Text(
                      examList[index],
                      style: const TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  List<String> valueList = examList[index].split('_');
                  String year;
                  if (valueList[1] == '1') {
                    year = '${valueList[0]}_first';
                  } else {
                    year = '${valueList[0]}_second';
                  }
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => QuestionScreen(
                        year: year,
                        question: examList[index],
                      ),
                    ),
                  );
                },
              );
            },
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, // Three columns
              mainAxisSpacing: 10, // Spacing between rows
              crossAxisSpacing: 10, // Spacing between columns
            ),
          ),
        ),
      ),
    );
  }
}
