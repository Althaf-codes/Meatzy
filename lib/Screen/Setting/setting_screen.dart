import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../Service/firebase_auth_service.dart';
import '../../Widget/setting_screen_card.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Center(
            child: Text(
              'Settings',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 23,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 100,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.90,
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SettingCard(icon: Icons.person_outline, text: 'Account'),
                Divider(),
                const SizedBox(
                  height: 10,
                ),
                SettingCard(icon: FontAwesomeIcons.bell, text: 'Notification'),
                Divider(),
                const SizedBox(
                  height: 10,
                ),
                SettingCard(
                    icon: Icons.visibility_outlined, text: 'Appearance'),
                Divider(),
                const SizedBox(
                  height: 10,
                ),
                SettingCard(
                    icon: Icons.lock_outline, text: 'Privacy & Security'),
                Divider(),
                const SizedBox(
                  height: 10,
                ),
                SettingCard(icon: Icons.headphones, text: 'Help and Support'),
                Divider(),
                const SizedBox(
                  height: 10,
                ),
                SettingCard(
                    icon: FontAwesomeIcons.questionCircle, text: 'About'),
                Divider(),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () async {
                    await Provider.of<FirebaseAuthMethods>(context,
                            listen: false)
                        .signOut(context);
                    //await context.read<FirebaseAuthMethods>().signOut(context);
                  },
                  child: SettingCard(
                      icon: Icons.logout_outlined, text: 'Sign Out'),
                ),
                Divider(),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
