import 'package:currency_converter/app_helpers.dart';
import 'package:currency_converter/currency_items.dart';
import 'package:currency_converter/http_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'currency.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = false;
  List<Currency> _currencies = [];
  late RefreshController _refreshController;
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _refreshController = RefreshController();
    _selectedDate = DateTime.now();
    _getCurrencies();
  }

  Future<void> _getCurrencies() async {
    setState(() {
      _isLoading = true;
      _currencies = [];
    });
    final client = GetIt.I.get<HttpService>().client();
    final response = await client.get('/uz/arkhiv-kursov-valyut/json/all/');
    debugPrint('===> $response');
    setState(() {
      _isLoading = false;
      _currencies = CurrencyResponse
          .fromJson(response.data)
          .data ?? [];
    });
    _refreshController.loadComplete();
  }

  Future<void> _refreshCurency() async {
    final client = GetIt.I.get<HttpService>().client();
    final response = await client.get('/uz/arkhiv-kursov-valyut/json/all/');
    debugPrint('===> $response');
    setState(() {
      _isLoading = false;
      _currencies = CurrencyResponse
          .fromJson(response.data)
          .data ?? [];
    });
    _refreshController.refreshCompleted();
  }

  void dispose() {
    super.dispose();
    _refreshController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            OutlinedButton(
              onPressed: () {
                showDatePicker(context: context,
                    initialDate: _selectedDate,
                    firstDate: (DateTime.now().subtract(
                        const Duration(days: 30))),
                    lastDate: DateTime.now()
                );
              },
              child: Text(
                AppHelpers.getFormattedDate(_selectedDate),
              ),
            ),
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : SmartRefresher(
                controller: _refreshController,
                onRefresh: _refreshCurency,
                child: ListView.builder(
                    itemCount: _currencies.length,
                    itemBuilder: (context, index) {
                      return CurrencyItems(
                        currency: _currencies[index],
                      );
                    }),
              ),
            ),
          ],
        ));
  }
}
