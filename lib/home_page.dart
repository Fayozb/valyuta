
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:currency_converter/app_helpers.dart';
import 'package:currency_converter/currency_items.dart';
import 'package:currency_converter/drawer.dart';
import 'package:currency_converter/http_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'drawer.dart';
import 'currency.dart';
import 'app_helpers.dart';
import 'currency_items.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = false;
  List<Currency> _currencies = [];
  late RefreshController _refreshController;
  late DateTime _selectedDate;
  String _locale = 'uz';
  late Currency currency;
  late String locale ;


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
      currency = Currency();
      locale = 'uz';

    });
    final client = GetIt.I.get<HttpService>().client();
    final response = await client.get(
        '/uz/arkhiv-kursov-valyut/json/all/${AppHelpers.getFormattedDate(_selectedDate)}/');
    debugPrint('===> $response');
    setState(() {
      _isLoading = false;
      _currencies = CurrencyResponse.fromJson(response.data).data ?? [];
    });
    _refreshController.loadComplete();
  }

  Future<void> _refreshCurency() async {
    final client = GetIt.I.get<HttpService>().client();
    final response = await client.get(
        '/uz/arkhiv-kursov-valyut/json/all/${AppHelpers.getFormattedDate(_selectedDate)}/');
    debugPrint('===> $response');
    setState(() {
      _isLoading = false;
      _currencies = CurrencyResponse.fromJson(response.data).data ?? [];
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
      drawer: HomeDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
         title: Text(AppHelpers.getHomePageNameByLocale(currency,_locale),style: TextStyle(color: Colors.black),),
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_month,color: Colors.black,),
            onPressed: () async {
              final DateTime? changedDate = await showDatePicker(
                  context: context,
                  initialDate: _selectedDate,
                  firstDate:
                      (DateTime.now().subtract(const Duration(days: 30))),
                  lastDate: DateTime.now());
              if (changedDate != null) {
                setState(() {
                  _selectedDate = changedDate;
                  _getCurrencies();
                });
              }
            },
          ),
          PopupMenuButton(
            itemBuilder: (_) => [
              const PopupMenuItem(
                value: 'uz',
                child: Text('O\'zbekcha'),
              ),
              const PopupMenuItem(
                value: 'en',
                child: Text('English'),
              ),
              const PopupMenuItem(
                value: 'ru',
                child: Text('русский'),
              ),
            ],
            onSelected: (value) {
              setState(() {
                _locale = value;
              });
            },
          ),
        ],
      ),
      backgroundColor: Colors.lightBlueAccent,
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Expanded(child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : SmartRefresher(
                    controller: _refreshController,
                    onRefresh: _refreshCurency,
                    child: ListView.builder(
                        itemCount: _currencies.length,
                        itemBuilder: (context, index) {
                          return CurrencyItems(
                            currency: _currencies[index],
                            locale: _locale,
                          );
                        }),
                  ),
          ),
        ],
      ),
    );
  }
}


