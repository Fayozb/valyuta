
import 'package:currency_converter/currency_Historyitems.dart';
import 'package:currency_converter/currency_items.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'app_helpers.dart';
import 'app_provider.dart';
import 'currency.dart';
import 'currency_items.dart';
import 'home_page.dart';
import 'currency.dart';
import 'http_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class ConverterPage extends StatefulWidget {
  final Currency currency;
  final String locale;
  final DateTime seledtedDate;

  const ConverterPage({
    super.key,
    required this.currency,
    required this.locale,
    required this.seledtedDate
  });

  @override
  State<ConverterPage> createState() => _ConverterPageState();
}

class _ConverterPageState extends State<ConverterPage> {
  double _calculatedSum = 0;
  bool isUzsMain = false;
  TextEditingController? textEditingController;
  int tag = 0;
  String valyut = '';
  List<Currency> currencyHistorys = [];

  Future<void> getCurrencyHistorys() async {
    final client = GetIt.I.get<HttpService>().client();

    for(int i = 1; i < 8; i++) {
      final response = await client.get(
          '/uz/arkhiv-kursov-valyut/json/all/${AppHelpers.getFormattedDate(widget.seledtedDate.subtract(Duration(days: i)))}/');
      debugPrint('===> $response');
      List<Currency> currentcurrencies = CurrencyResponse.fromJson(response.data).data ?? [];
      setState(() {
        currencyHistorys.add(AppHelpers.getCurrentcurrency(currentcurrencies, widget.currency));
      });
    }

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _calculatedSum = double.parse(widget.currency.rate ?? '');
    textEditingController = TextEditingController();
    textEditingController?.text = '1';
    getCurrencyHistorys();

  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    textEditingController?.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: Color(0xFF00DDCE),
      appBar: AppBar(
        backgroundColor: Color(0xFF01CED8),
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 10,
        title: Text('${translate?.currencyConverter}',style: TextStyle(color: Colors.black),
           ),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(height: 24,),
              TextFormField(

                textAlign: TextAlign.end,
                keyboardType: TextInputType.number,
               cursorWidth: 2,
                controller: textEditingController,
                cursorColor: Colors.black,
                onChanged: (value) {
                  setState(() {
                    if (value.isEmpty) {
                      _calculatedSum = 0;
                    }
                    else {
                      _calculatedSum = double.parse(widget.currency.rate ?? '') *
                          double.parse(value);
                    }
                  });

                },

                decoration: InputDecoration(

                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black, width: 2)
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black,width: 2),

                  )
                ),


              ),
              SizedBox(
                height: 20,
              ),

                isUzsMain?Text('${translate?.uzbeksum}'):Text(AppHelpers.getCurrencyTitleByLocale(
                    widget.currency, widget.locale)),



              IconButton(onPressed: (){
                setState(() {
                  isUzsMain = !isUzsMain;
                  if (isUzsMain) {
                    _calculatedSum = double.parse(textEditingController?.text??'')/double.parse(widget.currency.rate ?? '');
                  } else {
                    _calculatedSum = double.parse(textEditingController?.text ?? '') * double.parse(widget.currency.rate ?? '');
                  }

                });
              }, icon: Icon(FlutterRemix.repeat_2_fill)),
              SizedBox(height: 20,),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black,width: 2)
                ),
                padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                alignment: Alignment.centerRight,
                child: Text(
                  NumberFormat.currency(symbol: '${isUzsMain? widget.currency.ccy : "UZS"}  ')
                      .format(double.tryParse('${_calculatedSum} ')),
                  style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 14,
                      color: Colors.black45),
                ),
              ),
              SizedBox(height: 20,),

                isUzsMain?Text(AppHelpers.getCurrencyTitleByLocale(
                    widget.currency, widget.locale)):Text('${translate?.uzbeksum}'),
              SizedBox(height: 40,),
              ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: currencyHistorys.length,
                  shrinkWrap: true,
                  itemBuilder: (context,index){
                return CurrencyHistoryItems(currency: currencyHistorys[index], locale: widget.locale);
              }),
              SizedBox(height: 40,)
            ],
          ),
        ),
      ),
    );
  }
}
