import 'package:flutter/material.dart';
import 'package:in_app_update/in_app_update.dart';

class UpgradeAppScreen extends StatefulWidget {
  const UpgradeAppScreen({super.key});

  @override
  State<UpgradeAppScreen> createState() => _UpgradeAppScreenState();
}

class _UpgradeAppScreenState extends State<UpgradeAppScreen> {
  @override
  void initState() {
    super.initState();
    checkForUpdate();
  }

  Future<void> checkForUpdate() async {
    debugPrint('Checking for update...');
    InAppUpdate.checkForUpdate().then((info) {
      setState(() {
        if (info.updateAvailability == UpdateAvailability.updateAvailable) {
          debugPrint('Update available!');
          update();
        }
      });
    }).catchError((error) {
      debugPrint('Update error: $error');
    });
  }

  void update() async {
    debugPrint('Updating ...');
    await InAppUpdate.startFlexibleUpdate();
    InAppUpdate.completeFlexibleUpdate().then((_) {
      debugPrint('Update complete!');
    }).catchError((error) {
      debugPrint('Update error: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upgrade your app'),
      ),
      body: const Center(
        child: Text(
          'Upgrade your app',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
