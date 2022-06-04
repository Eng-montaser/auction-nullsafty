import 'package:get/get.dart';

class Languages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'ar_SA': {
          'login': 'تسجيل الدخول',
          'setting': 'الإعدادات',
          'nodata': 'لا توجد بيانات',
          'miles': 'ميل',
          'cardetails': 'تفاصيل السيارة',
        },
        'en_US': {
          'setting': 'Settings',
          'nodata': 'Empty data',
          'miles': 'Miles',
          'cardetails': 'Car details',
        },
      };
}
