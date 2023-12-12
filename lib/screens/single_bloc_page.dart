import 'package:bloc_quotes_list/bloc/quote_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SingleBlocPage extends StatefulWidget {
  const SingleBlocPage({super.key});

  @override
  State<SingleBlocPage> createState() => _SingleBlocPageState();
}

class _SingleBlocPageState extends State<SingleBlocPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<QuoteBloc, QuoteState>(
        builder: (context, state) {
          return state.quoteList != null
              ? ListView.builder(
                  itemCount: state.quoteList!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
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
                                    fontSize: 16.0, fontStyle: FontStyle.italic),
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
              : const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}