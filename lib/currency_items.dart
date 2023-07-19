import 'package:currency_converter/converter_page.dart';
import 'package:currency_converter/currency.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'home_page.dart';

class CurrencyItems extends StatelessWidget {
  final Currency currency;
  const CurrencyItems({
    super.key,
    required this.currency,
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
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${currency.ccyNmUZ}'),
                Text(
                  NumberFormat.currency(symbol: 'UZS').format(
                    double.tryParse('${currency.rate} '),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${currency.ccy}'),
                SizedBox(
                  width: 260,
                ),
                (currency.diff?.startsWith('-') ?? false)
                    ? Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.red,
                      )
                    : Icon(
                        Icons.keyboard_arrow_up,
                        color: Colors.green,
                      ),
                Text('${currency.diff}'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
