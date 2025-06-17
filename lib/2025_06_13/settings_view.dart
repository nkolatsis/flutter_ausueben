import 'package:flutter/material.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsList(
      sections: [
        SettingsSection(
          title: Text('Section'),
          tiles: [
            SettingsTile(
              title: Text('Language'),
              //subtitle: 'English',
              leading: Icon(Icons.language),
              onPressed: (BuildContext context) {},
            ),
            SettingsTile.switchTile(
              initialValue: false,
              title: Text('Use fingerprint'),
              leading: Icon(Icons.fingerprint),
              //switchValue: false,
              onToggle: (bool value) {},
            ),
          ],
        ),
      ],
    );
  }
}
