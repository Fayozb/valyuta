
import 'currency.dart';


class AppHelpers {
  static Currency getCurrentcurrency(List<Currency> histories, Currency currency) {
    for(Currency history in histories) {
      if(history.id == currency.id) {
        return history;
      }
    }
    return currency;
  }
  static String getFormattedDate(DateTime date) {
    return '${date.year}-${date.month > 9 ? date.month : '0${date
        .month}'}-${date.day > 9 ? date.day : '0${date.day}'}';
  }

  static String getCurrencyTitleByLocale(Currency currency, String locale) {
    switch (locale) {
      case 'uz' :
        return '${currency.ccyNmUZ}';
      case 'en' :
        return '${currency.ccyNmEN}';
      case 'ru' :
        return '${currency.ccyNmRU}';
      default:
        return '${currency.ccyNmUZ}';
    }
  }


  static String getHomePageNameByLocale(Currency currency, String locale) {
    switch (locale) {
      case 'uz' :
        return 'VALYUTA KURSLARI';
      case 'en' :
        return 'EXCHANGE RATES';
      case 'ru' :
        return 'ОБМЕННЫЕ КУРСЫ';
      default:
        return 'VALYUTA KURSLARI';
    }
  }


}
