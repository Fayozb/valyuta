import 'package:flutter/material.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.lightBlueAccent,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            Image.asset(
              'assets/images/img.png',
              height: 150.0,
              width: 150.0,
            ),
            Center(
                child: Text(
              'Valyuta kurslari',
              style: TextStyle(fontSize: 20),
            )),
            SizedBox(
              height: 10,
            ),
            drawerElement('Play marketda baholang', Icon(Icons.person), () {
              // Navigator.push(context, MaterialPageRoute(builder: (_) =>));
            }),
            drawerElement('Dastur kodi', Icon(Icons.call_to_action), () {
              // Navigator.push(context, MaterialPageRoute(builder: (_) =>
            }),
            drawerElement('Telegram kanalimiz', Icon(Icons.telegram), () {
              // Navigator.push(context, MaterialPageRoute(builder: (_) =>));
            }),
            drawerElement('Biz Facebookda', Icon(Icons.facebook), () {
              // Navigator.push(context, MaterialPageRoute(builder: (_) =>));
            }),
            drawerElement('Biz Twittwerda', Icon(Icons.wb_twilight_outlined),
                () {
              // Navigator.push(context, MaterialPageRoute(builder: (_) =>));
            }),
            drawerElement('Biz Instagramda', Icon(Icons.install_desktop), () {
              // Navigator.push(context, MaterialPageRoute(builder: (_) =>));
            }),
            drawerElement('Fikr mulohaza', Icon(Icons.mark_as_unread_sharp),
                () {
              // Navigator.push(context, MaterialPageRoute(builder: (_) =>));
            }),
            drawerElement('Dastur haqida', Icon(Icons.info), () {
              // Navigator.push(context, MaterialPageRoute(builder: (_) =>));
            }),
            SizedBox(
              height: 10,
            ),
            Center(
                child: Text(
              '@Abdurazzoq',
              style: TextStyle(fontSize: 20),
            )),
            SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }

  Widget drawerElement(String title, Widget icon, Function() onPressed) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(fontSize: 16),
      ),
      leading: icon,
    );
  }
}
