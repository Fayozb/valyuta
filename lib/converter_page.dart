import 'package:currency_converter/currency_items.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'currency.dart';

class ConverterPage extends StatefulWidget {
  final Currency currency;

  const ConverterPage({super.key, required this.currency});

  @override
  State<ConverterPage> createState() => _ConverterPageState();
}

class _ConverterPageState extends State<ConverterPage> {
  double _calculatedSum = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.currency.ccyNmUZ}'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            onChanged: (value) {
              setState(() {
                _calculatedSum = double.parse(widget.currency.rate ?? '') *
                    double.parse(value);
              });
            },
            decoration: InputDecoration(
                labelText: '${widget.currency.ccyNmUZ}',
                labelStyle: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: Color(0xFF4F4F51)),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFF4F4F51),
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFF4F4F51),
                  ),
                ),
          ),
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
        ],
      ),
    );
  }
}
