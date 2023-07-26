
import 'package:currency_converter/currency_items.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'app_helpers.dart';
import 'app_provider.dart';
import 'currency.dart';
import 'currency_items.dart';
import 'home_page.dart';
import 'currency.dart';

class ConverterPage extends StatefulWidget {
  final Currency currency;
  final String locale;

  const ConverterPage({
    super.key,
    required this.currency,
    required this.locale,
  });

  @override
  State<ConverterPage> createState() => _ConverterPageState();
}

class _ConverterPageState extends State<ConverterPage> {
  double _calculatedSum = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppHelpers.getCurrencyTitleByLocale(
            widget.currency, widget.locale)),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            autofocus: true,
            onChanged: (value) {
              setState(() {
                _calculatedSum = double.parse(widget.currency.rate ?? '') *
                    double.parse(value);
              });
            },
            keyboardType: TextInputType.number,
            cursorColor: Color(0xFF4F4F51),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            NumberFormat.currency(symbol: 'UZS  ')
                .format(double.tryParse('${_calculatedSum} ')),
            style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 14,
                color: Colors.black45),
          ),
          SizedBox(
            height: 50,
          ),
          Center(
            child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
              onPressed: () {
                Navigator.pop(
                  context,
                  MaterialPageRoute(
                    builder: (_) => HomePage(),
                  ),
                );
              },
              child: Text(
                'Back',
                style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.w500,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
