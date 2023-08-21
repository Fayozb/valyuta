import 'package:currency_converter/app_helpers.dart';
import 'package:currency_converter/converter_page.dart';
import 'package:currency_converter/currency.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'home_page.dart';

class CurrencyItems extends StatelessWidget {
  final Currency currency;
  final String locale;
  final DateTime selectedDate;
  const CurrencyItems({
    super.key,
    required this.currency,
    required this.locale,
    required this.selectedDate
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ConverterPage(
              currency: currency,
              locale: locale,
              seledtedDate: selectedDate,
            ),
          ),
        );
      },
      child: Container(
        color: Colors.white.withOpacity(0.2),
        padding: const EdgeInsets.all(16),
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: [
            Expanded(
              child: Text(
                AppHelpers.getCurrencyTitleByLocale(currency, locale),
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
                SizedBox(
                  width: 20,
                ),
                Text(
                  '${(currency.diff?.startsWith('-') ?? false) ? '${currency.diff}' : '+${currency.diff}'}',
                  style: TextStyle(
                      color: (currency.diff?.startsWith('-') ?? false)
                          ? Colors.red[800]
                          : Colors.green[800]),
                ),
                SizedBox(
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
      ),
    );
  }
}
