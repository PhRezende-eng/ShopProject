import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MyProfileWidget extends StatelessWidget {
  const MyProfileWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () async {
              const url = 'https://github.com/PhRezende-eng';
              try {
                await canLaunch(url);
                launch(
                  url,
                  enableJavaScript: true,
                  forceSafariVC: true,
                  forceWebView: true,
                );
              } catch (error) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Não foi possível abrir o link'),
                  ),
                );
              }
            },
            child: const Image(
              image: AssetImage('assets/images/github.png'),
              fit: BoxFit.contain,
            ),
          ),
          GestureDetector(
            onTap: () async {
              const url = 'https://www.instagram.com/ph_rezende_/?hl=en_US';
              try {
                await canLaunch(url);
                launch(
                  url,
                  enableJavaScript: true,
                  forceSafariVC: true,
                  forceWebView: true,
                );
              } catch (error) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Não foi possível abrir o link'),
                  ),
                );
              }
            },
            child: const Image(
              image: AssetImage('assets/images/insta.png'),
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}
