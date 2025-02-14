// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import 'package:quotes_app/widgets/card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Quotes(),
    );
  }
}

class Quotes extends StatefulWidget {
  const Quotes({Key? key}) : super(key: key);

  @override
  State<Quotes> createState() => _QuotesState();
}

// class for card-quote(title, author)
class BestQuotes {
  String title;
  String author;
  BestQuotes({required this.title, required this.author});
}

class _QuotesState extends State<Quotes> {
  // list of all quotes
  List allQuotes = [
    BestQuotes(author: "autor  ", title: "write your quote"),
    
  ];

// To delete card-quote when clicking on delete icon
  delete(BestQuotes item) {
    setState(() {
      allQuotes.remove(item);
    });
  }

// To add new card-quote to the main screen when clicking on "ADD" in showModalBottomSheet
  addNewQuote() {
    setState(() {
      allQuotes.add(
        BestQuotes(author: myController1.text, title: myController2.text),
      );
    });
  }

// create 2 controllers to get the text from the textfield
  final myController1 = TextEditingController();
  final myController2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return Padding(
                  padding: const EdgeInsets.all(22),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextField(
                        controller: myController1,
                        decoration: InputDecoration(hintText: "Add new quote"),
                        maxLength: 20,
                      ),
                      SizedBox(
                        height: 22,
                      ),
                      TextField(
                        controller: myController2,
                        decoration: InputDecoration(hintText: "Add author"),
                        maxLength: 20,
                      ),
                      SizedBox(
                        height: 22,
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            addNewQuote();
                          },
                          child: Text(
                            "ADD",
                            style: TextStyle(fontSize: 22),
                          ))
                    ],
                  ),
                );
              },
              isScrollControlled: true);
        },
        backgroundColor: Colors.redAccent,
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Best Quotes",
          style: TextStyle(fontSize: 27),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: allQuotes
              .map((item) => CardWidget(
                    // To pass the( item inside the list) to "card.dart" file
                    item: item,
                    // To pass (the delete function) to "card.dart" file
                    delete: delete,
                  ))
              .toList(),
        ),
      ),
    );
  }
}
