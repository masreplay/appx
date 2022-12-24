import 'package:appx/client/client.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

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

Future<void> launchUrlOrDeepLink(
  BuildContext context, {
  required String url,
  required String deepLinkBaseUrl,
}) async {
  final router = context.router;

  final canLaunchUrl = await canLaunchUrlString(url);
  if (!canLaunchUrl) return;

  if (url.contains(deepLinkBaseUrl)) {
    final path = url.replaceAll(deepLinkBaseUrl, "");
    router.pushNamed(path);
  } else {
    await launchUrlString(url, mode: LaunchMode.externalApplication);
  }
}
