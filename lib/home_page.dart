import 'package:currency_converter/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:currency_converter/app_helpers.dart';
import 'package:currency_converter/currency_items.dart';
import 'package:currency_converter/drawer.dart';
import 'package:currency_converter/http_service.dart';

import 'package:get_it/get_it.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'currency.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

  late Currency currency;
  late String locale;

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

  @override
  void dispose() {
    super.dispose();
    _refreshController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context);
    final provider = Provider.of<AppProvider>(context);
    return KeyboardDismisser(
      child: Scaffold(
        drawer: const HomeDrawer(),
        appBar: AppBar(
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: const Color(0xFF01CED8),
          title: Text(
            '${translate?.currencyConverter}',
            style: const TextStyle(color: Colors.black),
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.calendar_month,
              ),
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
                  child: Text('Русский'),
                ),
              ],
              onSelected: (value) {
                switch (value) {
                  case 'uz':
                    provider.setLocale('uz', '');
                    break;
                  case 'ru':
                    provider.setLocale('ru', '');
                    break;
                  case 'en':
                    provider.setLocale('en', '');
                    break;
                }
              },
            ),
          ],
        ),
        body: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xFF00D0CE), Color(0xFF82E58A)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight)),
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
                          locale: provider.locale?.languageCode ?? 'en',
                          selectedDate: _selectedDate,
                        );
                      }),
                ),
        ),
      ),
    );
  }
}
