import 'dart:async';
import 'dart:convert';

import 'package:bloc_quotes_list/model/quote.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class QuoteState {
  final List<Quote>? quoteList;
  final List<Quote>? quoteList2;
  QuoteState({this.quoteList, this.quoteList2,});

  QuoteState copy({List<Quote>? quoteList, List<Quote>? quoteList2}) =>
      QuoteState(
        quoteList: quoteList ?? this.quoteList,
        quoteList2: quoteList2 ?? this.quoteList2,
      );
}

class ErrorState extends QuoteState {
  final String? message;
  ErrorState({this.message});
}

class QuoteBloc extends Cubit<QuoteState> {
  QuoteBloc() : super(QuoteState()) {
    getData();
    getData2();
  }

  Future<List<Quote>> _loadData() async {
    http.Response res =
        await http.get(Uri.https('dummyjson.com', 'quotes'));
    final Map<String, dynamic> jsonData = jsonDecode(res.body);
    final List<dynamic> list = jsonData['quotes'];
    return list.map((quote) => Quote.fromJson(quote)).toList();
  }

  Future<void> getData() async {
    try {
      final List<Quote> quote = await _loadData();
      emit(state.copy(quoteList: quote));
    } catch (e) {
      await Future.delayed(const Duration(seconds: 5));
      emit(ErrorState(message: "Lost connection"));
    }
  }

  Future<List<Quote>> _loadData2() async {
    http.Response res = await http.get(Uri.https('dummyjson.com', 'quotes'));
    final Map<String, dynamic> jsonData = jsonDecode(res.body);
    final List<dynamic> list = jsonData['quotes'];
    return list.map((quote) => Quote.fromJson(quote)).toList();
  }

  Future<void> getData2() async {
    final List<Quote> quote = await _loadData2();
    emit(state.copy(quoteList2: quote));
  }
}
