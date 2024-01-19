import 'dart:io';

import 'package:/constants/app_enum.dart';
import 'package:url_launcher/url_launcher.dart';

class AppServices {
  static platformCheck() {
    (Platform.isAndroid || Platform.isIOS)
        ? PlatformType.phone
        : PlatformType.web;
  }

  static launchEmail(
      {required emailAddress,
      required String subject,
      required String body}) async {
    final Uri emailUrl =
        Uri.parse('mailto:$emailAddress?subject=$subject&body=$body');
    await launchUrl(emailUrl);
  }
}
