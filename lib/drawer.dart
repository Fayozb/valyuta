import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';

import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context);

    return Drawer(
      child: Container(

        decoration: const BoxDecoration(

          gradient: LinearGradient(
            colors: [
              Color(0xFF00D0CE),
              Color(0xFF82E5BA),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Image.asset(
                  'assets/images/img.png',
                  width: 120,
                  height: 120,
                ),
                const SizedBox(height: 10),
                 Text(
                  '${translate?.currencyConverter}',
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
                const SizedBox(height: 10),
                drawerElement(
                  FlutterRemix.google_play_line,
                  '${translate?.rateonplaymarket}',
                  () {
                    launchUrl(
                      Uri.parse(
                          'https://play.google.com/store/apps/details?id=com.smartwho.SmartAllCurrencyConverter'),
                    );
                  },
                ),
                drawerElement(
                  FlutterRemix.github_line,
                  '${translate?.programcode}',
                  () {
                    launchUrl(
                      Uri.parse('https://github.com/Fayozb/valyuta-kursi'),
                    );
                  },
                ),
                drawerElement(
                  FlutterRemix.telegram_line,
                  '${translate?.ourtelegramchannel}',
                  () {
                    launchUrl(
                      Uri.parse('https://t.me/fayozbey2'),
                    );
                  },
                ),
                drawerElement(
                  FlutterRemix.facebook_box_line,
                  '${translate?.weareonfacebook}',
                  () {
                    launchUrl(
                      Uri.parse(
                          'https://www.facebook.com/profile.php?id=10008291042483'),
                    );
                  },
                ),
                drawerElement(
                  FlutterRemix.twitter_line,
                  '${translate?.weareontwitter}',
                  () {
                    launchUrl(
                      Uri.parse('https://twitter.com/'),
                    );
                  },
                ),
                drawerElement(
                  FlutterRemix.instagram_line,
                  '${translate?.weareoninstagram}',
                  () {
                    launchUrl(
                      Uri.parse('https://www.instagram.com/fayoz_karol/'),
                    );
                  },
                ),
                drawerElement(
                  FlutterRemix.chat_1_line,
                  '${translate?.opinionforconsideration}',
                  () {
                    launchUrl(
                      Uri.parse('https://t.me/fayozbey2'),
                    );
                  },
                ),
                drawerElement(
                  FlutterRemix.information_line,
                  '${translate?.abouttheprogram}',
                  () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xFF00D0CE),
                                  Color(0xFF82E5BA),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  '${translate?.currencyConverter}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20),
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  'v1.0.0'
                                  '',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                        text:
                                            '${translate?.thebank}',
                                        style: const TextStyle(
                                            color: Color(0xFF007C70),
                                            fontSize: 16,
                                            decoration:
                                                TextDecoration.underline),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            launchUrl(
                                                Uri.parse('https://cbu.uz'));
                                          },
                                        children: [
                                          TextSpan(
                                              text:
                                                  '${translate?.banktexti}',
                                              style: const TextStyle(fontSize: 16,color: Colors.black,decoration: TextDecoration.none),),
                                          TextSpan(
                                            text:
                                            'Apache License',
                                            style: const TextStyle(
                                                color: Color(0xFF007C70),
                                                fontSize: 16,
                                                decoration:
                                                TextDecoration.underline),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                launchUrl(
                                                    Uri.parse('https://www.apache.org'));
                                              },
                                          ),
                                          TextSpan(
                                            text: '${translate?.banktext}',style: const TextStyle(fontSize: 16,color: Colors.black,decoration: TextDecoration.none)
                                          )
                                        ]
                                    )
                                ),
                                const SizedBox(height: 30,),
                                const Text('@Fayoz_bek'),
                                const SizedBox(height: 20,),
                                Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Color(0xFF00D0CE),
                                        Color(0xFF82E5BA),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                  ),

                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      'Ok',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 18),
              child: Text(
                '©Secret_user',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget drawerElement(IconData iconData, String title, Function() onPressed) {
    return ListTile(
      onTap: onPressed,
      leading: Icon(iconData, color: Colors.black),
      title: Text(
        title,
        style: const TextStyle(
            fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black),
      ),
    );
  }
}
