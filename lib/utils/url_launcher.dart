import 'package:appx/client/client.dart';
import 'package:url_launcher/url_launcher.dart';

String? encodeQueryParameters(Map<String, String> params) {
  return params.entries
      .map((MapEntry<String, String> e) =>
          '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
      .join('&');
}

void launchEmail(
  String email, {
  String? subject,
  String? body,
}) {
  final uri = Uri(
    scheme: 'mailto',
    path: email,
    query: encodeQueryParameters(<String, String>{
      if (subject != null) 'subject': subject,
      if (body != null) 'body': body,
    }),
  );
  launchUrl(uri);
}

void launchSMS(PhoneNumber phoneNumber, {String? body}) {
  final uri = Uri(
    scheme: 'sms',
    path: phoneNumber.completeNumber,
    queryParameters: <String, String>{
      if (body != null) 'body': Uri.encodeComponent(body),
    },
  );
  launchUrl(uri);
}

void launchCall(PhoneNumber phoneNumber) {
  final uri = Uri(
    scheme: 'tel',
    path: phoneNumber.completeNumber,
  );
  launchUrl(uri);
}
