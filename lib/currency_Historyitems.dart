
import 'package:currency_converter/currency.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CurrencyHistoryItems extends StatelessWidget {
  final Currency currency;
  final String locale;

  const CurrencyHistoryItems({
    super.key,
    required this.currency,
    required this.locale,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white.withOpacity(0.2),
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        children: [
          Expanded(
            child: Text(
              '${currency.date}',
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                NumberFormat.currency(symbol: 'UZS  ').format(
                  double.tryParse('${currency.rate} '),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                (currency.diff?.startsWith('-') ?? false) ? '${currency.diff}' : '+${currency.diff}',
                style: TextStyle(
                    color: (currency.diff?.startsWith('-') ?? false)
                        ? Colors.red[800]
                        : Colors.green[800]),
              ),
              const SizedBox(
                width: 20,
              ),
              (currency.diff?.startsWith('-') ?? false)
                  ? Icon(
                      Icons.south_east,
                      color: Colors.red[800],
                    )
                  : Icon(
                      Icons.north_east,
                      color: Colors.green[700],
                    ),
            ],
          ),
        ],
      ),
    );
  }
}
