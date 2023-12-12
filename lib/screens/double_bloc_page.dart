import 'package:bloc_quotes_list/bloc/quote_bloc.dart';
import 'package:bloc_quotes_list/model/quote.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoubleBlocPage extends StatefulWidget {
  const DoubleBlocPage({super.key});

  @override
  State<DoubleBlocPage> createState() => _DoubleBlocPageState();
}

class _DoubleBlocPageState extends State<DoubleBlocPage> {
  bool checkButton(List<Quote>? list1, List<Quote>? list2) {
    if (list1 != null && list2 != null) {
      return true;
    } else {
      return false;
    } 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<QuoteBloc, QuoteState>(
        builder: (context, state) {
          if(state is ErrorState) {
            return Center(child: Text(state.message!),);
          }
          return Column(
            children: [
              Expanded(
                child: state.quoteList != null
                    ? ListView.builder(
                        itemCount: state.quoteList!.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 16.0),
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(state.quoteList![index].id.toString()),
                                    Text(
                                      "\"${state.quoteList![index].quote}\"",
                                      style: const TextStyle(
                                          fontSize: 16.0,
                                          fontStyle: FontStyle.italic),
                                    ),
                                    Text(
                                      state.quoteList![index].author,
                                      style: const TextStyle(
                                          fontSize: 12.0, color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    : const Center(child: CircularProgressIndicator()),
              ),
              Container(
                width: double.infinity,
                height: 2.0,
                decoration: const BoxDecoration(color: Colors.pink),
              ),
              Expanded(
                child: state.quoteList2 != null
                    ? ListView.builder(
                        itemCount: state.quoteList2!.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 16.0),
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        state.quoteList2![index].id.toString()),
                                    Text(
                                      "\"${state.quoteList2![index].quote}\"",
                                      style: const TextStyle(
                                          fontSize: 16.0,
                                          fontStyle: FontStyle.italic),
                                    ),
                                    Text(
                                      state.quoteList2![index].author,
                                      style: const TextStyle(
                                          fontSize: 12.0, color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    : const Center(child: CircularProgressIndicator()),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: GestureDetector(
                  onTap: checkButton(state.quoteList, state.quoteList2) ? () {} : null,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16.0),
                    decoration: BoxDecoration(
                      color: checkButton(state.quoteList, state.quoteList2)
                          ? Colors.pinkAccent
                          : Colors.grey,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: const Text(
                      "Click me",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
